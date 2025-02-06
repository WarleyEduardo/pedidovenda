unit uConnect;

interface

uses UResponse,

  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Phys.MySQL, inifiles, system.SysUtils, Vcl.Dialogs,
  uUtils;


type

 Tconnect = class

    private

    Connection : TFDConnection;
    FDPhysMySQLDriverLink : TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FQuery: TFdQuery;
    procedure SetQuery(const Value: TFdQuery);



    public

    property  Query : TFdQuery read FQuery write SetQuery;
    function Consulta(Sql : string) : Response;
    function ExecSql(sql: string)   : Response;
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;

     constructor Create;
     destructor destroy;override;

 end;

implementation

uses
  Vcl.Forms;

{ Tconnect }

procedure Tconnect.Commit;
var
 sql :string;
begin
  sql := 'COMMIT';

  self.ExecSql(sql);

end;

function Tconnect.Consulta(Sql: string): Response;

begin


  try

    Query.sql.Clear;
    query.SQL.Add(sql);
    query.Open();

    if query.IsEmpty then
    begin
      result.Success := false;
      result.Message := 'Consulta sem resultado';
    end
    else
    begin
      result.Success := true;
      result.Message := 'Consulta com sucesso';
    end;

  except

     on E:exception do
     begin

       result.Success := false;
       result.Message :=  e.Message;

     end;

  end;




end;

constructor Tconnect.Create;
var
 Diretorio, server, user, database, password, driver, pathDll, Port : string;
 ArquivoIni : Tinifile;
begin


  Diretorio   := ExtractFilePath(ParamStr(0));
  ArquivoIni  := TInifile.Create(diretorio +'\configuracao.ini');
  Server      := ArquivoIni.ReadString('conexao','server','');
  Database    := ArquivoIni.ReadString('conexao','database','');
  User        := ArquivoIni.ReadString('conexao','username','');
  Port        := ArquivoIni.ReadString('conexao','port','');
  Password    := ArquivoIni.ReadString('conexao','password','');
  pathDll    := ArquivoIni.ReadString('conexao','pathdll','');

  Driver      := 'MYSQL';

  try


    Connection  := TFDConnection.Create(nil);

    FDPhysMySQLDriverLink := TFDPhysMySQLDriverLink.create(nil);
    FDGUIxWaitCursor       := TFDGUIxWaitCursor.Create(nil);

    FDPhysMySQLDriverLink.VendorLib := pathDll;

    Connection.LoginPrompt := false;
    Connection.Params.Clear;
    Connection.Params.Add('DriverID='+Driver);
    Connection.Params.Add('Database='+Database);
    Connection.Params.Add('Password='+Password);
    Connection.Params.Add('User_name='+User);
    Connection.Params.Add('Server='+Server);
    Connection.Params.Add('Port='+Port);


    Connection.Open() ;

    Query  := TFDQuery.Create(nil);
    Query.Connection := Connection;

  except

     on E:exception do
     begin

        Connection.Free;
        FDPhysMySQLDriverLink.Free;
        FDGUIxWaitCursor.Free;
        Query.Free;

        ExibirMensagem('Erro','erro ao conectar ao banco de dados'  +#13#10 +
                     e.Message );

       application.terminate;

     end;

  end;



end;

destructor Tconnect.destroy;
begin

  Connection.Free;
  Fquery.Free;
  FDPhysMySQLDriverLink.Free;
  FDGUIxWaitCursor.Free;

  inherited;
end;

function Tconnect.ExecSql(sql: string) : Response;
begin

   try

     fquery.SQL.Clear;
     fquery.SQL.Add(sql);
     fquery.ExecSQL;

     Result.Success := true;
     Result.Message := 'Executado com sucesso';

   except

     on E:exception do
     begin

      Result.Success := false;
      Result.Message := e.Message;

     end;

   end;


end;

procedure Tconnect.Rollback;
var
 sql :string;
begin
  sql := 'ROLLBACK';

  self.ExecSql(sql);

end;

procedure Tconnect.SetQuery(const Value: TFdQuery);
begin
  FQuery := Value;
end;

procedure Tconnect.StartTransaction;
var
 sql :string;
begin
  sql := 'START TRANSACTION';

  self.ExecSql(sql);

end;

end.
