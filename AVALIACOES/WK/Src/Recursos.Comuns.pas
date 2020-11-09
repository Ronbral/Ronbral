unit Recursos.Comuns;

{------------------------------------------------------------------------------}
{ Developed by: R Cabral                                                       }
{ Contact: ronbral@gmail.com                                                   }
{ 04/Out/2020                                                                  }
{------------------------------------------------------------------------------}


interface

type
  { Pacote de dados --> Comunicacao interna Inter Classes }
  TDataNotify = record
                  Informacao,
                  Referencia: String;
                  Id: Integer;
                  Valor: Extended;
                end;

implementation

end.

