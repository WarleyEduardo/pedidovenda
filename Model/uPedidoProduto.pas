unit uPedidoProduto;

interface

type

 TPedidoProduto = class
  private
    FCodigo: integer;
    FValorUnitario: Currency;
    FCodigoProduto: integer;
    FValorTotal: currency;
    FQuantidade: real;
    FId: Integer;
    FCodigoPedido: Integer;
    procedure SetCodigo(const Value: integer);
    procedure SetCodigoProduto(const Value: integer);
    procedure SetQuantidade(const Value: real);
    procedure SetValorTotal(const Value: currency);
    procedure SetValorUnitario(const Value: Currency);
    procedure SetId(const Value: Integer);
    procedure SetCodigoPedido(const Value: Integer);
  published


   property Id : Integer read FId write SetId;
   property Codigo        : integer read FCodigo write SetCodigo;
   property CodigoPedido  : Integer read FCodigoPedido write SetCodigoPedido;
   property CodigoProduto : integer read FCodigoProduto write SetCodigoProduto;
   property Quantidade    : real read FQuantidade write SetQuantidade;
   property ValorUnitario : Currency read FValorUnitario write SetValorUnitario;
   property ValorTotal    : currency read FValorTotal write SetValorTotal;

   constructor create;

 end;

implementation

{ TPedidoProduto }

constructor TPedidoProduto.create;
begin
  fid := self.GetHashCode;
  FCodigo := 0;
  FValorUnitario := 0;
  FQuantidade    := 0;
  FValorTotal    := 0;
end;

procedure TPedidoProduto.SetCodigo(const Value: integer);
begin
  FCodigo := Value;
end;

procedure TPedidoProduto.SetCodigoPedido(const Value: Integer);
begin
  FCodigoPedido := Value;
end;

procedure TPedidoProduto.SetCodigoProduto(const Value: integer);
begin
  FCodigoProduto := Value;
end;

procedure TPedidoProduto.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TPedidoProduto.SetQuantidade(const Value: real);
begin
  FQuantidade := Value;
end;

procedure TPedidoProduto.SetValorTotal(const Value: Currency);
begin
  FValorTotal := Value;
end;

procedure TPedidoProduto.SetValorUnitario(const Value: Currency);
begin
  FValorUnitario := Value;
end;

end.
