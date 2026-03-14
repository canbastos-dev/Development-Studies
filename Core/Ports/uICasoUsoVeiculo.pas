unit uICasoUsoVeiculo;

interface

uses uVeiculo, uResponse, uDTOVeiculo;

type
  ICasoUsoVeiculo = interface

  function Cadastrar(veiculo  : TVeiculo): TResponse;

  function Alterar(veiculo  : TVeiculo): TResponse;

  function Deletar(id  : integer): TResponse;

  function Consultar(dto  : DtoVeiculo): TResponse;

  end;

implementation

end.
