unit frmVendasPedidos;

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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  frmBaseForm,
  dmDatabase,
  System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, System.ImageList, Vcl.ImgList, Datasnap.DBClient;

type
  TfrmPedidos = class(TBaseForm)
    pBts: TPanel;
    pEncerrar: TPanel;
    btEncerrar: TButton;
    pLancamentos: TPanel;
    DS: TDataSource;
    dbgPedido: TDBGrid;
    btGravarPedido: TButton;
    btCancelarPedido: TButton;
    edCodCliente: TEdit;
    edCodProduto: TEdit;
    edQuant: TEdit;
    edPrecoUnit: TEdit;
    btConsultaCliente: TButton;
    btConsultaProduto: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btAdcProduto: TButton;
    lCliente: TLabel;
    lProduto: TLabel;
    lTotal: TLabel;
    Shape1: TShape;
    Label5: TLabel;
    btAtzTotal: TButton;
    btAbrirPedidos: TButton;
    spInfo: TShape;
    btExcluirPedido: TButton;
    procedure btEncerrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditEnter(Sender: TObject);
    procedure EditExit(Sender: TObject);
    procedure btConsultaClienteClick(Sender: TObject);
    procedure btConsultaProdutoClick(Sender: TObject);
    procedure btCancelarPedidoClick(Sender: TObject);
    procedure edCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edPrecoUnitKeyPress(Sender: TObject; var Key: Char);
    procedure edQuantKeyPress(Sender: TObject; var Key: Char);
    procedure btAdcProdutoClick(Sender: TObject);
    procedure dbgPedidoExit(Sender: TObject);
    procedure btAtzTotalClick(Sender: TObject);
    procedure btGravarPedidoClick(Sender: TObject);
    procedure btAbrirPedidosClick(Sender: TObject);
    procedure edCodClienteChange(Sender: TObject);
  private
    { Private declarations }
    procedure LimparCampos;
    procedure ajustarPaineldeLancamento(mode: byte=0);
  public
    { Public declarations }
  end;

var
  frmPedidos: TfrmPedidos;

implementation

{$R *.dfm}

uses frmConsultaPedido;


procedure TfrmPedidos.ajustarPaineldeLancamento(mode: byte);
begin
  if mode=0 then pLancamentos.Height := 98
  else pLancamentos.Height := 214;
  dbgPedido.Enabled := (mode > 0);
end;

procedure TfrmPedidos.btEncerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPedidos.btGravarPedidoClick(Sender: TObject);
var  tot: Extended;
      id: Int64;

