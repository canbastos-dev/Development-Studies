unit uControllerLocacao;

interface

uses uCliente, uVeiculo, ulocacao, uDTOLocacao, uDTOVeiculo, uDTOCliente,
  uIRepositoryLocacao, uIRepositoryVeiculo, uIRepositoryCliente, uICasoUsoLocacao,
  uICasoUsoVeiculo, uICasoUsoCliente, uEnums, uUtils, uCasoUsoLocacao, uCasoUsoVeiculo,
  uCasoUsoCliente, uResponse, system.SysUtils, uIPresenter;

type
  TControllerLocacao  = class
  private
    FCasoUsoVeiculo: ICasoUsoVeiculo;
    FCasoUsoCliente: ICasoUsoCliente;
    FCasoUsoLocacao: ICasoUsoLocacao;
    FPresenter: IPresenter;
    procedure SetCasoUsoCliente(const Value: ICasoUsoCliente);
    procedure SetCasoUsoLocacao(const Value: ICasoUsoLocacao);
    procedure SetCasoUsoVeiculo(const Value: ICasoUsoVeiculo);
    procedure SetPresenter(const Value: IPresenter);
  published

    function Cadastrar(idcliente, idveiculo : integer)  :string;
    function Alterar(idlocacao, idcliente, idveiculo  :integer;
     datadevolucao :Tdatetime)  :string;
    function Deletar(idlocacao  :integer) :string;
    function Consultar(idlocacao, idcliente :integer; datalocacao,
      datadevolucao :TDatetime) :string;

    property CasoUsoLocacao : ICasoUsoLocacao read FCasoUsoLocacao write SetCasoUsoLocacao;
    property CasoUsoCliente : ICasoUsoCliente read FCasoUsoCliente write SetCasoUsoCliente;
    property CasoUsoVeiculo : ICasoUsoVeiculo read FCasoUsoVeiculo write SetCasoUsoVeiculo;
    property Presenter      : IPresenter read FPresenter write SetPresenter;

    constructor create(repositoryLocacao  :IRepositoryLocacao;
      repositoryVeiculo  :IRepositoryVeiculo;
      repositoryCliente :IRepositoryCliente ;
      Presenter	: IPresenter);
    destructor destroy;override;

  end;

implementation

{ TControllerLocacao }

function TControllerLocacao.Alterar(idlocacao, idcliente, idveiculo: integer;
  datadevolucao: Tdatetime): string;
var
  response, responseVeiculo    : TResponse;
  cliente     : TCliente;
  veiculo     : TVeiculo;
  locacao     : TLocacao;
  _dtoCliente : DtoCliente;
  _dtoVeiculo : DtoVeiculo;
  _dtoLocacao : DtoLocacao;
begin

  if (datadevolucao = strtodate('30/12/1899')) and (idcliente=0) and (idveiculo=0) then begin
      response.Message  :=  'Data não pode ser vazia';
      response.ErrorCode  :=  RetornaErrorsCode.ID_INVALIDO;
      result  :=  Presenter.ConverterResponse(response);
      exit;
  end;


  if idcliente >  0 then begin
    _dtoCliente.id  :=  idcliente;
    response  :=  CasoUsoCliente.Consultar(_dtoCliente);

    if (response.success) and (response.Message = RetornaMsgResponse.CONSULTA_REALIZADA_SEM_RETORNO) then begin
      response.Message  :=  'id do cliente inválido';
      response.ErrorCode  :=  RetornaErrorsCode.ID_INVALIDO;
      result  :=  Presenter.ConverterResponse(response);
      exit;
    end else begin
      cliente :=  TCliente(response.Data[0]);
    end;
  end;

  if idveiculo >  0 then begin
    _dtoVeiculo.Id  :=  idveiculo;
    response  :=  CasoUsoVeiculo.Consultar(_dtoVeiculo);
    if (response.success) and (response.Message = RetornaMsgResponse.CONSULTA_REALIZADA_SEM_RETORNO) then begin
      response.Message  :=  'id do Veículo inválido';
      response.ErrorCode  :=  RetornaErrorsCode.ID_INVALIDO;
      result  :=  Presenter.ConverterResponse(response);
      exit;
    end else begin
      veiculo :=  TVeiculo(response.Data[0]);
    end;
  end;

  _dtoLocacao.Id  :=  idlocacao;
  response  :=  CasoUsoLocacao.Consultar(_dtoLocacao);

  if (response.success) and (response.Message = RetornaMsgResponse.CONSULTA_REALIZADA_SEM_RETORNO) then begin
    response.Message  :=  'id da Locação inválido';
    response.ErrorCode  :=  RetornaErrorsCode.ID_INVALIDO;
    result  :=  Presenter.ConverterResponse(response);
    exit;
  end else begin
    locacao :=  TLocacao(response.Data[0]);
  end;

  if idcliente > 0 then locacao.Cliente  :=  cliente;
  if idveiculo > 0 then locacao.Veiculo  :=  veiculo;

  if datadevolucao <> strtodate('30/12/1899') then
    locacao.DataDevolucao :=  datadevolucao;

  response  :=  CasoUsoLocacao.Alterar(locacao);

  if response.success then begin
    if (datadevolucao <>  StrTodate('30/12/1899'))  then begin
