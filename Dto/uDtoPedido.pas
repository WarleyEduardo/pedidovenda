unit uDtoPedido;

interface

type

 DtoConsultaPedido = record
  Codigo,
  CodigoCliente : integer;
  DataInicial,
  DataFinal : Tdate;

 end;

  DtoPedido = record
  Codigo,
  CodigoCliente : integer;
  DataEmissao: Tdate;
  ValorTotal : currency;

 end;



implementation

end.
