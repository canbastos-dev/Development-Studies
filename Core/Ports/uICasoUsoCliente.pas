unit uICasoUsoCliente;

interface

uses uCliente, uResponse, uDTOCliente;

type
  ICasoUsoCliente = interface

    function Cadastrar(cliente  : TCliente): TResponse;
    function Alterar(cliente  : TCliente): TResponse;
    function Deletar(id  : integer): TResponse;
    function Consultar(dto  : DtoCliente): TResponse;

  end;

implementation

end.
