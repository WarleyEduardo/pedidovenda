unit uPedido;

interface


 type

 Tpedido = class
  private
    FCodigoCliente: integer;
    FCodigo: integer;
    FValorTotal: Currency;
    FDataEmissao: Tdate;
    FId: integer;

    procedure SetCodigoCliente(const Value: integer);
    procedure SetCodigo(const Value: integer);
    procedure SetDataEmissao(const Value: Tdate);
    procedure SetValorTotal(const Value: Currency);
    procedure SetId(const Value: integer);

  published

  property Id : integer read FId write SetId;
  property Codigo : integer read FCodigo write SetCodigo;
  property CodigoCliente : integer read FCodigoCliente write SetCodigoCliente;
  property DataEmissao : Tdate read FDataEmissao write SetDataEmissao;
  Property ValorTotal  : Currency read FValorTotal write SetValorTotal;



  constructor create;
  destructor destroy;override;

 end;

implementation

{ Tpedido }

procedure Tpedido.SetCodigoCliente(const Value: integer);
begin
  FCodigoCliente:= Value;
end;

constructor Tpedido.create;
begin

  fid := self.GetHashCode;
  FCodigo     := 0;
  FValorTotal := 0;

end;

destructor Tpedido.destroy;
begin

  inherited;
end;

procedure Tpedido.SetCodigo(const Value: integer);
begin
  FCodigo := Value;
end;

procedure Tpedido.SetDataEmissao(const Value: Tdate);
begin
  FDataEmissao := Value;
end;

procedure Tpedido.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure Tpedido.SetValorTotal(const Value: Currency);
begin
  FValorTotal := Value;
end;

end.
