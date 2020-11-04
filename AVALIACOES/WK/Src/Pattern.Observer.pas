unit Pattern.Observer;

(*
	Subject: Interface que define a assinatura de métodos das classes que serão observáveis;
	Concrete Subject: implementação da Interface Subject;
	Observer: Interface que define a assinatura de métodos das classes que serão observadoras;
	Concrete Observer: implementação da Interface Observer;


*)


interface

uses
  Recursos.Comuns;

type

  { Observer }
  IObserver = interface

    // Método que será chamado pelo Subject
    procedure {Atualizar}dpoReceberNotificacao(Notificacao: TDataNotify);
  end;


  { Subject }
  ISubject = interface

    // Método para adicionar Observers à lista
    procedure dpsAdicionarObserver(Observer: IObserver);

    // Métodos para remover Observers da lista
    procedure dpsRemoverObserver(Observer: IObserver);

    // Método responsável por notificar os Observers registrados
    procedure dpsEnviarNotificacao(Notificacao: TDataNotify);
  end;

implementation

end.
