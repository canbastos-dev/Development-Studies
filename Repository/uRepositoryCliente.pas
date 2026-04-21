unit uRepositoryCliente;

interface

uses uCliente, uDtoCliente, uIRepositoryCliente, System.Generics.Collections,
System.SysUtils, uConfiguracaoBD_pg;

type

  TRepositoryCliente  = class(TInterfacedObject, IRepositoryCliente)
  private
    FLista: TList<TCliente>;
    ConfiguraçãoDB  : TConfiguracaoBD;
    procedure SetLista(const Value: TList<TCliente>);
  published

    procedure Cadastrar(cliente  : TCliente);
    procedure Alterar(cliente  : TCliente);
    procedure Excluir(id  : integer);
    function Consultar(dto  : DtoCliente) : TList<TCliente>;

    property lLista  :   TList<TCliente> read FLista write SetLista;

    constructor create;
    destructor destroy; override;
  end;

implementation

{ TRepositoryCliente }

procedure TRepositoryCliente.Alterar(cliente: TCliente);
var
  sql : string;
begin

  sql :=  'update cliente set nome = '+ QuotedStr(cliente.Nome) + ',' +
          'cep = ' + QuotedStr(cliente.Cep) + ',' +
          'logradouro = ' + QuotedStr(cliente.Logradouro) + ',' +
          'complemento = ' + QuotedStr(cliente.Complemento) + ',' +
          'bairro = ' + QuotedStr(cliente.Bairro) + ',' +
          'uf = ' + QuotedStr(cliente.UF) + ',' +
          'cidade = ' + QuotedStr(cliente.Cidade) + ',' +
          'telefone = ' + QuotedStr(cliente.Telefone) + ',' +
          'documento = ' + QuotedStr(cliente.Documento) +
          ' where id = ' + IntToStr(cliente.Id) ;

  ConfiguraçãoDB.ExecSql(sql);
end;

procedure TRepositoryCliente.Cadastrar(cliente: TCliente);
var
  sql : string;
begin

  sql :=  'insert into cliente (nome, documento, cep, logradouro,'+
          'complemento, bairro, cidade, uf, telefone)'+
          'values ('+
          QuotedStr(cliente.Nome)  +  ',' +
          QuotedStr(cliente.Documento)  +  ',' +
          QuotedStr(cliente.Cep)  +  ',' +
          QuotedStr(cliente.Logradouro)  +  ',' +
          QuotedStr(cliente.Complemento)  +  ',' +
          QuotedStr(cliente.Bairro)  +  ',' +
          QuotedStr(cliente.Cidade)  +  ',' +
          QuotedStr(cliente.UF)  +  ',' +
//          QuotedStr(cliente.numero)  +  ',' +
          QuotedStr(cliente.Telefone)  +  ')' ;

          ConfiguraçãoDB.ExecSql(sql);
end;

function TRepositoryCliente.Consultar(dto: DtoCliente): TList<TCliente>;
var
  sql : string;
  lcliente  : TCliente;
//  lista     : TList<TCliente>;  //-
begin

//  lista := TList<TCliente>.Create;     //-
//  result := lista;                     //-

  sql :=  'select * from cliente where 1 = 1';

  if dto.id > 0 then begin
    sql :=  sql + ' and id = ' + IntToStr(dto.id);
  end else begin
    if dto.Nome <> '' then begin
      sql :=  sql + ' and nome like ' + QuotedStr('%' + dto.Nome + '%');
    end;

    if dto.Documento <> '' then begin
      sql :=  sql + ' and documento like ' + QuotedStr('%' + dto.Documento + '%');
    end;
  end;

  if ConfiguraçãoDB.Consulta(sql) then begin
    lLista.clear;

    with ConfiguraçãoDB do begin
      Query.First;
      while not Query.Eof do begin
        lcliente              :=  TCliente.Create;
        lcliente.Id           :=  Query.FieldByName('id').AsInteger;
        lcliente.Nome         :=  Query.FieldByName('nome').AsString;
        lcliente.Documento    :=  Query.FieldByName('Documento').AsString;
        lcliente.Cep          :=  Query.FieldByName('Cep').AsString;
        lcliente.Logradouro   :=  Query.FieldByName('Logradouro').AsString;
        lcliente.Complemento  :=  Query.FieldByName('Complemento').AsString;
        lcliente.Bairro       :=  Query.FieldByName('Bairro').AsString;
        lcliente.Cidade       :=  Query.FieldByName('Cidade').AsString;
        lcliente.UF           :=  Query.FieldByName('UF').AsString;
        lcliente.Telefone     :=  Query.FieldByName('Telefone').AsString;
        lcliente.Documento    :=  Query.FieldByName('Documento').AsString;
        lLista.Add(lcliente);
        Query.Next;         //-
      end;
      Query.Close;
    end;
  end;
  result  :=  lLista;
//  lLista.Free;
end;

constructor TRepositoryCliente.create;
begin
  lLista :=  TList<TCliente>.Create;
  ConfiguraçãoDB  := TConfiguracaoBD.Create;
end;

destructor TRepositoryCliente.destroy;
begin
  lLista.free;
  ConfiguraçãoDB.Free;
  inherited;
end;

procedure TRepositoryCliente.Excluir(id: integer);
var
  sql : string;
begin

  sql :=  'delete from cliente where id = '+ IntToStr(id);

  ConfiguraçãoDB.ExecSql(sql);

end;

procedure TRepositoryCliente.SetLista(const Value: TList<TCliente>);
begin
  FLista := Value;
end;

end.
