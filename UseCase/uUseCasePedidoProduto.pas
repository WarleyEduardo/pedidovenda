unit uUseCasePedidoProduto;

interface

uses uPedidoProduto, uResponse, uDtoPedidoProduto, uconnect,
     system.SysUtils, system.Generics.Collections,uSingletonConnect;


Type

  TUseCasePedidoProduto = class
  private
   Connect: Tconnect;

    FLista:  TList<DToPedidoProduto>;
    procedure SetLista(const Value:  TList<DToPedidoProduto>);


  public
  function Cadastrar(PedidoProduto : TPedidoProduto)   : Response;
  function Alterar(PedidoProduto : TPedidoProduto)     : Response;
  function Excluir(codigo : integer)                   : Response;
  function ExcluirItem(codigo : integer)               : Response;
  function Consultar(dto : DtoConsultaPedidoProduto)   : TList<DToPedidoProduto>;
  function ConsultarId(codigo : integer) : TPedidoProduto;
  Function RetornarValorTotal(codigo : integer) : currency;

  property Lista : TList<DToPedidoProduto> read FLista write SetLista;

  constructor create;
  destructor Destroy;override;

  end;



implementation

{ TUseCasePedidoProduto }

function TUseCasePedidoProduto.Alterar(PedidoProduto: TPedidoProduto): Response;

var
 Sql : string;
 retorno :Response;
begin

   sql := ' update PedidosProdutos set '+
          ' CodigoProduto =  '  + IntToStr(PedidoProduto.CodigoProduto) + ',' +
          ' quantidade =  '     + Stringreplace(floatTostr(PedidoProduto.Quantidade),',','.',[]) +
          ' valorunitario =  '     + Stringreplace(currTostr(PedidoProduto.ValorUnitario),',','.',[]) +
          ' valortotal =  '     + Stringreplace(currTostr(PedidoProduto.ValorTotal),',','.',[]) +
          ' where codigo = '    + intTostr(PedidoProduto.Codigo) ;


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

function TUseCasePedidoProduto.Cadastrar(PedidoProduto: TPedidoProduto): Response;
var
 Sql : string;
 retorno :Response;
begin

   sql := ' Insert into PedidosProdutos '+
          '(codigopedido,codigoproduto,quantidade,valorunitario,valortotal)  values (' +
           IntToStr(PedidoProduto.CodigoPedido) + ',' +
           IntToStr(PedidoProduto.Codigoproduto) + ',' +
           Stringreplace(floatTostr(PedidoProduto.quantidade),',','.',[]) +  ','+
           Stringreplace(currTostr(PedidoProduto.ValorUnitario),',','.',[]) +  ','+
           Stringreplace(currTostr(PedidoProduto.Valortotal),',','.',[]) +  ')';

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

function TUseCasePedidoProduto.Consultar(dto: DtoConsultaPedidoProduto): TList<DToPedidoProduto>;
var
 sql : string;

 PedidoProduto : DtoPedidoProduto;
begin

   sql := 'select * from PedidosProdutos where 1 = 1 ' ;

   if Dto.Codigo > 0 then
   begin
     sql := sql  +  ' and codigo = ' + inttostr(dto.codigo);
   end else
   begin

      if dto.CodigoPedido >  0 then
      begin
        sql := Sql  + ' and codigopedido = ' + intTostr(dto.CodigoPedido);
      end;

      if dto.CodigoProduto >  0 then
      begin
        sql := Sql  + ' and codigoproduto = ' + intTostr(dto.CodigoProduto);
      end;

   end;

    Flista.Clear;

   if connect.Consulta(sql).Success then
   begin


     with connect do
     begin
        query.First;

        while not query.Eof  do
        begin

           PedidoProduto.Codigo        := query.FieldByName('codigo').asInteger;
           PedidoProduto.CodigoPedido  := query.FieldByName('codigopedido').AsInteger;
           PedidoProduto.CodigoProduto := query.FieldByName('codigoproduto').AsInteger;
           PedidoProduto.Quantidade    := query.FieldByName('quantidade').AsFloat;
           PedidoProduto.ValorUnitario := query.FieldByName('valorunitario').AsCurrency;
           PedidoProduto.ValorTotal    := query.FieldByName('valortotal').AsCurrency;

           Lista.Add(PedidoProduto);

           query.Next;

        end;

     end;


   end;

    result := lista;

end;

function TUseCasePedidoProduto.ConsultarId(codigo: integer): TPedidoProduto;
var
 dto : DtoConsultaPedidoProduto;
 lista  : TList<DtoPedidoProduto>;

 PedidoProduto : TPedidoProduto;
begin

  dto.Codigo := codigo;

  PedidoProduto := TPedidoProduto.create;

  lista :=  Consultar(dto);

  if Lista.Count > 0  then
  begin

    PedidoProduto.Codigo        := lista[0].Codigo;
    PedidoProduto.CodigoPedido  := lista[0].CodigoPedido;
    PedidoProduto.Quantidade    := lista[0].Quantidade;
    PedidoProduto.ValorUnitario := lista[0].ValorUnitario;
    PedidoProduto.ValorTotal    := lista[0].ValorTotal;

  end;

  result := PedidoProduto;
end;

constructor TUseCasePedidoProduto.create;
begin


 Lista   := TList<DToPedidoProduto>.Create;
  Connect := RetornarConexao;
end;

destructor TUseCasePedidoProduto.Destroy;
begin

  Lista.Free;


  inherited;
end;

function TUseCasePedidoProduto.Excluir(codigo: integer): Response;
var
 sql : string;
 retorno : Response;
begin
  sql := 'delete from PedidosProdutos '+
          'where codigopedido = '  +  intToStr(codigo);

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

function TUseCasePedidoProduto.ExcluirItem(codigo: integer): Response;
var
 sql : string;
 retorno : Response;
begin
  sql := 'delete from PedidosProdutos '+
          'where codigo = '  +  intToStr(codigo);

   retorno := connect.ExecSql(sql) ;

  if retorno.Success then
  begin
    result.Success := true;
    result.Message := 'Item exclu�do com sucesso';
  end else
  begin
    result := retorno;
  end;

end;

function TUseCasePedidoProduto.RetornarValorTotal(codigo: integer): currency;
var
 sql : string;
 Total : currency;
begin

 Total := 0;

  sql := 'select  sum(valortotal) as total from pedidosprodutos ' +
         'where codigopedido = ' +  inttostr(codigo);

  if connect.Consulta(sql).Success then
  begin
    Total := connect.Query.FieldByName('total').AsCurrency;
  end;


 result := Total;

end;

procedure TUseCasePedidoProduto.SetLista(const Value: TList<DtoPedidoProduto>);
begin
  FLista := Value;
end;

end.

