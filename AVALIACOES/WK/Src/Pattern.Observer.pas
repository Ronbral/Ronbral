unit Pattern.Observer;

{------------------------------------------------------------------------------}
{ Developed by: R Cabral                                                       }
{ Contact: ronbral@gmail.com                                                   }
{ 04/Out/2020                                                                  }
{------------------------------------------------------------------------------}

interface

uses
  Recursos.Comuns;

type

  { Observer }
  IObserver = interface

    // Entrada da Notifica��o ao Subject
    procedure dpoReceberNotificacao(Notificacao: TDataNotify);
  end;


  { Subject }
  ISubject = interface

    // Adicionar modulo como Observers (subscri��o)
    procedure dpsAdicionarObserver(Observer: IObserver);

    // Remo��o de Observer subscrito
    procedure dpsRemoverObserver(Observer: IObserver);

    // Notifica��o dos Observers registrados
    procedure dpsEnviarNotificacao(Notificacao: TDataNotify);
  end;

implementation

end.
