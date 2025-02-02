unit uSingletonConnect;

interface

uses uConnect;

function RetornarConexao : Tconnect;

var
 connection : Tconnect;

implementation

function RetornarConexao : Tconnect;
begin

  if not Assigned(connection)  then
  begin
    connection := Tconnect.Create;
  end;

  result := connection;
end;

end.
