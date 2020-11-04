unit frmMenuVendas;

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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Recursos.Comuns,
  Pattern.Observer,
  dmDatabase,
  Vcl.Imaging.pngimage;

type
  TfrmVendas = class(TForm, IObserver)
    pOpcoes: TPanel;
    Panel2: TPanel;
    pBts: TPanel;
    mLog: TMemo;
    pEncerrar: TPanel;
    btEncerrar: TButton;
    Image1: TImage;
    btPedido: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure btEncerrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btPedidoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure dpoReceberNotificacao(Notificacao: TDataNotify);
  end;

var
  frmVendas: TfrmVendas;

implementation

{$R *.dfm}

uses frmVendasPedidos;


procedure TfrmVendas.btPedidoClick(Sender: TObject);
var fp: TfrmPedidos;

begin
  if Not dmDb.UniConnection.Connected then  ShowMessage('Sem Conexão com a Base de Dados!')
  else begin
         fp:=TfrmPedidos.Create(nil);
         try
           fp.ShowModal;
         finally
           fp.Free
         end;
       end;
end;

procedure TfrmVendas.dpoReceberNotificacao(Notificacao: TDataNotify);
begin //Notificação InterClasses - Apenas um exemplo de utilização do Padrão de Design Observer
  mLog.Lines.Add('NIC: '+Notificacao.Informacao+' : '+Notificacao.Referencia);
end;

procedure TfrmVendas.btEncerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmVendas.FormCreate(Sender: TObject);
var Path: String;
begin
  dmDb.dpsAdicionarObserver(self);
  dmDb.ConectarDb;
  mLog.Clear;
  // LEIA-ME
  Path := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'leiame.txt';
  if Not FileExists(Path) then mLog.Lines.Add('o Arquivo LEIA-ME.TXT, "Diario de Bordo" do projeto, Não foi encontrado!')
  else  mLog.Lines.LoadFromFile(Path);
end;

procedure TfrmVendas.FormDestroy(Sender: TObject);
begin
  dmDb.dpsRemoverObserver(self);
end;

end.
