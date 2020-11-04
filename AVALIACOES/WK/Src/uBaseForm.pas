unit uBaseForm;

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
    procedure EditEnter(Sender: TObject);
    procedure EditExit(Sender: TObject);

    procedure Wm_NCHitTest(var msg: TMessage); message wm_NCHitTest;
  end;

var
  BaseForm: TBaseForm;

implementation

{$R *.dfm}

(*
function RoundTo2dp(Value: Currency): Currency;
begin //Arredondamento simples
  Result := Trunc(Value*100+IfThen(Value>0, 0.5, -0.5))/100;
end;
*)


procedure TBaseForm.EditEnter(Sender: TObject);
begin
  if Sender is TEdit then
     TEdit(Sender).Color := $00A8FFFF;
end;

procedure TBaseForm.EditExit(Sender: TObject);
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
