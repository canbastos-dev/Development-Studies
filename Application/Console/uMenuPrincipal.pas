unit uMenuPrincipal;

interface

uses winapi.Windows,  System.SysUtils, uDados, uIRepositoryCliente, uIRepositoryVeiculo, uIRepositoryLocacao, uRepositoryCliente,
  uRepositoryVeiculo, uRepositoryLocacao, uControllerCliente, uControllerVeiculo,
  uControllerLocacao, uIPresenter, uPresenterStr, System.DateUtils;

procedure InjecaoDependencia;
procedure Finalizar;

var
  ControllerCliente : TControllerCliente;
  ControllerVeiculo : TControllerVeiculo;
  ControllerLocacao : TControllerLocacao;

  repositoryCliente : IRepositoryCliente;
  repositoryVeiculo : IRepositoryVeiculo;
  repositoryLocacao : IRepositoryLocacao;

  presenter         : IPresenter;

procedure Menu;
procedure MenuCliente;
procedure CadastrarCliente;
procedure AlterarCliente;
procedure ExcluirCliente;
procedure ConsultarCliente;
procedure MenuVeiculos;
procedure CadastrarVeiculo;
procedure AlterarVeiculo;
procedure ExcluirVeiculo;
procedure ConsultarVeiculo;
procedure MenuLocacoes;
procedure CadastrarLocacoes;
procedure AlterarLocacoes;
procedure ExcluirLocacoes;
procedure ConsultarLocacoes;
procedure clean;

// função para reutilizar codigo relativo as opçoes compartilhadas entre os menus
// essa RETORNA um valor, que são exatamente as opções
function Modulos  : string;

implementation

procedure Finalizar;
begin
  ControllerCliente.free;
  ControllerVeiculo.free;
  ControllerLocacao.free;
end;

procedure InjecaoDependencia;
begin
//  dmDados := TdmDados.Create(nil); // ← cria e já dispara DataModuleCreate→Conectar

  presenter         :=  TPresenterStr.Create;

  repositoryCliente :=  TRepositoryCliente.create;
  repositoryVeiculo :=  TRepositoryVeiculo.create;
  repositoryLocacao :=  TRepositoryLocacao.create(repositoryCliente, repositoryVeiculo);

  ControllerCliente :=  TControllerCliente.create(repositoryCliente, presenter);
  ControllerVeiculo :=  TControllerVeiculo.create(repositoryVeiculo, presenter);
  ControllerLocacao :=  TControllerLocacao.create(repositoryLocacao, repositoryVeiculo,
    repositoryCliente, presenter);

end;

function Modulos  : string;
begin
  Result  :=  '1 - Cadastrar '  + #13#10 +
              '2 - Alterar'     + #13#10 +
              '3 - Excluit'     + #13#10 +
              '4 - Consultar'   + #13#10 +
              '5 - Voltar'      + #13#10;
end;

procedure clean;
var
  stdout: THandle;
  csbi: TConsoleScreenBufferInfo;
  ConsoleSize: DWORD;
  NumWritten: DWORD;
  Origin: TCoord;
begin
  stdout := GetStdHandle(STD_OUTPUT_HANDLE);
  Win32Check(stdout<>INVALID_HANDLE_VALUE);
  Win32Check(GetConsoleScreenBufferInfo(stdout, csbi));
  ConsoleSize := csbi.dwSize.X * csbi.dwSize.Y;
  Origin.X := 0;
  Origin.Y := 0;
  Win32Check(FillConsoleOutputCharacter(stdout, ' ', ConsoleSize, Origin,
    NumWritten));
  Win32Check(FillConsoleOutputAttribute(stdout, csbi.wAttributes, ConsoleSize, Origin,
    NumWritten));
  Win32Check(SetConsoleCursorPosition(stdout, Origin));

end;

procedure Menu;
var
//  codigo  : integer;
  entrada : string;
  modulo  : string;
  opcao   : integer;
begin

  repeat

  clean;

  writeln('Menu de opções');
  writeln;

  modulo  :=  '1 - Clientes'  + #13#10 +
              '2 - Veiculos'  + #13#10 +
              '3 - Locações'  + #13#10 +
              '0 - Sair'      + #13#10 ;

  writeln(modulo);
//  if dmDados.Conn_Locacao.Connected then
    writeln(Output, 'Opção:');
//  else
//    writeln(Output, 'Opção NAO Conectado:');
  readln(Input,opcao);

  case opcao of
    1 : MenuCliente;
    2 : MenuVeiculos;
    3 : MenuLocacoes;
    else
    begin
      if opcao >  0 then begin
        writeln('Opção invalida');
        readln;
      end;
