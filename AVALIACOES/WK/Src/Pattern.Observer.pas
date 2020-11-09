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

    // Entrada da Notificação ao Subject
    procedure dpoReceberNotificacao(Notificacao: TDataNotify);
  end;


  { Subject }
  ISubject = interface

    // Adicionar modulo como Observers (subscrição)
    procedure dpsAdicionarObserver(Observer: IObserver);

    // Remoção de Observer subscrito
    procedure dpsRemoverObserver(Observer: IObserver);

    // Notificação dos Observers registrados
    procedure dpsEnviarNotificacao(Notificacao: TDataNotify);
  end;

implementation

end.
