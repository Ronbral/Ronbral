unit dmDatabase;

{------------------------------------------------------------------------------}
{                              AVALIACAO WK                                    }
{                                                                              }
{  PROJETO: Aplicacao de    ***** EMISSAO DE PEDIDOS DE VENDAS ******          }
{                                                                              }
{ Developed by: R Cabral                                                       }
{ Contact: ronbral@gmail.com                                                   }
{ 04/Out/2020                                                                  }
{------------------------------------------------------------------------------}


interface

uses
  System.SysUtils, System.Classes, UniProvider, MySQLUniProvider, Data.DB,
  Recursos.Comuns,
  Pattern.Observer,
  System.Generics.Collections,
  MIDASLib, Vcl.Dialogs, System.UITypes,
  DBAccess, Uni, Datasnap.DBClient, System.ImageList, Vcl.ImgList, Vcl.Controls;

type
  TdmDb = class(TDataModule, ISubject)
    UniConnection: TUniConnection;
    MySQLUniProvider: TMySQLUniProvider;
    ClientDataSet: TClientDataSet;
    ClientDataSetcds_codigo_produto: TStringField;
    ClientDataSetcds_descricao: TStringField;
    ClientDataSetcds_quantidade: TIntegerField;
    ClientDataSetcds_valor_unitario: TCurrencyField;
    ClientDataSetcds_valor_total: TCurrencyField;
    ImageList: TImageList;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure ClientDataSetCalcFields(DataSet: TDataSet);
    procedure ClientDataSetBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
    FObservers: TList<IObserver>;
    FCDSPronto : Boolean;
  public
    { Public declarations }
    FQuery: TUniQuery;
    //TDD - Todas as operações de banco podem ser testadas sem GUI apenas instanciando esta classe
    procedure ConectarDb;
    procedure PreparaClientDataset;
    function  TotalizaClientDataset: Extended;
    procedure AdicionaItemaLista(const p_quantidade: Integer; p_preco_unitario: Extended);
    procedure AdicionarNovoCliente(const p_codigo, p_nome, p_cidade, p_uf: String);
    procedure AdicionarNovoProduto(const p_codigo, p_descricao, p_preco: String);
    procedure LocalizarCliente(const p_codigo: String);
    procedure LocalizarProduto(const p_codigo: String);
    procedure LocalizarPedido(const p_codigo: String);
    procedure ExcluirPedido(const p_codigo: String);

    function  GravarNovoPedido(const p_codigo_cliente: String; p_valor_total: Currency): Int64;
    //Exemplo Pattern Observer
    procedure dpsEnviarNotificacao(Notificacao: TDataNotify);
    procedure dpsAdicionarObserver(Observer: IObserver);
    procedure dpsRemoverObserver(Observer: IObserver);
    procedure dpsMensagemInternaInterClasses(const Informacao, Referencia: String;
                                             Id: Integer=0; Valor: Extended=0.00);

    property ClientDataSetPronto: Boolean read FCDSPronto;
  end;

var
  dmDb: TdmDb;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmDb.DataModuleCreate(Sender: TObject);
begin
  FObservers := TList<IObserver>.Create; //Implementação Pattern Observer
  FQuery := TUniQuery.Create(self);
  FCDSPronto := false;
end;

