program locacaoConsole;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uMenuPrincipal in 'uMenuPrincipal.pas',
  uCliente in '..\..\Core\Models\uCliente.pas',
  uICasoUsoCliente in '..\..\Core\Ports\uICasoUsoCliente.pas',
  uResponse in '..\..\Core\Response\uResponse.pas',
  uDTOCliente in '..\..\Core\Dto\uDTOCliente.pas',
  uCasoUsoCliente in '..\..\Core\UseCases\uCasoUsoCliente.pas',
  uEnums in '..\..\Core\Enums\uEnums.pas',
  uExceptions in '..\..\Core\Exceptions\uExceptions.pas',
  uUtils in '..\..\Utils\uUtils.pas',
  uVeiculo in '..\..\Core\Models\uVeiculo.pas',
  uICasoUsoVeiculo in '..\..\Core\Ports\uICasoUsoVeiculo.pas',
  uDTOVeiculo in '..\..\Core\Dto\uDTOVeiculo.pas',
  uCasoUsoVeiculo in '..\..\Core\UseCases\uCasoUsoVeiculo.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    Menu;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
