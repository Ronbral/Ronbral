unit frmConsultaPedido;

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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, System.UITypes,
  Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient;

type
  TfrmConsultas = class(TBaseForm)

    pBts: TPanel;
    pEncerrar: TPanel;
    btEncerrar: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    edNumPedido: TEdit;
    btConsultaPedido: TButton;
    DS: TDataSource;
    dbgPedido: TDBGrid;
    Panel3: TPanel;
    DBGrid2: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btExcluirPedido: TButton;
    cdsPedido: TClientDataSet;
    cdsPedidocds_tcl_codigo: TLargeintField;
    cdsPedidocds_tcl_nome: TStringField;
    cdsPedidocds_tcl_cidade: TStringField;
    cdsPedidocds_tcl_uf: TStringField;
    cdsPedidocds_tdg_pedido_numero: TLargeintField;
    cdsPedidocds_tdg_data_emissao: TDateTimeField;
    cdsPedidocds_tdg_valor_total: TCurrencyField;
    DSPedido: TDataSource;
    sPedido: TShape;
    lNumPedido: TLabel;
    lPedido: TLabel;
    procedure btEncerrarClick(Sender: TObject);
    procedure btConsultaPedidoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btExcluirPedidoClick(Sender: TObject);
    procedure edNumPedidoEnter(Sender: TObject);
    procedure edNumPedidoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edNumPedidoKeyPress(Sender: TObject; var Key: Char);  private
    procedure LimparCampos;
  private
    { Private declarations }
    FModoOperacao: Byte;
    FTitulo: String;
  public
    { Public declarations }
    property ModoOperacao: Byte write FModoOperacao;
    property Titulo: String write FTitulo;
  end;

var
  frmConsultas: TfrmConsultas;

implementation

{$R *.dfm}

procedure TfrmConsultas.btConsultaPedidoClick(Sender: TObject);
begin
  btConsultaPedido.Enabled := false;
  try
    if cdsPedido.Active then
       cdsPedido.EmptyDataSet;
    dmDb.LocalizarPedido(edNumPedido.Text);
    if Not dmDb.FQuery.Eof then
       begin
         DS.DataSet := dmDb.FQuery;
         lPedido.Visible := true;
         sPedido.Visible := true;
         lNumPedido.Visible := true;
         lNumPedido.Caption := FormatFloat('000000', dmDb.FQuery.FieldByName('tdg_pedido_numero').AsInteger);
         with cdsPedido, dmDb do
           begin
            FQuery.First;
            Append;
            FieldByName('cds_tcl_codigo').AsInteger := FQuery.FieldByName('tcl_codigo').AsInteger;
            FieldByName('cds_tcl_nome').AsString    := FQuery.FieldByName('tcl_nome').AsString;
            FieldByName('cds_tcl_cidade').AsString  := FQuery.FieldByName('tcl_cidade').AsString;
            FieldByName('cds_tcl_uf').AsString      := FQuery.FieldByName('tcl_uf').AsString;
            FieldByName('cds_tdg_pedido_numero').AsInteger := FQuery.FieldByName('tdg_pedido_numero').AsInteger;
            FieldByName('cds_tdg_data_emissao').AsDateTime := FQuery.FieldByName('tdg_data_emissao').AsDateTime;
            FieldByName('cds_tdg_valor_total').AsCurrency  := FQuery.FieldByName('tdg_valor_total').AsCurrency;
            Post;
           end;
       end;
  finally
    if dmDb.FQuery.Eof then
       begin
         lPedido.Visible := false;
         sPedido.Visible := false;
         lNumPedido.Visible := false;
         lNumPedido.Caption := ''; // <---
       end;
    edNumPedido.Clear;
    btConsultaPedido.Enabled := true;
  end;
end;

procedure TfrmConsultas.btEncerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConsultas.btExcluirPedidoClick(Sender: TObject);
begin
  if lNumPedido.Visible and
  Not dmDb.FQuery.Eof and
  cdsPedido.Active and
  (StrToIntDef(lNumPedido.Caption,0) > 0) and
  (MessageDlg('Confirma Exclusão do Pedido '+lNumPedido.Caption, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
     begin
       dmDb.ExcluirPedido(lNumPedido.Caption);
       LimparCampos;
     end;
end;

procedure TfrmConsultas.edNumPedidoEnter(Sender: TObject);
begin
  self.bsEditEnter(sender);
end;

procedure TfrmConsultas.edNumPedidoExit(Sender: TObject);
begin
  self.bsEditExit(sender);
end;

procedure TfrmConsultas.edNumPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then btConsultaPedidoClick(nil)
  else if Key=#27 then edNumPedido.Clear;
end;

procedure TfrmConsultas.FormCreate(Sender: TObject);
begin
  self.Width  := 800;
  self.Height := 600;
  cdsPedido.CreateDataSet;
end;

procedure TfrmConsultas.FormShow(Sender: TObject);
begin
  LimparCampos;
  self.pHeader.Caption := FTitulo;
  btExcluirPedido.Visible := (FModoOperacao=2);

end;

procedure TfrmConsultas.LimparCampos;
begin
  DS.DataSet := nil;
  edNumPedido.Clear;
  lNumPedido.Caption := '';
  dmDb.FQuery.Close;
  cdsPedido.EmptyDataSet;
  edNumPedido.SetFocus;
end;

end.
