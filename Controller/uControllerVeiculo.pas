unit uControllerVeiculo;

interface

uses uVeiculo, uDtoVeiculo, uResponse, uIRepositoryVeiculo, uEnums, uICasoUsoVeiculo,
  uCasoUsoVeiculo, uUtils;

type
  TControllerVeiculo  = class
  private
    Fcasouso: ICasoUsoVeiculo;
    procedure Setcasouso(const Value: ICasoUsoVeiculo);
  published

    function Cadastrar(nome, placa  :string;  valor :currency): String;
    function Alterar(id :integer; nome, placa, status  :string;  valor :currency): String;
    function Deletar(id :integer): String;
    function Consultar(id :integer; nome, placa  :string): String;
    property casouso  : ICasoUsoVeiculo read Fcasouso write Setcasouso;

    constructor create(repository : IRepositoryVeiculo);
    destructor destroy;override;

  end;

implementation

{ TControllerVeiculo }

function TControllerVeiculo.Alterar(id: integer; nome, placa, status: string;
  valor: currency): String;
var
  response  : TResponse;
  Veiculo   : TVeiculo;
  dto       : DtoVeiculo;
begin
  dto.Id  :=  id;

  response  :=  casouso.Consultar(dto);

  if (response.success) and (response.Message = RetornaMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO) then
    begin
      Veiculo :=  TVeiculo(response.Data[0]);

      if nome <> '' then begin
        Veiculo.Nome  := nome;
      end;

      if placa <> '' then begin
        Veiculo.Placa  := placa;
      end;

      if status <> '' then begin
        Veiculo.Status  := ConverteStrStatus(nome);
      end;

      if valor > 0 then begin
        Veiculo.Valor  := valor;
      end;

      response  :=  casouso.Alterar(Veiculo);
    end;

  if (response.success) and (response.Message = RetornaMsgResponse.ALTERADO_COM_SUCESSO) then
    Result :=  'Alterado com sucesso'
  else
    result :=  'Erro ao Alterar';
end;

function TControllerVeiculo.Cadastrar(nome, placa: string;
  valor: currency): String;
var
  response  : TResponse;
  Veiculo   : TVeiculo;
begin
  Veiculo.Nome    :=  nome;
  Veiculo.Placa   :=  placa;
  Veiculo.Valor   :=  valor;
  Veiculo.Status  :=  sDisponivel;

  response  :=  casouso.Cadastrar(Veiculo);

  Veiculo.free;

  if response.success then
    Result :=  'Cadastrado com sucesso'
  else
    result :=  'Erro ao cadastrar';
end;

function TControllerVeiculo.Consultar(id: integer; nome, placa: string): String;
var
  response  : TResponse;
  dto : DtoVeiculo;
begin
  dto.id        :=  id;
  dto.Nome      :=  nome;
  dto.Placa     :=  placa;

  response  :=  CasoUso.Consultar(dto);

  if response.success then
    result :=  response.Message
  else
    result  :=  'Erro ao consultar';
end;

constructor TControllerVeiculo.create(repository: IRepositoryVeiculo);
begin
  CasoUso :=  TCasoUsoVeiculo.create(repository);
end;
  
function TControllerVeiculo.Deletar(id: integer): String;
var
  response  : TResponse;
begin
  response  :=  CasoUso.Deletar(id);

  if response.success then
    Result :=  'Excluído com sucesso'
  else
    result :=  'Erro ao Excluir';
end;

destructor TControllerVeiculo.destroy;
begin

  inherited;
end;

procedure TControllerVeiculo.Setcasouso(const Value: ICasoUsoVeiculo);
begin
  Fcasouso := Value;
end;

end.
