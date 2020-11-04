program AvaliacaoWK;

{------------------------------------------------------------------------------}
{                              AVALIACAO WK                                    }
{                                                                              }
{  PROJETO: Aplicacao de    ***** EMISSAO DE PEDIDOS DE VENDAS ******          }
{                                                                              }
{ Developed by: R Cabral                                                       }
{ Contact: ronbral@gmail.com                                                   }
{ 04/Out/2020                                                                  }
{------------------------------------------------------------------------------}


uses
  Vcl.Forms,
  frmMenuVendas in 'frmMenuVendas.pas' {frmVendas},
  frmBaseForm in 'frmBaseForm.pas',
  dmDatabase in 'dmDatabase.pas' {dmDb: TDataModule},
  frmVendasPedidos in 'frmVendasPedidos.pas' {frmPedidos},
  frmConsultaPedido in 'frmConsultaPedido.pas' {frmConsultas};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := True; // <---
  Application.CreateForm(TdmDb, dmDb);
  Application.CreateForm(TfrmVendas, frmVendas);
  Application.CreateForm(TfrmPedidos, frmPedidos);
  Application.CreateForm(TfrmConsultas, frmConsultas);
  Application.Run;
end.
