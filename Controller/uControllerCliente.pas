unit uControllerCliente;

interface

uses ucliente, uResponse, uDtoCliente, uUseCaseCliente, system.SysUtils,
system.Generics.Collections;

type

 TControllerCliente = class


  private
  CasoUso : TUseCaseCliente;

  public

  function Cadastrar(nome, cidade, Uf : string) : Response;
  function Alterar(codigo: integer; nome, cidade, Uf : string) : Response;
  function Excluir(codigo : integer) : Response;
  function Consultar(codigo: integer;nome,cidade: string) : TList<DtoCliente>;
  function ConsultarCodigo(codigo: integer) : DtoCliente;


  constructor create;

  destructor destroy;override;


 end;

implementation

{ TControllerCliente }

function TControllerCliente.Alterar(codigo: integer; nome, cidade,
  Uf: string): Response;
var
 cliente : Tcliente;

begin

  if codigo  <= 0  then
  begin
    result.Success := false;
    result.Message := 'C�digo Inv�lido';
    exit;
  end;

  if trim(nome) = '' then
  begin
    result.Success := false;
    result.Message := 'Nome deve ser informado';
    exit;

  end;



  if not casoUso.consistirExiste(codigo) then
  begin
    result.Success := false;
    result.Message := 'C�digo inexistente';
    exit;
  end;


  cliente := CasoUso.ConsultarId(codigo);

  if trim(cidade) <> '' then cliente.cidade := cidade;
  if trim(uf) <> ''     then cliente.uf     := uf;


  result  := CasoUso.Alterar(cliente);
  cliente.Free;


end;

function TControllerCliente.Cadastrar(nome, cidade, Uf: string): Response;
var
 cliente : Tcliente;
begin


  if trim(nome) = '' then
  begin
    result.Success := false;
    result.Message := 'Nome deve ser informado';
    exit;
  end;


  cliente        := Tcliente.Create;
  cliente.Nome   := nome;
  cliente.Cidade := cidade;
  cliente.UF     := uf;

  result := CasoUso.Cadastrar(cliente);

  cliente.Free;

end;

function TControllerCliente.Consultar(codigo: integer; nome,
  cidade: string): Tlist<DtoCliente>;

  var
  dto : DtoConsultaCliente;
begin

  dto.Codigo := codigo;
  dto.Nome   := nome;
  dto.Cidade := cidade;

  result := CasoUso.Consultar(dto);

end;

function TControllerCliente.ConsultarCodigo(codigo: integer): DtoCliente;
 var
 cliente : TCliente;
begin


  result.codigo  := 0;
  result.nome    := '';


  cliente := CasoUso.ConsultarId(codigo);

  if cliente.codigo >  0 then
  begin

    result.codigo  := cliente.codigo;
    result.nome    := cliente.nome;

  end;

  cliente.Free;

end;

constructor TControllerCliente.create;
begin
  CasoUso := TUseCaseCliente.create;

end;

destructor TControllerCliente.destroy;
begin
  CasoUso.Free;
  inherited;
end;

function TControllerCliente.Excluir(codigo: integer): Response;
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
