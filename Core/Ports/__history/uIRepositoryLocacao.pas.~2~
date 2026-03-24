unit uIRepositoryLocacao;

interface
uses  uLocacao, uDTOLocacao, System.Generics.Collections;

type

  IRepositoryLocacao  = interface
    procedure Cadastrar(locacao  : TLocacao);
    procedure Alterar(locacao  : TLocacao);
    procedure Excluir(id  : integer);
    function Consultar(dto : DtoLocacao) : TList<TLocacao>;
  end;

implementation

end.