procedure TdmDb.ClientDataSetBeforeDelete(DataSet: TDataSet);
begin
  if MessageDlg('Confirma Exclusão do Item selecionado?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
     Abort; //exceção silenciosa
end;

procedure TdmDb.ClientDataSetCalcFields(DataSet: TDataSet);
begin
  if (DataSet.FieldByName('cds_quantidade').AsInteger > 0) and
     (DataSet.FieldByName('cds_valor_unitario').AsCurrency > 0) then
     begin
       DataSet.FieldByName('cds_valor_total').AsCurrency := DataSet.FieldByName('cds_quantidade').AsInteger * DataSet.FieldByName('cds_valor_unitario').AsCurrency;
     end
  else DataSet.FieldByName('cds_valor_total').AsCurrency := 0; //Erro no Lançamento
end;

procedure TdmDb.ConectarDb;
var     sl: TStringList;
      Path: String;

begin
  sl:=TStringList.Create;
  try
     Path := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'config.ini';
     if Not FileExists(Path) then dpsMensagemInternaInterClasses('Arquivo CONFIG.INI Não encontrado!','Conectando ao Banco')
     else  with UniConnection do
             begin
               sl.LoadFromFile(Path);
               Server   := sl.Values['server'];
               Username := sl.Values['username'];
               Password := sl.Values['password']; //Usar Encriptação <---
               Port     := StrToIntDef(sl.Values['port'], 3306);
               Database := sl.Values['database'];
               if Database > '' then
                  try
                    UniConnection.Connect;
                    FQuery.Connection := UniConnection;
                    dpsMensagemInternaInterClasses('Conexão com o Banco de Dados efetuada com Sucesso!','Conectando ao Banco');
                  except
                    dpsMensagemInternaInterClasses('Sem conexão com o Banco de Dados','Conectando ao Banco');
                    raise Exception.Create('Parametros de Configuração inválidos! (Veja Config.Ini)');
                  end;
             end;
  finally
     sl.Free;
  end;
end;

procedure TdmDb.AdicionaItemaLista(const p_quantidade: Integer;
                                         p_preco_unitario: Extended);
begin
  if (p_quantidade > 0) and
     (p_preco_unitario > 0) and
     (Not FQuery.Eof) then
     with ClientDataset do
       begin
         Append;
         FieldByName('cds_codigo_produto').AsString   := FQuery.FieldByName('tpd_codigo').AsString;
         FieldByName('cds_descricao').AsString        := FQuery.FieldByName('tpd_descricao').AsString;
         FieldByName('cds_quantidade').AsInteger      := p_quantidade;
         FieldByName('cds_valor_unitario').AsCurrency := p_preco_unitario;
         Post;
       end
    else ShowMessage('Lançamento Inválido! Averigue a Quantidade e o Preço Unitário informado.');

end;

procedure TdmDb.AdicionarNovoCliente(const p_codigo, p_nome, p_cidade, p_uf: String);
var dml: String;
    Qry: TUniQuery;

begin
  dml := 'insert into test_db.tab_vendas_clientes (tcl_codigo, tcl_nome, tcl_cidade, tcl_uf)'+
         'values ('+QuotedStr(p_codigo)+', '+
                    QuotedStr(p_nome)+', '+
                    QuotedStr(p_cidade)+', '+
                    QuotedStr(p_uf)+')';
  Qry := TUniQuery.Create(nil);
  try
    UniConnection.AutoCommit := false;
    Qry.Connection := UniConnection;
    if not UniConnection.InTransaction then
         UniConnection.StartTransaction;
    try
      Qry.SQL.Text := dml;
      Qry.ExecSQL;
      UniConnection.Commit;
    except
      UniConnection.Rollback;
    end;
  finally
    Qry.Free;
    UniConnection.AutoCommit := true;
  end;
end;


procedure TdmDb.AdicionarNovoProduto(const p_codigo, p_descricao, p_preco: String);
var dml: String;
    Qry: TUniQuery;

begin
  dml := 'insert into test_db.tab_vendas_produtos (tpd_codigo, tpd_descricao, tpd_preco_venda)'+
         'values ('+QuotedStr(p_codigo)+', '+
                    QuotedStr(p_descricao)+', '+
                    p_preco+')';
  Qry := TUniQuery.Create(nil);
  try
    UniConnection.AutoCommit := false;
    Qry.Connection := UniConnection;
    if not UniConnection.InTransaction then
         UniConnection.StartTransaction;
    try
      Qry.SQL.Text := dml;
      Qry.ExecSQL;
      UniConnection.Commit;
    except
      UniConnection.Rollback;
    end;
  finally
    Qry.Free;
    UniConnection.AutoCommit := true;
  end;
end;


procedure TdmDb.dpsAdicionarObserver(Observer: IObserver);
begin
  FObservers.Add(Observer);
end;

procedure TdmDb.dpsEnviarNotificacao(Notificacao: TDataNotify);
var O: IObserver;

begin
  for O in FObservers do
      O.dpoReceberNotificacao(Notificacao);
end;

//Exemplo de comunicaçao interna utilizando Pattern Observer
procedure TdmDb.dpsMensagemInternaInterClasses(const Informacao,
  Referencia: String; Id: Integer; Valor: Extended);
var
      N: TDataNotify;
begin
  N.Informacao := DateTimeToStr(Now)+#32+Informacao;
  N.Referencia := Referencia;
  N.Id         := Id;
  N.Valor      := Valor;
  dpsEnviarNotificacao(N);
end;

procedure TdmDb.dpsRemoverObserver(Observer: IObserver);
begin
  FObservers.Delete(FObservers.IndexOf(Observer));
end;

function TdmDb.GravarNovoPedido(const p_codigo_cliente: String; p_valor_total: Currency): Int64;
const dml_itens='insert into test_db.tab_pedidos_produtos '+
                '(tpp_numero_pedido, tpp_codigo_produto, tpp_quantidade, tpp_valor_unitario, tpp_valor_total) '+
                'values (';

var dml: String;
    Qry: TUniSQL;
    id: Int64;

function Numeric(Vlr: Currency): String;
begin
  Result := StringReplace(FormatFloat('###,##0.00', Vlr), #44, #46, [rfReplaceAll]);
end;

begin
  Result := -1;
  if Not ClientDataSet.Active or Not FQuery.Active then
     begin
       Exit;
       // raise Falha interna na Gravação do Pedido!
     end;
  id := -1;
  Qry := TUniSQL.Create(nil);
  try
    UniConnection.AutoCommit := false;
    Qry.Connection := UniConnection;
    if not UniConnection.InTransaction then
         UniConnection.StartTransaction;
    try
      dml := 'insert into test_db.tab_pedidos_dados_gerais (tdg_data_emissao, tdg_codigo_cliente, tdg_valor_total) '+
             'values (CURRENT_DATE, '+
                      QuotedStr(p_codigo_cliente)+', '+
                      Numeric(p_valor_total)+')';

      Qry.SQL.Text := dml;
      Qry.Execute;
      id := Qry.LastInsertId;  //Equivalente a: select LAST_INSERT_ID();
      if id > -1 then //Confirma insert
         with ClientDataSet do
            begin
              DisableControls;
              try
                First;
                while Not Eof do
                  begin
                    dml := dml_itens+
                           IntToStr(ID)+', '+
                           FieldByName('cds_codigo_produto').AsString+', '+
                           FieldByName('cds_quantidade').AsString+', '+
                           Numeric(FieldByName('cds_valor_unitario').AsCurrency)+', '+
                           Numeric(FieldByName('cds_valor_total').AsCurrency)+')';
                    Qry.SQL.Text := dml;
                    Qry.Execute;
                    Next;
                  end;
              finally
                EnableControls;
              end;
            end;
      UniConnection.Commit;
    except
      UniConnection.Rollback;
    end;
  finally
    Qry.Free;
    UniConnection.AutoCommit := true;
    Result := id;
  end;
end;

procedure TdmDb.LocalizarCliente(const p_codigo: String);
var sql: String;

begin
  sql := 'select tcl_nome, tcl_cidade, tcl_uf from test_db.tab_vendas_clientes '+
         'where   '+
         'tcl_codigo='+QuotedStr(p_codigo);
  FQuery.Close;
  if trim(p_codigo) > '' then
     try
       FQuery.SQL.Text := sql;
       FQuery.Open;
       if FQuery.Eof then
          dpsMensagemInternaInterClasses('Consulta não retornou registros!','Localiza Cliente');
     except
       dpsMensagemInternaInterClasses('Erro na Consulta: '+sql,'Localiza Cliente');
       raise Exception.Create('Falha inexperada ao efetuar Consulta SQL.');
     end;
end;

procedure TdmDb.LocalizarPedido(const p_codigo: String);
var sql: String;

begin
  sql :=  'select c.tcl_codigo, c.tcl_nome, c.tcl_cidade, c.tcl_uf, '+
          'd.tdg_pedido_numero, d.tdg_data_emissao, d.tdg_valor_total, '+
          'p.tpd_codigo, p.tpd_descricao, '+
          'v.tpp_quantidade, v.tpp_valor_unitario, v.tpp_valor_total '+
          'from test_db.tab_pedidos_dados_gerais d, test_db.tab_pedidos_produtos v, test_db.tab_vendas_produtos p, test_db.tab_vendas_clientes c '+
          'where    '+
          '  d.tdg_pedido_numero='+QuotedStr(p_codigo)+' and '+
          '  d.tdg_pedido_numero=v.tpp_numero_pedido and '+
          '  v.tpp_codigo_produto=p.tpd_codigo and '+
          '  d.tdg_codigo_cliente=c.tcl_codigo';
  FQuery.Close;
  if trim(p_codigo) > '' then
     try
       FQuery.SQL.Text := sql;
       FQuery.Open;
       if FQuery.Eof then
          dpsMensagemInternaInterClasses('Consulta não retornou registros!','Localiza Pedidos');
     except
       dpsMensagemInternaInterClasses('Erro na Consulta: '+sql,'Localiza Pedidos');
       raise Exception.Create('Falha inexperada ao efetuar Consulta SQL.');
     end;
end;

procedure TdmDb.ExcluirPedido(const p_codigo: String);
var dml: String;
    Qry: TUniSQL;

begin
  if Not FQuery.Active then
     begin
       dpsMensagemInternaInterClasses('Falha interna. Dados do Pedido inacessiveis','ExcluirPedido');
       Exit;
       // raise Falha interna na Gravação do Pedido!
     end;

  Qry := TUniSQL.Create(nil);
  try
    UniConnection.AutoCommit := false;
    Qry.Connection := UniConnection;
    if not UniConnection.InTransaction then
         UniConnection.StartTransaction;
    try
      dml :=  'delete from test_db.tab_pedidos_produtos '+
              'where   '+
              'tpp_numero_pedido='+p_codigo;
      Qry.SQL.Text := dml;
      Qry.Execute;

      dml :=  'delete from test_db.tab_pedidos_dados_gerais '+
              'where   '+
              'tdg_pedido_numero='+p_codigo;
      Qry.SQL.Text := dml;
      Qry.Execute;

      UniConnection.Commit;
    except
      UniConnection.Rollback;
    end;
  finally
    Qry.Free;
    UniConnection.AutoCommit := true;
  end;
end;

procedure TdmDb.LocalizarProduto(const p_codigo: String);
var sql: String;

begin
  sql := 'select tpd_codigo, tpd_descricao, tpd_preco_venda from test_db.tab_vendas_produtos '+
         'where   '+
         'tpd_codigo='+QuotedStr(p_codigo);
  FQuery.Close;
  if trim(p_codigo) > '' then
     try
       FQuery.SQL.Text := sql;
       FQuery.Open;
       if FQuery.Eof then
          dpsMensagemInternaInterClasses('Consulta não retornou registros!','Localiza Produtos');
     except
       dpsMensagemInternaInterClasses('Erro na Consulta: '+sql,'Localiza Produtos');
       raise Exception.Create('Falha inexperada ao efetuar Consulta SQL.');
     end;
end;

procedure TdmDb.PreparaClientDataset;
begin
  with ClientDataSet do
    begin
      DisableControls;
      try
        CreateDataSet;
        Open;
        FCDSPronto := true;
      finally
        EnableControls;
      end;
    end;
end;

function TdmDb.TotalizaClientDataset: Extended;
var t: Currency;

begin
  t := 0;
  if ClientDataSet.Active then
     with ClientDataSet do
        begin
          DisableControls;
          try
            First;
            while Not Eof do
              begin
                t := t + FieldByName('cds_valor_total').AsCurrency;
                Next;
              end;
          finally
            EnableControls;
          end;
        end;
  Result := T;
end;

procedure TdmDb.DataModuleDestroy(Sender: TObject);
begin
  FObservers.Free;
end;

end.
