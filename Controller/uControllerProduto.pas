unit uControllerProduto;

interface

uses uProduto, uResponse, uDtoProduto, uUseCaseProduto, system.SysUtils,
system.Generics.Collections;

type

 TControllerProduto = class

 private
  CasoUso : TUseCaseProduto;

  public
  function Cadastrar(descricao : string;  PrecoVenda : currency) : Response;
  function Alterar(codigo: integer;descricao : string; PrecoVenda : currency) : Response;
  function Excluir(codigo : integer) : Response;
  function Consultar(codigo: integer;descricao: string) : Tlist<DtoProduto>;
  function ConsultarCodigo(codigo: integer) : DtoProduto;



  constructor create;

  destructor destroy;override;


 end;

implementation

{ TControllerProduto }

function TControllerProduto.Alterar(codigo: integer;descricao : string; PrecoVenda : currency): Response;
var
 Produto : TProduto;

begin

  if codigo  <= 0  then
  begin
    result.Success := false;
    result.Message := 'C�digo Inv�lido';
    exit;
  end;

  if trim(descricao) = ''  then
  begin
    result.Success := false;
    result.Message := 'Descri��o deve ser informada';
    exit;
  end;


  if PrecoVenda  <= 0  then
  begin
    result.Success := false;
    result.Message := 'Preco de Venda deve ser informado';
    exit;
  end;


  if not casoUso.consistirExiste(codigo) then
  begin
    result.Success := false;
    result.Message := 'C�digo inexistente';
    exit;
  end;

  Produto := TProduto.Create;

  Produto := CasoUso.ConsultarId(codigo);
  Produto.Descricao := Descricao;
  Produto.PrecoVenda := Precovenda;

  result  := CasoUso.Alterar(Produto);
  Produto.Free;

end;

function TControllerProduto.Cadastrar(descricao : string;  PrecoVenda : currency): Response;
var
 Produto : TProduto;
begin

  if trim(descricao) = '' then
  begin
    result.Success := false;
    result.Message := 'Descri��o deve ser informada';
    exit;
  end;

  if PrecoVenda <=  0  then
  begin
    result.Success := false;
    result.Message := 'Pre�o de venda deve ser informado';
    exit;
  end;

  Produto   := TProduto.Create;
  Produto.descricao   := descricao;
  Produto.PrecoVenda  := PrecoVenda;

  result := CasoUso.Cadastrar(Produto);

  Produto.Free;

end;

function TControllerProduto.Consultar(codigo: integer; descricao: string): TList<DtoProduto>;

  var
  dto : DtoConsultaProduto;
begin

  dto.Codigo := codigo;
  dto.descricao   := descricao;

  result := CasoUso.Consultar(dto);

end;

function TControllerProduto.ConsultarCodigo(codigo:integer): DtoProduto;
 var
 Produto : TProduto;
begin


  result.codigo     := 0;
  result.Descricao  := '';
  result.PrecoVenda := 0;


  Produto := CasoUso.ConsultarId(codigo);

  if Produto.codigo >  0 then
  begin

    result.codigo     := Produto.codigo;
    result.Descricao  := produto.Descricao;
    result.PrecoVenda := produto.PrecoVenda;

  end;

  produto.Free;

end;

constructor TControllerProduto.create;
begin
  CasoUso := TUseCaseProduto.create;

end;

destructor TControllerProduto.destroy;
begin
  CasoUso.Free;
  inherited;
end;

function TControllerProduto.Excluir(codigo: integer): Response;
begin

  if codigo <= 0 then
  begin

    result.Success := false;
    result.Message := 'C�digo Inv�lido';
    exit;
  end;


  result := CasoUso.Excluir(codigo);

end;


end.


end.
