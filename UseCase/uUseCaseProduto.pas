unit uUseCaseProduto;

interface


uses uProduto, system.SysUtils, uResponse, uConnect, uDtoProduto,
system.Generics.Collections, uSingletonConnect;


 type TUseCaseProduto = class


  private
    Connect: Tconnect;
    FLista: TList<DtoProduto>;
    procedure SetLista(const Value: TList<DtoProduto>);
    function consistirProdutoVenda(codigo : integer) : boolean;

  public

  function Cadastrar(Produto : TProduto)  : Response;
  function Alterar(Produto : TProduto)    : Response;
  function Excluir(codigo : integer)      : Response;
  function Consultar(dto : DtoConsultaProduto)    : TList<DtoProduto>;
  function ConsultarId(codigo : integer) : TProduto;

   property Lista : TList<DtoProduto> read FLista write SetLista;
   function consistirExiste(codigo : integer) : boolean;

  constructor create;
  destructor Destroy;override;



 end;

implementation

{ UseCaseProduto }

function TUseCaseProduto.Alterar(Produto: TProduto): Response;
var
 sql : string;
 retorno : Response;
begin
   sql := ' update Produtos set ' +
          ' descricao = '   +  Quotedstr(Produto.Descricao) + ',' +
          ' precovenda = ' +  Stringreplace(currTostr(Produto.PrecoVenda),',','.',[]) +  ')' +
          ' where codigo = ' +  intToStr(Produto.Codigo);


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

function TUseCaseProduto.Cadastrar(Produto: TProduto): Response;
var
 Sql : string;
 retorno :Response;
begin

   sql := ' Insert Into Produtos '+
          '(descricao,precovenda)  '+
           'values (' + Quotedstr(Produto.descricao) +  ',' +
          Stringreplace(currTostr(Produto.PrecoVenda),',','.',[]) +  ')';

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

function TUseCaseProduto.consistirExiste(codigo: integer): boolean;
var
 sql : string;
begin
  sql := 'select 1  from Produtos where codigo = ' +  intToStr(codigo);

  result := connect.Consulta(sql).Success
end;

function TUseCaseProduto.consistirProdutoVenda(codigo: integer): boolean;
var
 sql : string;
begin
  sql := 'select  1  from pedidos where ' +
         'codigoProduto = ' +  intToStr(codigo) + ' limit 1 ';

  result := connect.Consulta(sql).Success

end;

function TUseCaseProduto.Consultar(dto: DtoConsultaProduto): TList <DtoProduto>;
var
 sql : string;

 Produto : DtoProduto;
begin

  Flista.Clear;

   sql := 'select * from Produtos where 1 = 1 ' ;

   if Dto.Codigo > 0 then
   begin
     sql := sql  +  ' and codigo = ' + inttostr(dto.codigo);
   end else
   begin

      if dto.descricao <> '' then
      begin
        sql := Sql  + ' and descricao like ' + Quotedstr('%' + dto.descricao + '%');
      end;

   end;


   if connect.Consulta(sql).Success then
   begin
     with connect do
     begin
        query.First;

        while not query.Eof  do
        begin

           Produto.Codigo     := query.FieldByName('codigo').asInteger;
           Produto.Descricao  := query.FieldByName('descricao').AsString;
           Produto.Precovenda := query.FieldByName('precovenda').ascurrency;

           Lista.Add(Produto);

           query.Next;

        end;
     end;

   end;

   result := lista;


end;

function TUseCaseProduto.ConsultarId(codigo: integer): TProduto;
var
 dto : DtoConsultaProduto;
 lista  : TList<DtoProduto>;
 produto : TProduto;
begin

  dto.Codigo := codigo;

  lista :=  Consultar(dto);
  produto := TProduto.Create;


  if Lista.Count > 0  then
  begin

    produto.codigo     := lista[0].codigo;
    produto.descricao  := lista[0].descricao;
    produto.precovenda := lista[0].precovenda;

  end;

   result := produto;

end;

constructor TUseCaseProduto.create;
begin

 Lista := TList<DtoProduto>.Create;
  Connect := RetornarConexao;

end;

destructor TUseCaseProduto.Destroy;
begin

  Lista.Free;

  inherited;
end;

function TUseCaseProduto.Excluir(codigo: integer): Response;
var
 sql : string;
 retorno : Response;
begin

  sql := 'delete from Produtos '+
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


procedure TUseCaseProduto.SetLista(const Value: TList<DtoProduto>);
begin
  FLista := Value;
end;

end.
