unit Pattern.Observer;

(*
	Subject: Interface que define a assinatura de m�todos das classes que ser�o observ�veis;
	Concrete Subject: implementa��o da Interface Subject;
	Observer: Interface que define a assinatura de m�todos das classes que ser�o observadoras;
	Concrete Observer: implementa��o da Interface Observer;


*)


interface

uses
  Recursos.Comuns;

type

  { Observer }
  IObserver = interface

    // M�todo que ser� chamado pelo Subject
    procedure {Atualizar}dpoReceberNotificacao(Notificacao: TDataNotify);
  end;


  { Subject }
  ISubject = interface

    // M�todo para adicionar Observers � lista
    procedure dpsAdicionarObserver(Observer: IObserver);

    // M�todos para remover Observers da lista
    procedure dpsRemoverObserver(Observer: IObserver);

    // M�todo respons�vel por notificar os Observers registrados
    procedure dpsEnviarNotificacao(Notificacao: TDataNotify);
  end;

implementation

end.
