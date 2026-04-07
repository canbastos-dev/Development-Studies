unit uIPresenter;

interface
uses uResponse, uCliente, system.Generics.Collections, uVeiculo, uLocacao;

type
  IPresenter  = interface

    function ConverterResponse(response :TResponse) : string;
    function ConverterCliente(cliente :TCliente) : string;
    function ConverterVeiculo(veiculo :TVeiculo) : string;
    function ConverterLocacao(locacao :TLocacao) : string;
    function ConverterLista(lista :TList<TObject>) : string;
  end;
implementation

end.