begin
  if dbgPedido.Enabled then
     begin
       tot := dmDb.TotalizaClientDataset;
       lTotal.Caption := FormatFloat('###,##0.00', tot);
       try
         TButton(Sender).Enabled := false;
         if (tot > 0) and (MessageDlg('Confirma Gravação do Pedido na Base de Dados?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
            begin
              id := dmDb.GravarNovoPedido(edCodCliente.Text, tot);
              if (id > -1) and (id < 9999999) then //Sucesso
                 begin
                   pHeader.Caption := 'Pedido de Vendas ['+FormatFloat('00000', id)+']';
                   ShowMessage('Pedido '+IntToStr(id)+' criado com Sucesso!');
                   btCancelarPedidoClick(nil);
                 end;
            end;
       finally
         TButton(Sender).Enabled := true;
       end;
     end;
end;

procedure TfrmPedidos.dbgPedidoExit(Sender: TObject);
var  tot: Extended;

begin
  if dmDb.cdsProdutos.Active and (dmDb.cdsProdutos.RecordCount>0) then
     begin
       if dmDb.cdsProdutos.RecordCount=1 then //O Aggregate nao totalizar apenas um reg ---Bug??
          tot := dmDb.cdsProdutos.FieldByName('cds_valor_total').AsCurrency
       else tot := StrToFloat(dmDb.cdsProdutos.FieldByName('cds_totalizador').AsString);
       lTotal.Caption := FormatFloat('###,##0.00', tot);
     end;
end;

procedure TfrmPedidos.btConsultaProdutoClick(Sender: TObject);
begin
  btConsultaProduto.Enabled := false;
  try
    lProduto.Caption := '';
    dmDb.LocalizarProduto(edCodProduto.Text);
    if Not dmDb.FQuery.Eof then
       begin
         lProduto.Caption := dmDb.FQuery.FieldByName('tpd_descricao').AsString;
         edQuant.Text := '1';
         edPrecoUnit.Text := FormatFloat('###,##0.00', dmDb.FQuery.FieldByName('tpd_preco_venda').AsCurrency); //'0';
         edQuant.SetFocus;
       end
  finally
    btConsultaProduto.Enabled := true;
  end;
end;

procedure TfrmPedidos.edCodClienteChange(Sender: TObject);
begin
  btAbrirPedidos.Visible  := (trim(edCodCliente.Text)='');
  btExcluirPedido.Visible := (trim(edCodCliente.Text)='');
end;

procedure TfrmPedidos.edCodClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
     btConsultaClienteClick(nil);
end;

procedure TfrmPedidos.edCodProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
     btConsultaProdutoClick(nil);
end;

procedure TfrmPedidos.btAbrirPedidosClick(Sender: TObject);
var fc: TfrmConsultas;

begin
  if Not dmDb.UniConnection.Connected then  ShowMessage('Sem Conexão com a Base de Dados!')
  else begin
         fc:=TfrmConsultas.Create(nil);
         try
           fc.ModoOperacao := TButton(Sender).Tag; //1=Consulta 2=consulta/Exclusão
           if TButton(Sender).Tag=1 then fc.Titulo := 'Consultar Pedidos'
           else fc.Titulo := 'Excluir Pedidos';
           fc.ShowModal;
         finally
           fc.Free
         end;
       end;
end;

procedure TfrmPedidos.btAdcProdutoClick(Sender: TObject);
var     quant:  Integer;
     vlr_unit: Extended;

begin
  quant := StrToIntDef(edQuant.Text, 0);
  vlr_unit := StrToFloatDef(edPrecoUnit.Text, 0);
  if dmDb.FQuery.Active and
     (Assigned(dmDb.FQuery.FindField('tpd_codigo'))) and
     (edCodProduto.Text=dmDb.FQuery.FieldByName('tpd_codigo').AsString) then
     begin
       dmDb.AdicionaItemaLista(quant, vlr_unit);
       btAtzTotalClick(nil);
       edCodProduto.Clear;
       edQuant.Clear;
       edPrecoUnit.Clear;
       btGravarPedido.Enabled := true;
       edCodProduto.SetFocus;
     end;
end;

procedure TfrmPedidos.btAtzTotalClick(Sender: TObject);
begin
  {if dbgPedido.Enabled then} dbgPedidoExit(nil);
end;

procedure TfrmPedidos.btCancelarPedidoClick(Sender: TObject);
begin
  LimparCampos;
  ajustarPaineldeLancamento();
  if dmDb.cdsProdutos.Active then
     dmDb.cdsProdutos.EmptyDataSet;
  edCodCliente.SetFocus;
end;

procedure TfrmPedidos.btConsultaClienteClick(Sender: TObject);
begin
  btConsultaCliente.Enabled := false;
  lCliente.Caption := '';
  dmDb.LocalizarCliente(edCodCliente.Text);
  if Not dmDb.FQuery.Eof then
     begin
       lCliente.Caption := dmDb.FQuery.FieldByName('tcl_nome').AsString;
       ajustarPaineldeLancamento(1);
       //O Ideal seria poder Gera Numero do Pedido mesmo antes da Conclusão, para orientar o Operador <---
       if Not dmDb.ClientDataSetPronto then
          dmDb.PreparaClientDataset;
       edCodCliente.Enabled := false;
       spInfo.Visible := true;
       edCodProduto.SetFocus;
     end
  else btConsultaCliente.Enabled := true;
end;

procedure TfrmPedidos.EditEnter(Sender: TObject);
begin
  self.bsEditEnter(sender);
end;

procedure TfrmPedidos.EditExit(Sender: TObject);
begin
  self.bsEditExit(sender);
end;

procedure TfrmPedidos.edPrecoUnitKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13) and (edPrecoUnit.Text > '') then btAdcProduto.SetFocus
  else if not (CharInSet(Key, ['0'..'9', #8, #44])) then Key := #0;
end;

procedure TfrmPedidos.edQuantKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then edPrecoUnit.setFocus;
end;

procedure TfrmPedidos.FormCreate(Sender: TObject);
begin
  LimparCampos;
  ajustarPaineldeLancamento();
end;

procedure TfrmPedidos.LimparCampos;
begin
  edCodCliente.Clear;
  edCodProduto.Clear;
  edQuant.Clear;
  edPrecoUnit.Clear;
  lCliente.Caption := '';
  lProduto.Caption := '';
  lTotal.Caption := '0,00';
  edCodCliente.Enabled := true;
  btConsultaCliente.Enabled := true;
  self.pHeader.Caption := 'Pedido de Vendas';
  spInfo.Visible := false;
  btGravarPedido.Enabled   := false;
end;

end.
