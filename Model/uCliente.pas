unit uCliente;


interface


type


 TCliente = class
  private
    FUF: string;
    FCodigo: Integer;
    FNome: string;
    FCidade: string;
    FId: integer;
    procedure SetCidade(const Value: string);
    procedure SetCodigo(const Value: Integer);
    procedure SetNome(const Value: string);
    procedure SetUF(const Value: string);
    procedure SetId(const Value: integer);
  published

  property Id     : integer read FId write SetId;
  property Codigo : Integer read FCodigo write SetCodigo;
  property  Nome   : string read FNome write SetNome;
  property Cidade : string read FCidade write SetCidade;
  property  UF     : string read FUF write SetUF;


  constructor create;


 end;

implementation

{ TCliente }

constructor TCliente.create;
begin

 fid := self.GetHashCode;
 FCodigo := 0;

end;

procedure TCliente.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TCliente.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TCliente.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TCliente.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TCliente.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.
