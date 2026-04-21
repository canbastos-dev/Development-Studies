unit uRepositoryVeiculo;

interface

uses uVeiculo, uDtoVeiculo, uIRepositoryVeiculo, System.Generics.Collections,
System.SysUtils, uConfiguracaoBD_pg, uUtils ;

type

  TRepositoryVeiculo  = class(TInterfacedObject, IRepositoryVeiculo)
  private
    FLista: TList<TVeiculo>;
    ConfiguracaoDB  : TConfiguracaoBD;
    procedure SetLista(const Value: TList<TVeiculo>);
  published

    procedure Cadastrar(veiculo  : TVeiculo);
    procedure Alterar(veiculo  : TVeiculo);
    procedure Excluir(id  : integer);
    function Consultar(dto  : DtoVeiculo) : TList<TVeiculo>;

    property Lista  :   TList<TVeiculo> read FLista write SetLista;

    constructor create;
    destructor destroy; override;

  end;

implementation

{ TRepositoryVeiculo }

procedure TRepositoryVeiculo.Alterar(veiculo: TVeiculo);
var
  sql : string;
begin

  sql :=  'update Veiculo set '  +
          'nome = ' + QuotedStr(veiculo.Nome) + ',' +
          'placa  = ' + QuotedStr(veiculo.Placa)  + ',' +
          'valor  = ' + StringReplace(CurrToStr(veiculo.valor),',','.',[])  + ',' +
          'status = ' + QuotedStr(ConverteStatusString(veiculo.status)) +
          'where id = ' + IntToStr(veiculo.id);

          ConfiguracaoDB.ExecSql(sql);
end;

procedure TRepositoryVeiculo.Cadastrar(veiculo: TVeiculo);
var
  sql : string;
begin

  sql :=  'insert into Veiculo (nome, placa, valor, status) '+
          'values ('+
          QuotedStr(veiculo.Nome)  +  ',' +
          QuotedStr(veiculo.placa)  +  ',' +
          StringReplace(CurrToStr(veiculo.valor),',','.',[])  +  ',' +
          QuotedStr(ConverteStatusString(veiculo.status))  +  ')' ;

          ConfiguracaoDB.ExecSql(sql);
end;

function TRepositoryVeiculo.Consultar(dto: DtoVeiculo): TList<TVeiculo>;
var
  sql : string;
  veiculo : TVeiculo;
begin

  sql :=  'select * from Veiculo where 1 = 1';

  if dto.id > 0 then begin
    sql :=  sql + ' and id = ' + IntToStr(dto.id);
  end else begin
    if dto.Nome <> '' then begin
      sql :=  sql + ' and nome like ' + QuotedStr('%' + dto.Nome + '%');
    end;

    if dto.placa <> '' then begin
      sql :=  sql + ' and placa like ' + QuotedStr('%' + dto.Placa + '%');
    end;
  end;

  if ConfiguracaoDB.Consulta(sql) then begin
    Lista.clear;
    with ConfiguracaoDB do begin
      Query.First;
      while not Query.Eof do begin
        veiculo              :=  TVeiculo.Create;
        veiculo.Id           :=  Query.FieldByName('id').AsInteger;
        veiculo.Nome         :=  Query.FieldByName('nome').AsString;
        veiculo.placa        :=  Query.FieldByName('placa').AsString;
        veiculo.status       :=  ConverteStrStatus(Query.FieldByName('status').AsString);
        Lista.Add(veiculo);
        Query.Next;
      end;
    end;
  end;
  result  :=  Lista;
end;

constructor TRepositoryVeiculo.create;
begin
  Lista :=  TList<TVeiculo>.Create;
  ConfiguracaoDB  := TConfiguracaoBD.Create;
end;

destructor TRepositoryVeiculo.destroy;
begin
  Lista.Free;
  ConfiguracaoDB.Free;
  inherited;
end;

procedure TRepositoryVeiculo.Excluir(id: integer);
var
  sql : String;
begin
  sql :=  'delete from Veiculo where id  = ' + IntToStr(id);
  ConfiguracaoDB.ExecSql(sql);
end;

procedure TRepositoryVeiculo.SetLista(const Value: TList<TVeiculo>);
begin
  FLista := Value;
end;

end.
