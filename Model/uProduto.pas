unit uProduto;

interface

type

 TProduto = class
  private
    FDescricao: string;
    Fcodigo: integer;
    FPrecoVenda: currency;
    Fid: integer;
    procedure Setcodigo(const Value: integer);
    procedure SetDescricao(const Value: string);
    procedure SetPrecoVenda(const Value: currency);
    procedure Setid(const Value: integer);
  published

  property id     : integer read Fid write Setid;
  property codigo : integer read Fcodigo write Setcodigo;
  property Descricao : string read FDescricao write SetDescricao;
  property PrecoVenda : currency read FPrecoVenda write SetPrecoVenda;

  constructor crate;

 end;

implementation

{ TProduto }

constructor TProduto.crate;
begin

 fid := self.GetHashCode;
 Fcodigo := 0;
 FPrecoVenda := 0;

end;

procedure TProduto.Setcodigo(const Value: integer);
begin
  Fcodigo := Value;
end;

procedure TProduto.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TProduto.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TProduto.SetPrecoVenda(const Value: currency);
begin
  FPrecoVenda := Value;
end;

end.
