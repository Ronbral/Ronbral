unit frmBaseForm;

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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TBaseForm = class(TForm)
    pHeader: TPanel;
  private
    { Private declarations }

  public
    { Public declarations }
    procedure bsEditEnter(Sender: TObject);
    procedure bsEditExit(Sender: TObject);

    procedure Wm_NCHitTest(var msg: TMessage); message wm_NCHitTest;
  end;


implementation

{$R *.dfm}


procedure TBaseForm.bsEditEnter(Sender: TObject);
begin
  if Sender is TEdit then
     TEdit(Sender).Color := $00A8FFFF;
end;

procedure TBaseForm.bsEditExit(Sender: TObject);
begin
  if Sender is TEdit then
     TEdit(Sender).Color := clWhite;
end;

procedure TBaseForm.Wm_NCHitTest(var msg: TMessage);
begin // Habilita deslocamento da janela
  if GetAsyncKeyState(VK_LBUTTON) < 0 Then
     Msg.Result := HTCAPTION
  else Msg.Result := HTCLIENT;
end;

end.