//    if locacao.Veiculo.id <>  locacao.VeiculoAtual.id then begin
      locacao.VeiculoAtual.Status :=  sDisponivel;
      responseVeiculo := CasoUsoVeiculo.Alterar(locacao.Veiculo);
      if not responseVeiculo.success and not
      (responseVeiculo.Message = RetornaMsgResponse.ALTERADO_COM_SUCESSO) then begin
        responseVeiculo.Message    :=    'erro ao atualizar status do veículo';
        responseVeiculo.ErrorCode   :=  RetornaErrorsCode.ERROR_BANCO_DADOS;
        result  :=  Presenter.ConverterResponse(responseVeiculo);
        exit;
      end;

      {
      else begin
        locacao.Veiculo.Status  :=  sAlugado;
        responseVeiculo :=  CasoUsoVeiculo.Alterar(locacao.Veiculo);
         if not response.success and not
          (responseVeiculo.Message = RetornaMsgResponse.ALTERADO_COM_SUCESSO) then begin
          responseVeiculo.Message  :=    'erro ao atualizar status do veículo';
          responseVeiculo.ErrorCode  :=  RetornaErrorsCode.ERROR_BANCO_DADOS;
          result  :=  Presenter.ConverterResponse(responseVeiculo);
          exit;
        end;
      }

    end;

    if locacao.Veiculo.id <>  locacao.VeiculoAtual.id then
    begin
       locacao.VeiculoAtual.Status := sDisponivel;
       responseveiculo := CasoUsoVeiculo.Alterar(locacao.VeiculoAtual);

       if not responseveiculo.success and
       not (responseVeiculo.Message = RetornaMsgResponse.ALTERADO_COM_SUCESSO) then
       begin
           responseveiculo.Message := 'erro ao atualizar status veículo';
           responseVeiculo.ErrorCode  :=  RetornaErrorsCode.ERROR_BANCO_DADOS;
           result := Presenter.ConverterResponse(responseveiculo);
           exit;
       end else
       begin

          locacao.Veiculo.Status := sAlugado;
          responseveiculo := CasoUsoVeiculo.Alterar(locacao.Veiculo);

           if not responseveiculo.success and
          not (responseveiculo.Message = RetornaMsgResponse.ALTERADO_COM_SUCESSO) then
          begin

            responseveiculo.Message := 'erro ao atualizar status veículo';
            responseveiculo.ErrorCode := RetornaErrorsCode.ERROR_BANCO_DADOS;
            result := Presenter.ConverterResponse(responseveiculo);
           exit;
          end;
       end;
    end;
  end;
  result  :=  Presenter.ConverterResponse(response);
end;

function TControllerLocacao.Cadastrar(idcliente, idveiculo: integer): string;
var
  response, response_veic : TResponse;
  cliente   : TCliente;
  veiculo   : TVeiculo;
  locacao   : TLocacao;

  _dtoCliente : DtoCliente;
  _dtoVeiculo : DtoVeiculo;
