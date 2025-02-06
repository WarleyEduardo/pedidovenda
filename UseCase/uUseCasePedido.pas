unit uUseCasePedido;

interface

uses uPedido, uResponse, uDtoPedido, uconnect, system.SysUtils,
 system.Generics.Collections, uUtils,uSingletonConnect;


Type

  TUseCasePedido = class
  private
   Connect: Tconnect;

    FLista: TList<DtoPedido>;
    procedure SetLista(const Value: TList<DtoPedido>);
    function RetornarCodigo(id : integer) : integer;



  public
  function Cadastrar(pedido : TPedido)   : Response;
  function Alterar(pedido : Tpedido)     : Response;
  function Excluir(codigo : integer)     : Response;
  function Consultar(dto : DtoConsultapedido)    : TList<DtoPedido>;
  function ConsultarId(codigo : integer) : Tpedido;
  function consistirExiste(codigo : integer) : boolean;
  property Lista : TList<DtoPedido> read FLista write SetLista;
  procedure IniciarOperacao;
  procedure ConfirmarOperacao;
  procedure CancelarOperacao;



  constructor create;
  destructor Destroy;override;

  end;



implementation

{ TUseCasePedido }

function TUseCasePedido.Alterar(pedido: Tpedido): Response;

var
 Sql : string;
 retorno :Response;
begin

   sql := ' update pedidos set '+
          ' codigocliente =  '  + IntToStr(pedido.CodigoCliente) + ',' +
          ' valortotal =  '     + Stringreplace(currTostr(pedido.Valortotal),',','.',[]) +
          ' where codigo = '    + intTostr(pedido.Codigo) ;


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

function TUseCasePedido.Cadastrar(pedido: TPedido): Response;
var
 Sql, data : string;
 retorno :Response;
begin

  Data := TratarData(pedido.DataEmissao);

   sql := ' Insert into pedidos '+
          '(codigocliente,DataEmissao,valorTotal,hash)  values (' +
           IntToStr(pedido.CodigoCliente) + ',' +
           QuotedStr(Data)  + ',' +
           Stringreplace(currTostr(pedido.Valortotal),',','.',[]) +  ',' +
            IntToStr(pedido.Id) +  ')';

  retorno := connect.ExecSql(sql) ;

  if retorno.Success then
  begin
    result.Success := true;
    result.Message := 'Cadastrado com sucesso';
    result.Codigo  := RetornarCodigo(pedido.id);
  end else
  begin
    result := retorno;
  end;


end;

procedure TUseCasePedido.CancelarOperacao;
begin
  connect.Rollback;
end;

procedure TUseCasePedido.ConfirmarOperacao;
begin
   connect.Commit;
end;

function TUseCasePedido.Consultar(dto: DtoConsultapedido): TList<DtoPedido>;
var
 sql,DataInicial, DataFinal : string;

 Pedido : DtoPedido;
begin

  Flista.Clear;


  DataInicial := TratarData(dto.DataInicial);
  DataFinal   := TratarData(dto.DataFinal);

   sql := 'select * from pedidos where 1 = 1 ' ;

   if Dto.Codigo > 0 then
   begin
     sql := sql  +  ' and codigo = ' + inttostr(dto.codigo);
   end else
   begin

      if dto.CodigoCliente >  0 then
      begin
        sql := Sql  + ' and codigocliente = ' + intTostr(dto.CodigoCliente);
      end;

      if (dto.DataInicial <> StrToDate('30/12/1899')) and (dto.DataFinal <> StrToDate('30/12/1899'))  then
      begin

       sql := Sql +  'and dataemissao between ' + Quotedstr(DataInicial)  +
              ' and ' + Quotedstr(DataFinal) ;

      end;

   end;


   if connect.Consulta(sql).Success then
   begin


     with connect do
     begin
        query.First;

        while not query.Eof  do
        begin



           Pedido.Codigo        := query.FieldByName('codigo').asInteger;
           Pedido.CodigoCliente := query.FieldByName('codigoCliente').AsInteger;
           Pedido.DataEmissao   := query.FieldByName('DataEmissao').AsDateTime;
           Pedido.ValorTotal    := query.FieldByName('valortotal').AsCurrency;

           Lista.Add(Pedido);

           query.Next;

        end;

     end;


   end;


    result := lista;


end;

function TUseCasePedido.consistirExiste(codigo: integer): boolean;
var
 sql: string;
begin

  sql := 'select 1 from pedidos where codigo = ' + intTostr(codigo);

  result := connect.Consulta(sql).Success


end;

function TUseCasePedido.ConsultarId(codigo: integer): Tpedido;
var
 dto : DtoConsultaPedido;
 lista  : TList<DtoPedido>;
 Pedido : TPedido;
begin

  dto.Codigo := codigo;

  Pedido := TPedido.create;

  lista :=  Consultar(dto);

  if Lista.Count > 0  then
  begin
    Pedido.Codigo           := lista[0].codigo;
    Pedido.CodigoCliente    := lista[0].CodigoCliente;
    Pedido.DataEmissao      := lista[0].DataEmissao;
    Pedido.ValorTotal       := lista[0].ValorTotal;
  end;


  result := Pedido;


end;

constructor TUseCasePedido.create;
begin
 Lista  := TList<DtoPedido>.Create;
  Connect := RetornarConexao;
end;

destructor TUseCasePedido.Destroy;
begin

  Lista.Free;

  inherited;
end;

function TUseCasePedido.Excluir(codigo: integer): Response;
var
 sql : string;
 retorno : Response;
begin
  sql := 'delete from pedidos '+
          'where codigo = '  +  intToStr(codigo);

   retorno := connect.ExecSql(sql) ;

  if retorno.Success then
  begin
    result.Success := true;
    result.Message := 'Excluído com sucesso';
  end else
  begin
    result := retorno;
  end;

end;

procedure TUseCasePedido.IniciarOperacao;
begin

 connect.StartTransaction;

end;

function TUseCasePedido.RetornarCodigo(id: integer): integer;
var
 sql : string;
 codigo :integer;
begin
  codigo := 0;

  sql := 'select codigo from pedidos where hash = ' + inttostr(id);

  if connect.Consulta(sql).Success then
  begin
    codigo := connect.Query.FieldByName('codigo').AsInteger;
  end;

  result := codigo;

end;

procedure TUseCasePedido.SetLista(const Value: TList<Dtopedido>);
begin
  FLista := Value;
end;

end.
