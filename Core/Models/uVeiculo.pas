unit uVeiculo;

interface

uses uEnums, System.SysUtils, uExceptions;

type

  TVeiculo  = class
  private
    FValor: currency;
    Fid: integer;
    FStatus: Status;
    FPlaca: String;
    FNome: String;
    procedure Setid     (const Value: integer);
    procedure SetNome   (const Value: String);
    procedure SetPlaca  (const Value: String);
    procedure SetStatus (const Value: Status);
    procedure SetValor  (const Value: currency);
  published
    property id     : integer   read Fid      write Setid;
    property Nome   : String    read FNome    write SetNome;
    property Placa  : String    read FPlaca   write SetPlaca;
    property Valor  : currency  read FValor   write SetValor;
    property Status : Status    read FStatus  write SetStatus;

    procedure ValidarRegrasNegocios;
  end;


implementation

{ TVeiculo }

procedure TVeiculo.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TVeiculo.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TVeiculo.SetPlaca(const Value: String);
begin
  FPlaca := Value;
end;

procedure TVeiculo.SetStatus(const Value: Status);
begin
  FStatus := Value;
end;

procedure TVeiculo.SetValor(const Value: currency);
begin
  FValor := Value;
end;

procedure TVeiculo.ValidarRegrasNegocios;
begin
  if trim(FNome) = '' then
  begin
    ExceptionNomeVeiculo;
  end;

  if Length(FNome) < 3 then
  begin
    ExceptionMinimoNomeVeiculo;
  end;

  if trim(FPlaca) = '' then
  begin
    ExceptionPlacaVeiculo;
  end;

  if Length(FPlaca) < 6 then
  begin
    ExceptionMinimoPlacaVeiculo;
  end;

  if FValor = 0 then
  begin
    ExceptionValorVeiculo;
  end;

end;

end.

