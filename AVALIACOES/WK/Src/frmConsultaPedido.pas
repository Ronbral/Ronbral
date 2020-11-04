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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
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
    edCodCliente: TEdit;
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
    procedure btEncerrarClick(Sender: TObject);
    procedure btConsultaPedidoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btExcluirPedidoClick(Sender: TObject);
    procedure edCodClienteEnter(Sender: TObject);
    procedure edCodClienteExit(Sender: TObject);
    procedure FormShow(Sender: TObject);  private
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
  dmDb.LocalizarPedido(edCodCliente.Text);
  if Not dmDb.FQuery.Eof then
     begin
       DS.DataSet := dmDb.FQuery;

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
     end
  else btConsultaPedido.Enabled := true;

end;

procedure TfrmConsultas.btEncerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConsultas.btExcluirPedidoClick(Sender: TObject);
begin

  if StrToIntDef(edCodCliente.Text, 0) > 0 then
     dmDb.ExcluirPedido(edCodCliente.Text);
end;

procedure TfrmConsultas.edCodClienteEnter(Sender: TObject);
begin
  self.bsEditEnter(sender);
end;

procedure TfrmConsultas.edCodClienteExit(Sender: TObject);
begin
  self.bsEditExit(sender);
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
  edCodCliente.Clear;
  edCodCliente.SetFocus;
  DS.DataSet := nil;
  cdsPedido.EmptyDataSet;
end;

end.
