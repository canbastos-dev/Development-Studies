unit uCasoUsoCliente;

interface

uses uICasoUsoCliente, System.SysUtils, uCliente,  uDTOCliente, uResponse, uEnums,
      uUtils;

type
  TCasoUsoCliente   = class(TInterfacedObject, ICasoUsoCliente)

  function Cadastrar(cliente  : TCliente): TResponse;

  function Alterar(cliente  : TCliente): TResponse;

  function Deletar(id  : integer): TResponse;

  function Consultar(dto  : DtoCliente): TResponse;

  end;

implementation

{ TCasoUsoCliente }

function TCasoUsoCliente.Alterar(cliente: TCliente): TResponse;
var
  response  : TResponse;
begin

  try

    cliente.ValidarRegrasNegocios;

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

function TCasoUsoCliente.Cadastrar(cliente: TCliente): TResponse;
var
  response  : TResponse;
begin

  try

    cliente.ValidarRegrasNegocios;

    response.success    :=  True;
    response.ErrorCode  :=  0;
    response.Message    := RetornaMsgResponse.CADASTRADO_COM_SUCESSO;
    response.Data       := nil;

  Except
    on e: Exception do
      begin

      end;

  end;

  result := response;
end;

function TCasoUsoCliente.Consultar(dto: DtoCliente): TResponse;
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

function TCasoUsoCliente.Deletar(id: integer): TResponse;
var
  response  : TResponse;
begin

  try
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

end.