//      Menu;
    end;
  end;

  until opcao = 0;

end;

// Menu Cliente
procedure MenuCliente;
var
  codigo  : integer;
  modulo  : string;
begin

  clean;

  writeln('Menu de Clientes');
  writeln;

  writeln(Modulos);
  writeln(Output, 'Opção:');
  readln(Input,codigo);


  case codigo of
    1 : CadastrarCliente;
    2 : AlterarCliente;
    3 : ExcluirCliente;
    4 : ConsultarCliente;
    5 : Menu
    else
      begin
        writeln('Opção invalida');
        readln;
//        Menu;
      end;
  end;
end;

procedure CadastrarCliente;
var
  nome, documento, cep, logradouro, complemento, bairro, cidade, uf,
  telefone, response  : string;
begin
  clean;
  writeln('Cadastro de Cliente');
  writeln;

  write(output,'Nome: ');
  readln(input, nome);
  write(output,'Documento: ');
  readln(input, documento);
  write(output,'Cep: ');
  readln(input, Cep);
  write(output,'Logradouro: ');
  readln(input, logradouro);
  write(output,'Complemento: ');
  readln(input, complemento);
  write(output,'Bairro: ');
  readln(input, bairro);
  write(output,'Cidade: ');
  readln(input, cidade);
  write(output,'UF: ');
  readln(input, uf);
  write(output,'Telefone: ');
  readln(input, telefone);

  response  :=  ControllerCliente.Cadastrar(nome, documento, cep, logradouro,
  complemento, bairro, cidade, uf, telefone);

  writeln(response);
  readln;
//  Menu;
end;

procedure AlterarCliente;
var
  idcliente : integer;
  nome, documento, cep, logradouro, complemento, bairro, cidade, uf,
  telefone, response  : string;
begin
  clean;
  writeln('Alterar Cliente');
  writeln;

  write(output,'Id: ');
  readln(input, idcliente);

  write(output,'Nome: ');
  readln(input, nome);
  write(output,'Documento: ');
  readln(input, documento);
  write(output,'Cep: ');
  readln(input, Cep);
  write(output,'Logradouro: ');
  readln(input, logradouro);
  write(output,'Complemento: ');
  readln(input, complemento);
  write(output,'Bairro: ');
  readln(input, bairro);
  write(output,'Cidade: ');
  readln(input, cidade);
  write(output,'UF: ');
  readln(input, uf);
  write(output,'Telefone: ');
  readln(input, telefone);

  response  :=  ControllerCliente.Alterar(idcliente, nome, documento, cep, logradouro,
  complemento, bairro, cidade, uf, telefone);

  clean;
  writeln(response);
  readln;
//  Menu;
end;

procedure ExcluirCliente;
var
  idcliente : integer;
  response  :string;
begin
  clean;
  writeln('Excluir Cliente');
  writeln;
  write(output,'Id: ');
  readln(input, idcliente);

  response  := ControllerCliente.Deletar(idcliente);

  clean;
  writeln(response);
  readln;
//  Menu;
end;

procedure ConsultarCliente;
var
  id  : integer;
  nome, documento, response :string;

begin
  clean;
  writeln('Consultar Cliente');
  writeln;

  write(output,'Id: ');
  readln(input, id);
  write(output,'Nome: ');
  readln(input, nome);
  write(output,'Documento: ');
  readln(input, documento);

  response  := ControllerCliente.Consultar(id, nome, documento);

  clean;
  writeln(response);
  readln;
//  Menu;
end;

// Menu Veiculos
procedure MenuVeiculos;
var
  codigo  : integer;
  modulo  : string;
begin

  clean;

  writeln('Menu de Veiculos');
  writeln;

  writeln(Modulos);
  writeln(Output, 'Opção:');
  readln(Input,codigo);


  case codigo of
    1 : CadastrarVeiculo;
    2 : AlterarVeiculo;
    3 : ExcluirVeiculo;
    4 : ConsultarVeiculo;
    5 : Menu
    else
      begin
        writeln('Opção invalida');
        readln;
//        Menu;
      end;
  end;
end;

procedure CadastrarVeiculo;
var
  nome, placa, response : string;
  valor                 : currency;

begin
  clean;
  writeln('Cadastro de Veiculos');
  writeln;
  write(output,'Nome: ');
  readln(input, nome);
  write(output,'Placa: ');
  readln(input, placa);
  write(output,'Valor: ');
  readln(input, valor);

  response  := ControllerVeiculo.Cadastrar(nome, placa, valor);

  clean;
  writeln(response);
  readln;
