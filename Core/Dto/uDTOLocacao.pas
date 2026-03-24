unit uDTOLocacao;

interface

type
  DtoLocacao = record
    id            : integer;
    idcliente     : integer;
    datalocacao   : Tdatetime;
    datadevolucao : Tdatetime;
    status        : string;
  end;

implementation

end.
