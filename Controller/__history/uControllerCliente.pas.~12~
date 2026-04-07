unit uControllerCliente;

interface
uses  uIRepositoryCliente, uCasoUsoCliente, uICasoUsoCliente, uResponse,
  uDTOCliente, uCliente, uEnums, uIPresenter;

type
  TControllerCliente  = class
  private
    FCasoUso: ICasoUsoCliente;
    FPresenter: IPresenter;
    procedure SetCasoUso(const Value: ICasoUsoCliente);
    procedure SetPresenter(const Value: IPresenter);
  published

  function Cadastrar(nome, documento, cep, logradouro, complemento, bairro,
    cidade, uf, telefone  : string)  : string;

  function Alterar(id : integer; nome, documento, cep, logradouro, complemento, bairro,
    cidade, uf, telefone  : string)  : string;

  function Deletar(id : integer)  : string;
  function Consultar(id :integer; nome, documento : string)  : string;

  property CasoUso : ICasoUsoCliente read FCasoUso write SetCasoUso;
  property Presenter  : IPresenter read FPresenter write SetPresenter;

  constructor create(repository : IRepositoryCliente; presenter : IPresenter);
  destructor  destroy;override;

  end;

implementation

{ TControllerCliente }

function TControllerCliente.Alterar(id: integer; nome, documento, cep,
  logradouro, complemento, bairro, cidade, uf, telefone: string): string;
var
  response  : TResponse;
  cliente   : TCliente;
  dto       : DtoCliente;
begin
  dto.id  :=  id;
  dto.Nome  :=  '';
  dto.Documento :=  '';

  response  :=  CasoUso.Consultar(dto);

  if (response.success) and (response.Message = RetornaMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO) then
    begin

    cliente := TCliente(response.Data[0]);

    if nome <>  '' then begin
      cliente.Nome  :=  nome;
    end;

    if documento <>  '' then begin
      cliente.Documento  :=  documento;
    end;

    if cep <>  '' then begin
      cliente.Cep  :=  cep;
    end;

      if logradouro <>  '' then begin
      cliente.Logradouro  :=  logradouro;
    end;

      if complemento <>  '' then begin
      cliente.Complemento  :=  complemento;
    end;

    if bairro <>  '' then begin
      cliente.Bairro  :=  bairro;
    end;

    if cidade <>  '' then begin
      cliente.Cidade  :=  cidade;
    end;

    if uf <>  '' then begin
      cliente.UF  :=  uf;
    end;

    if telefone <>  '' then begin
      cliente.Telefone  :=  telefone;
    end;

    response  :=  CasoUso.Alterar(cliente);
  end;

  result  :=  Presenter.ConverterResponse(response);

  //if (response.success) and (response.Message = RetornaMsgResponse.ALTERADO_COM_SUCESSO) then
  //  Result :=  'Alterado com sucesso'
  //else
  //  result :=  'Erro ao Alterar';
end;

function TControllerCliente.Cadastrar(nome, documento, cep, logradouro,
  complemento, bairro, cidade, uf, telefone: string): string;
var
  Cliente : TCliente;
  response  : TResponse;
begin
  Cliente             :=  TCliente.Create;
  Cliente.Nome        := nome;
  Cliente.Documento   := documento;
  Cliente.Cep         := cep;
  Cliente.Logradouro  := logradouro;
  Cliente.Complemento := complemento;
  Cliente.Bairro      := bairro;
  Cliente.Cidade      := cidade;
  Cliente.UF          := uf;
  Cliente.Telefone    := telefone;

  response  := CasoUso.Cadastrar(Cliente);

  Cliente.Free;

  // O response recebido sera convertido em string ou stringJSon
  result  :=  Presenter.ConverterResponse(response);

  {if response.success then
    Result :=  'Cadastrado com sucesso'
  else
    result :=  'Erro ao cadastrar';}

end;

function TControllerCliente.Consultar(id: integer; nome,
  documento: string): string;
var
  response  : TResponse;
  dto : Dtocliente;
begin
  dto.id        :=  id;
  dto.Nome      :=  nome;
  dto.Documento :=  documento;

  response  :=  CasoUso.Consultar(dto);

  result  :=  Presenter.ConverterResponse(response);

  {  substituído pelo result acima
  if response.success then
    result :=  response.Message
  else
    result  :=  'Erro ao consultar';
  }

end;

// injeção de dependência do repository e do presenter
constructor TControllerCliente.create(repository: IRepositoryCliente; presenter : IPresenter);
begin
  self.Presenter  := presenter;
  CasoUso := TCasoUsoCliente.create(repository);
end;

function TControllerCliente.Deletar(id: integer): string;
var
  response  : TResponse;
begin
  response  :=  CasoUso.Deletar(id);

  result  :=  Presenter.ConverterResponse(response);

  {
  if response.success then
    Result :=  'Excluído com sucesso'
  else
    result :=  'Erro ao Excluir';}
end;

destructor TControllerCliente.destroy;
begin

  inherited;
end;

procedure TControllerCliente.SetCasoUso(const Value: ICasoUsoCliente);
begin
  FCasoUso := Value;
end;

procedure TControllerCliente.SetPresenter(const Value: IPresenter);
begin
  FPresenter := Value;
end;

end.
