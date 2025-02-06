unit uControllerPedidoProduto;

interface

 uses uPedidoProduto, uProduto, uUseCaseProduto, uDtoPedidoProduto, uUseCasePedidoProduto,
 system.SysUtils, system.Generics.Collections,  uresponse;


 type

 TControllerPedidoProduto = class


  private
  CasoUsoPedidoProduto : TUseCasePedidoProduto;
  CasoUsoProduto : TUseCaseProduto;


  public

  function Cadastrar(codigoPedido, codigoProduto: Integer;quantidade : real; ValorUnitario: currency) : Response;
  function Alterar(codigo : integer; quantidade : real; ValorUnitario: currency) : Response;
  function Excluir(CodigoPedido : integer) : Response;
  function ExcluirItem(codigo : integer) : Response;
  function ConsultarCodigo(codigo: integer) : TList<DToPedidoProduto>;


  constructor create;

  destructor destroy;override;


 end;


 implementation

{ TControllerPedidoProduto }

function TControllerPedidoProduto.Alterar(codigo: Integer; quantidade : real; ValorUnitario: currency): Response;

  var
  PedidoProduto : TPedidoProduto;
  Produto : TProduto;

begin

  if codigo  <= 0  then
  begin
    result.Success := false;
    result.Message := 'C�digo pedido inv�lido';
    exit;
  end;


  if quantidade  <= 0  then
  begin
    result.Success := false;
    result.Message := 'Quantidade inv�lida';
    exit;
  end;


  if ValorUnitario  <= 0  then
  begin
    result.Success := false;
    result.Message := 'Valor  inv�lido';
    exit;
  end;


  PedidoProduto := CasoUsoPedidoProduto.ConsultarId(codigo);

  PedidoProduto.Codigo        := codigo;
  PedidoProduto.Quantidade    := Quantidade;
  PedidoProduto.ValorUnitario := ValorUnitario;
  PedidoProduto.ValorTotal    := PedidoProduto.Quantidade *  PedidoProduto.ValorUnitario;

  result := CasoUsoPedidoProduto.Cadastrar(PedidoProduto);

  PedidoProduto.Free;

end;

function TControllerPedidoProduto.Cadastrar(codigoPedido, codigoProduto: Integer;
quantidade : real; ValorUnitario : currency): Response;

  var
  PedidoProduto : TPedidoProduto;

begin

  if codigoPedido  <= 0  then
  begin
    result.Success := false;
    result.Message := 'C�digo pedido inv�lido';
    exit;
  end;


  if codigoProduto  <= 0  then
  begin
    result.Success := false;
    result.Message := 'C�digo produto inv�lido';
    exit;
  end;



  if quantidade  <= 0  then
  begin
    result.Success := false;
    result.Message := 'quantidade inv�lida';
    exit;
  end;


  if ValorUnitario  <= 0  then
  begin
    result.Success := false;
    result.Message := 'valor inv�lido';
    exit;
  end;


  if not CasoUsoProduto.consistirExiste(codigoProduto) then
  begin
    result.Success := false;
    result.Message := 'C�digo produto inexistente';
    exit;
  end;


  PedidoProduto := TPedidoProduto.Create;

  PedidoProduto.CodigoPedido         := codigoPedido;
  PedidoProduto.CodigoProduto        := codigoProduto;
  PedidoProduto.Quantidade           := Quantidade;
  PedidoProduto.ValorUnitario        := ValorUnitario;
  PedidoProduto.ValorTotal           := PedidoProduto.Quantidade *  PedidoProduto.ValorUnitario;

  result := CasoUsoPedidoProduto.Cadastrar(PedidoProduto);


end;

function TControllerPedidoProduto.ConsultarCodigo(codigo: Integer): TList<DtoPedidoProduto>;
var
 dto : DtoConsultaPedidoProduto;
begin

  Dto.Codigo        := 0;
  Dto.CodigoPedido  := codigo;
  Dto.CodigoProduto := 0;

  result := CasoUsoPedidoProduto.Consultar(Dto);


end;

constructor TControllerPedidoProduto.create;
begin

 CasoUsoPedidoProduto := TUseCasePedidoProduto.create;
 CasoUsoProduto       := TUseCaseProduto.create;

end;

destructor TControllerPedidoProduto.destroy;
begin

  CasoUsoPedidoProduto.Free;
  CasoUsoProduto.Free;

  inherited;
end;

function TControllerPedidoProduto.Excluir(CodigoPedido: integer): Response;
begin

 if CodigoPedido <= 0 then
 begin

   result.Success := false;
   result.Message := 'C�digo Inv�lido';
   exit;

 end;

 Result := CasoUsoPedidoProduto.Excluir(CodigoPedido);

end;

function TControllerPedidoProduto.ExcluirItem(codigo: integer): Response;
begin

  if codigo <= 0 then
  begin

   result.Success := false;
   result.Message := 'C�digo Inv�lido';
   exit;

  end;

  Result := CasoUsoPedidoProduto.ExcluirItem(codigo);


end;


end.

