unit uControllerPedido;

interface

 uses uPedido, uUseCaseCliente, uDtoPedido, uUsecasePedido, uUseCasePedidoProduto,
  system.SysUtils, system.Generics.Collections,  uresponse, uDtoPedidoProduto,
  uPedidoProduto;



 type

 TControllerPedido = class


  private
  CasoUsoPedido : TUseCasePedido;
  CasoUsoCliente : TUseCaseCliente;
  CasoUsoPedidoProduto : TUseCasePedidoProduto;

  public

  function Cadastrar(CodigoCliente: Integer;DataEmissao: Tdate; ValorTotal: currency;
  ListaItens : Tlist<DtoPedidoProduto>) : Response;
  function Alterar(codigo: integer; CodigoCliente: Integer; ValorTotal : currency) : Response;
  function Excluir(codigo : integer) : Response;
  function Consultar(codigo: integer;codigocliente: integer; DataInicial,DataFinal : Tdate) : TObjectList<TPedido>;
  function ConsultarCodigo(codigo: integer) : DtoPedido;
  function consistirExiste(codigo: integer) : boolean;


  constructor create;

  destructor destroy;override;


 end;

 implementation

{ TControllerPedido }

function TControllerPedido.Alterar(codigo, CodigoCliente: Integer ; ValorTotal: currency): Response;
  var
  Pedido : Tpedido;
begin

  if CodigoCliente  <= 0  then
  begin
    result.Success := false;
    result.Message := 'Código cliente inválido';
    exit;
  end;


  if CodigoCliente  <= 0  then
  begin
    result.Success := false;
    result.Message := 'Código cliente inválido';
    exit;
  end;


  if not CasoUsoCliente.consistirExiste(CodigoCliente) then
  begin
    result.Success := false;
    result.Message := 'Código cliente inexistente';
    exit;
  end;


  Pedido := TPedido.Create;
  pedido.CodigoCliente  := codigoCliente;
  pedido.ValorTotal     := ValorTotal;

  result := CasoUsoPedido.Alterar(pedido);


  Pedido.Free;



end;

function TControllerPedido.Cadastrar(CodigoCliente : integer;
  DataEmissao: Tdate; ValorTotal: currency; ListaItens : Tlist<DtoPedidoProduto>): Response;

  var
  Pedido : Tpedido;
  _DtoPedidoproduto : DtoPedidoProduto;
  _response : response;
  CodigoPedido : Integer;
  PedidoProduto : TPedidoProduto;
  erro : boolean;

begin

  if CodigoCliente  <= 0  then
  begin
    result.Success := false;
    result.Message := 'Código cliente inválido';
    exit;
  end;


  if CodigoCliente  <= 0  then
  begin
    result.Success := false;
    result.Message := 'Código cliente inválido';
    exit;
  end;


  if not CasoUsoCliente.consistirExiste(CodigoCliente) then
  begin
    result.Success := false;
    result.Message := 'Código cliente inexistente';
    exit;
  end;

  erro := false;

  // begin transaction

  CasoUsoPedido.IniciarOperacao;

  Pedido := TPedido.Create;
  pedido.CodigoCliente  := codigoCliente;
  pedido.DataEmissao    := DataEmissao;
  pedido.ValorTotal     := ValorTotal;

  _response := CasoUsoPedido.Cadastrar(pedido);

  erro := not _response.Success;

  if _response.Success then
  begin

    CodigoPedido := _response.Codigo;


    for _DtoPedidoproduto in ListaItens do
    begin


      PedidoProduto := TPedidoProduto.create;

      PedidoProduto.CodigoPedido  := codigoPedido;
      PedidoProduto.CodigoProduto := _DtoPedidoproduto.CodigoProduto;
      PedidoProduto.Quantidade    := _DtoPedidoproduto.Quantidade;
      PedidoProduto.ValorUnitario := _DtoPedidoproduto.ValorUnitario;
      PedidoProduto.ValorTotal    := _DtoPedidoproduto.ValorTotal;

      _response := CasoUsoPedidoProduto.Cadastrar(PedidoProduto);

      PedidoProduto.Free;


      if not _response.Success then
      begin
         erro := true;
         break;
      end;

    end;

  end;

  Pedido.Free;


  if erro then
  begin
     // roolbak
    CasoUsoPedido.CancelarOperacao;
    _response.Message := 'Operação cancelada, falha na gravação do pedido'
  end else
  begin

    // commit;
    CasoUsoPedido.ConfirmarOperacao;
    _response.Message := 'Cadastrado com sucesso';
    _response.Codigo  := CodigoPedido;

  end;


  result := _response;


end;

function TControllerPedido.Consultar(codigo, codigocliente: integer;
  DataInicial, DataFinal: Tdate): TObjectList<TPedido>;
begin

end;

function TControllerPedido.ConsultarCodigo(codigo: integer): DtoPedido;
 var
 Pedido : TPedido;
begin


  result.codigo         := 0;
  result.CodigoCliente  := 0;
  result.ValorTotal     := 0;


  Pedido := CasoUsoPedido.ConsultarId(codigo);

  if Pedido.codigo >  0 then
  begin
    result.codigo        := Pedido.codigo;
    result.CodigoCliente := Pedido.CodigoCliente;
    result.DataEmissao   := Pedido.DataEmissao;
    result.ValorTotal    := Pedido.ValorTotal;
  end;

  Pedido.Free;

end;

function TControllerPedido.consistirExiste(codigo: integer): boolean;

begin

  result := CasoUsoPedido.consistirExiste(codigo);

end;

constructor TControllerPedido.create;
begin

 CasoUsoPedido        := TUseCasePedido.create;
 CasoUsoPedidoProduto := TUseCasePedidoProduto.create;
 CasoUsocliente       := TUseCaseCliente.create;

end;

destructor TControllerPedido.destroy;
begin

 CasoUsoPedido.Free;
 CasoUsoPedidoProduto.Free;
 CasoUsocliente.Free;

  inherited;
end;

function TControllerPedido.Excluir(codigo: integer): Response;
var
 retorno : Response;
begin

 if codigo <= 0 then
  begin

    result.Success := false;
    result.Message := 'Código Inválido';
    exit;
  end;

  retorno := CasoUsoPedido.Excluir(codigo);

  if retorno.Success then
  begin
   retorno := CasoUsoPedidoProduto.Excluir(codigo);
  end;



  Result := retorno;


end;

end.
