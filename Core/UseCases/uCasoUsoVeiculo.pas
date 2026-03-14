unit uCasoUsoVeiculo;

interface

uses uVeiculo, uICasoUsoVeiculo, uDTOVeiculo, uResponse, uExceptions, uEnums, uUtils,
  System.SysUtils;

type
  TCasoUsoVeiculo = class

  function Cadastrar(veiculo  : TVeiculo): TResponse;

  function Alterar(veiculo  : TVeiculo): TResponse;

  function Deletar(id  : integer): TResponse;

  function Consultar(dto  : DtoVeiculo): TResponse;

  procedure ValidarId(id  : integer);

  end;

implementation

{ TCasoUsoVeiculo }

function TCasoUsoVeiculo.Alterar(veiculo: TVeiculo): TResponse;
var
  response  : TResponse;
begin

  try

    veiculo.ValidarRegrasNegocios;

    response.success    :=  True;
    response.ErrorCode  :=  0;
    response.Message    := RetornaMsgResponse.ALTERADO_COM_SUCESSO;
    response.Data       := nil;

  Except
    on e: Exception do
      begin
        response  := TratarException(e)
      end;

  end;

  result := response;
end;

function TCasoUsoVeiculo.Cadastrar(veiculo: TVeiculo): TResponse;
var
  response  : TResponse;
begin

  try

    veiculo.ValidarRegrasNegocios;

    response.success    :=  True;
    response.ErrorCode  :=  0;
    response.Message    := RetornaMsgResponse.CADASTRADO_COM_SUCESSO;
    response.Data       := nil;

  Except
    on e: Exception do
      begin
        response  := TratarException(e)
      end;

  end;

  result := response;
end;

function TCasoUsoVeiculo.Consultar(dto: DtoVeiculo): TResponse;
var
  response  : TResponse;
begin

  try
    response.success    :=  True;
    response.ErrorCode  :=  0;
    response.Message    := RetornaMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO;
    response.Data       := nil;

  Except
    on e: Exception do
      begin

      end;

  end;

  result := response;
end;

function TCasoUsoVeiculo.Deletar(id: integer): TResponse;
var
  response  : TResponse;
begin

  try

    ValidarId(id);

    response.success    :=  True;
    response.ErrorCode  :=  0;
    response.Message    := RetornaMsgResponse.DELETADO_COM_SUCESSO;
    response.Data       := nil;

  Except
    on e: Exception do
      begin

      end;

  end;

  result := response;
end;

procedure TCasoUsoVeiculo.ValidarId(id: integer);
begin
  if id < 0 then
  begin
      ExceptionIdInvalido;
  end;
end;

end.
