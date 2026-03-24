unit uICasoUsoLocacao;

interface

uses uLocacao, uResponse, uDtoLocacao;

type
  ICasoUsoLocacao = interface

    function Cadastrar(locacao  : TLocacao): TResponse;
    function Alterar(locacao  : TLocacao):  TResponse;
    function Consultar(dto : DtoLocacao)  : TResponse;
    function Deletar(id : integer)  : TResponse;

  end;

implementation

end.
