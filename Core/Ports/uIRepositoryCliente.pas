unit uIRepositoryCliente;

interface

uses uCliente, uDtoCliente, System.Generics.Collections;
type

  IRepositoryCliente  = interface
    procedure Cadastrar(cliente  : TCliente);
    procedure Alterar(cliente  : TCliente);
    procedure Excluir(id  : integer);
    //function Consultar(dto  : DtoCliente) : TObjectList<TCliente>;
    function Consultar(dto  : DtoCliente) : TList<TCliente>;
  end;
implementation

end.