begin
  _dtoCliente.id  := idcliente;

  response  :=  CasoUsoCliente.Consultar(_dtoCliente);

  if (response.success) and (response.Message = RetornaMsgResponse.CONSULTA_REALIZADA_SEM_RETORNO) then
  begin
    response.Message  :=  'id do cliente inválido';
    response.ErrorCode  :=  RetornaErrorsCode.ID_INVALIDO;
    result  :=  Presenter.ConverterResponse(response);
    exit;
  end;

  cliente :=  TCliente(response.Data[0]);

  _dtoVeiculo.id  := idveiculo;

  response  :=  CasoUsoVeiculo.Consultar(_dtoVeiculo);

  if (response.success) and (response.Message = RetornaMsgResponse.CONSULTA_REALIZADA_SEM_RETORNO) then
  begin
    response.Message  :=  'id do cliente inválido';
    response.ErrorCode  :=  RetornaErrorsCode.ID_INVALIDO;
    result  :=  Presenter.ConverterResponse(response);
    exit;
  end;

  veiculo :=  TVeiculo(response.Data[0]);

  locacao :=  TLocacao.create;
  locacao.Cliente :=  cliente;
  locacao.Veiculo :=  veiculo;

  response  :=  CasoUsoLocacao.Cadastrar(locacao);

  locacao.Free;

  if response.success then begin
    veiculo.Status  := sAlugado;
    response_veic   := CasoUsoVeiculo.Alterar(veiculo);

    if response_veic.success = false then begin
      response.Message    :=  'erro ao alterar status';
      response.ErrorCode  :=  RetornaErrorsCode.ERROR_BANCO_DADOS;
      result  :=  Presenter.ConverterResponse(response);
      exit;
    end;
  end;
  Result :=  Presenter.ConverterResponse(response);
end;

function TControllerLocacao.Consultar(idlocacao, idcliente: integer;
  datalocacao, datadevolucao: TDatetime): string;
var
  response  : TResponse;
  dto : DtoLocacao;
begin

  dto.id            :=  idlocacao;
  dto.idcliente     :=  idcliente;
  dto.datalocacao   :=  datalocacao;
  dto.datadevolucao :=  datadevolucao;

  response  :=  CasoUsoLocacao.Consultar(dto);

  Result :=  Presenter.ConverterResponse(response);
end;

constructor TControllerLocacao.create(repositoryLocacao: IRepositoryLocacao;
  repositoryVeiculo: IRepositoryVeiculo; repositoryCliente: IRepositoryCliente;
  Presenter : IPresenter);
begin

  self.Presenter  :=  Presenter;
  CasoUsoLocacao  :=  TCasoUsoLocacao.create(repositoryLocacao);
  CasoUsoCliente  :=  TCasoUsoCliente.create(repositoryCliente);
  CasoUsoVeiculo  :=  TCasoUsoVeiculo.create(repositoryVeiculo);
end;

function TControllerLocacao.Deletar(idlocacao: integer): string;
var
  response    : TResponse;
  _dtoLocacao : DtoLocacao;
begin
  _dtoLocacao.id  :=  idlocacao;

  response  :=  CasoUsoLocacao.Consultar(_dtoLocacao);

  if (response.success) and (response.Message = RetornaMsgResponse.CONSULTA_REALIZADA_SEM_RETORNO) then
  begin
    response.Message  :=  'id locação invádilo';
    response.ErrorCode  :=  RetornaErrorsCode.ID_INVALIDO;
    Result :=  Presenter.ConverterResponse(response);
    exit;
  end;

  response  := CasoUsoLocacao.Deletar(idlocacao);
  Result :=  Presenter.ConverterResponse(response);
end;

destructor TControllerLocacao.destroy;
begin

  inherited;
end;

procedure TControllerLocacao.SetCasoUsoCliente(const Value: ICasoUsoCliente);
begin
  FCasoUsoCliente := Value;
end;

procedure TControllerLocacao.SetCasoUsoLocacao(const Value: ICasoUsoLocacao);
begin
  FCasoUsoLocacao := Value;
end;

procedure TControllerLocacao.SetCasoUsoVeiculo(const Value: ICasoUsoVeiculo);
begin
  FCasoUsoVeiculo := Value;
end;

procedure TControllerLocacao.SetPresenter(const Value: IPresenter);
begin
  FPresenter := Value;
end;

end.
