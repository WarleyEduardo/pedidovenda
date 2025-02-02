unit uDtoPedidoProduto;

interface

type

 DtoConsultaPedidoProduto  = record

  Codigo,
  CodigoPedido ,
  CodigoProduto: integer;

 end;


 DtoPedidoProduto = record

   Codigo,
  CodigoPedido ,
  CodigoProduto: integer;
  Quantidade : real;
  valorUnitario,
  ValorTotal : currency;

 end;

implementation

end.