//  Menu;
end;

procedure AlterarVeiculo;
var
  nome, placa, status, response : string;
  valor                         : currency;
  id                            : integer;
begin
  clean;
  writeln('Alterar Veiculo');
  writeln;
  write(output,'Id: ');
  readln(input, id);
  write(output,'Nome: ');
  readln(input, nome);
  write(output,'Placa: ');
  readln(input, placa);
  write(output,'Status: ');
  readln(input, status);
  write(output,'Valor: ');
  readln(input, valor);

  response  := ControllerVeiculo.Alterar(id, nome, placa, status, valor);

  clean;
  writeln(response);
  readln;
//  Menu;
end;

procedure ExcluirVeiculo;
var
  response  : string;
  id        : integer;
begin
  clean;
  writeln('Excluir Veiculo');
  writeln;
  write(output,'Id: ');
  readln(input, id);

  response  := ControllerVeiculo.Deletar(id);

  clean;
  writeln(response);
  readln;
//  Menu;
end;

procedure ConsultarVeiculo;
var
  nome, placa, response : string;
  id                    : integer;
begin
  clean;
  writeln('Consultar Veiculo');
  writeln;
  write(output,'Id: ');
  readln(input, id);
  write(output,'Nome: ');
  readln(input, nome);
  write(output,'Placa: ');
  readln(input, placa);

  response  := ControllerVeiculo.Consultar(id, nome, placa);

  clean;
  writeln(response);
  readln;

//  Menu;
end;


// Menu Locações
procedure MenuLocacoes;
var
  codigo  : integer;
  modulo  : string;
begin

  clean;

  writeln('Menu de Locações');
  writeln;

  writeln(Modulos);
  writeln(Output, 'Opção:');
  readln(Input,codigo);


  case codigo of
    1 : CadastrarLocacoes;
    2 : AlterarLocacoes;
    3 : ExcluirLocacoes;
    4 : ConsultarLocacoes;
    5 : Menu
    else
      begin
        writeln('Opção invalida');
        readln;
  //      Menu;
      end;
  end;
end;

procedure CadastrarLocacoes;
var
  idcliente, idveiculo  : integer;
  response              : string;
begin
  clean;
  writeln('Cadastro de Locações');
  writeln;

  write(output,'Cliente: ');
  readln(input, idcliente);
  write(output,'Veiculo: ');
  readln(input, idveiculo);

  response  := ControllerLocacao.Cadastrar(idcliente, idveiculo);

  clean;
  writeln(response);
  readln;
//  Menu;
end;

procedure AlterarLocacoes;
var
  id, idcliente, idveiculo  : integer;
  datadevolucao, response  : string;
begin
  clean;
  writeln('Alterar Locações');
  writeln;

  write(output,'Id Locacao: ');
  readln(input, id);
  write(output,'Cliente: ');
  readln(input, idcliente);
  write(output,'Veiculo: ');
  readln(input, idveiculo);
  write(output,'Dt Devolucao: ');
  readln(input, datadevolucao);

  if datadevolucao = '' then datadevolucao:='30/12/1899';
  response  := ControllerLocacao.Alterar(id, idcliente, idveiculo,
    strtodate(datadevolucao));
  clean;
  writeln(response);
  readln;
//  Menu;
end;

procedure ExcluirLocacoes;
var
  response  : string;
  id        : integer;
begin
  clean;
  writeln('Excluir Locações');
  writeln;
  write(output,'Id: ');
  readln(input, id);

  response  := ControllerLocacao.Deletar(id);

  clean;
  writeln(response);
  readln;
//  Menu;
end;

procedure ConsultarLocacoes;
var
  id, idcliente : integer;
  dtlocacao, dtdevolucao, status, response  : string;
begin
  clean;
  writeln('Consultar Locações');
  writeln;
  write(output,'Id: ');
  readln(input, id);
  write(output,'Id Cliente: ');
  readln(input, idcliente);
  write(output,'Data Locação: ');
  readln(input, dtlocacao);
  write(output,'Data Devolução: ');
  readln(input, dtdevolucao);

  if dtlocacao = '' then dtlocacao:='30/12/1899';
  if dtdevolucao = '' then dtdevolucao:='30/12/1899';

  response  := ControllerLocacao.Consultar(id, idcliente, strtodate(dtlocacao), strtodate(dtdevolucao));

  clean;
  writeln(response);
  readln;

//  Menu;
end;

end.
