unit uUseCaseCliente;

interface


uses uCliente, system.SysUtils, uResponse, uConnect, uDtoCliente,
system.Generics.Collections, uSingletonConnect;


 type TUseCaseCliente = class


  private
    Connect: Tconnect;
    FLista: TList<DtoCliente>;
    procedure SetLista(const Value: TList<DtoCliente>);

    function consistirClienteVenda(codigo : integer) : boolean;

  public

  function Cadastrar(cliente : Tcliente)  : Response;
  function Alterar(cliente : Tcliente)    : Response;
  function Excluir(codigo : integer)      : Response;
  function Consultar(dto : DtoConsultaCliente)    : TList<DtoCliente>;
  function ConsultarId(codigo : integer) : Tcliente;
  function consistirExiste(codigo : integer) : boolean;

   property Lista : TList<DtoCliente> read FLista write SetLista;


  constructor create;
  destructor Destroy;override;



 end;

implementation

{ UseCaseCliente }

function TUseCaseCliente.Alterar(cliente: Tcliente): Response;
var
 sql : string;
 retorno : Response;
begin
   sql := ' update clientes set ' +
          ' nome = '   +  Quotedstr(cliente.Nome) + ',' +
          ' cidade = ' +  Quotedstr(cliente.Cidade) + ',' +
          ' uf = '     +  Quotedstr(cliente.Uf) +
          ' where codigo = ' +  intToStr(Cliente.Codigo);


  retorno := connect.ExecSql(sql) ;

  if retorno.Success then
  begin
    result.Success := true;
    result.Message := 'Alterado com sucesso';
  end else
  begin
    result := retorno;
  end;


end;

function TUseCaseCliente.Cadastrar(cliente: Tcliente): Response;
var
 Sql : string;
 retorno :Response;
begin

   sql := ' Insert Into clientes '+
          '(nome,cidade,uf)  values (' +

          Quotedstr(cliente.Nome) + ',' +
          Quotedstr(cliente.Cidade) +
          Quotedstr(cliente.Uf) +  ')';


  retorno := connect.ExecSql(sql) ;

  if retorno.Success then
  begin
    result.Success := true;
    result.Message := 'Cadastrado com sucesso';
  end else
  begin
    result := retorno;
  end;


end;

function TUseCaseCliente.consistirExiste(codigo: integer): boolean;
var
 sql : string;
begin
  sql := 'select 1  from clientes where codigo = ' +  intToStr(codigo);

  result := connect.Consulta(sql).Success
end;

function TUseCaseCliente.consistirClienteVenda(codigo: integer): boolean;
var
 sql : string;
begin
  sql := 'select 1  from pedidos where codigocliente = ' +  intToStr(codigo) +
         'limit 1 ';

  result := connect.Consulta(sql).Success

end;

function TUseCaseCliente.Consultar(dto: DtoConsultaCliente): TList <DtoCliente>;
var
 sql : string;

 cliente : DtoCliente;
begin

  Flista.Clear;

   sql := 'select * from clientes where 1 = 1 ' ;

   if Dto.Codigo > 0 then
   begin
     sql := sql  +  ' and codigo = ' + inttostr(dto.codigo);
   end else
   begin

      if dto.Nome <> '' then
      begin
        sql := Sql  + ' and nome like ' + Quotedstr('%' + dto.Nome + '%');
      end;

      if Dto.Cidade <> '' then
      begin
        sql := Sql  + ' and cidade like ' + Quotedstr('%' + dto.cidade + '%');
      end;



   end;


   if connect.Consulta(sql).Success then
   begin



     with connect do
     begin
        query.First;

        while not query.Eof  do
        begin

           cliente.Codigo  := query.FieldByName('codigo').asInteger;
           Cliente.Nome    := query.FieldByName('nome').AsString;
           Cliente.Cidade  := query.FieldByName('cidade').AsString;
           Cliente.UF      := query.FieldByName('uf').AsString;
           Lista.Add(cliente);

           query.Next;

        end;

     end;


   end;

   result := Lista;

end;

function TUseCaseCliente.ConsultarId(codigo: integer): Tcliente;
var
 dto : DtoConsultaCliente;
 lista  : TList<DtoCliente>;
 cliente : TCliente;

begin

  dto.Codigo := codigo;

  cliente := Tcliente.create;

  lista :=  Consultar(dto);

  if Lista.Count > 0  then
  begin
    cliente.Codigo   := lista[0].codigo;
    cliente.Nome     := lista[0].nome;
    cliente.Cidade   := lista[0].Cidade;
    cliente.UF       := lista[0].Uf;
  end;


  result := cliente;

end;

constructor TUseCaseCliente.create;
begin

 Lista := TList<DtoCliente>.Create;
 Connect := RetornarConexao;
end;

destructor TUseCaseCliente.Destroy;
begin

  Lista.Free;

  inherited;
end;

function TUseCaseCliente.Excluir(codigo: integer): Response;
var
 sql : string;
 retorno : Response;
begin
  sql := 'delete from clientes '+
          'where codigo = '  +  intToStr(codigo);

   retorno := connect.ExecSql(sql) ;

  if retorno.Success then
  begin
    result.Success := true;
    result.Message := 'Exclu�do com sucesso';
  end else
  begin
    result := retorno;
  end;

end;


procedure TUseCaseCliente.SetLista(const Value: TList<DtoCliente>);
begin
  FLista := Value;
end;

end.
