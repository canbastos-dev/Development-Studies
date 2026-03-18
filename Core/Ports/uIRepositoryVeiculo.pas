unit uIRepositoryVeiculo;

interface

uses uVeiculo, uDtoVeiculo, System.Generics.Collections;

type

  IRepositoryVeiculo  = interface
    procedure Cadastrar(veiculo  : TVeiculo);
    procedure Alterar(veiculo  : TVeiculo);
    procedure Excluir(id  : integer);
    function Consultar(dto  : DtoVeiculo) : TList<TVeiculo>;
  end;

implementation

end.
