unit View.Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,uControllerCliente,
  uDtoCliente, System.Generics.Collections,uUtils;

type

  Tselecionado = record
    codigo : integer;
     nome   : string;
   end;

  TFrmClientes = class(TForm)
    pnTtopo: TPanel;
    pnRodape: TPanel;
    pnGrid: TPanel;
    Label1: TLabel;
    btnFechar: TSpeedButton;
    Panel6: TPanel;
    ContainerSelecionar: TPanel;
    btnSelecionar: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    ContainerConsultar: TPanel;
    btnConsultar: TPanel;
    TableClientes: TFDMemTable;
    TableClientescodigo: TIntegerField;
    TableClientesnome: TStringField;
    TableClientescidade: TStringField;
    TableClientesuf: TStringField;
    DataSource1: TDataSource;
    edBusca: TEdit;
    cbBuscar: TComboBox;
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
  private
    { Private declarations }

     ControllerCliente : TcontrollerCliente;
    procedure fechar;
    procedure consultar;
    procedure SelecionarRegistro;
  public
    { Public declarations }

    selecionado : TSelecionado

  end;

var
  FrmClientes: TFrmClientes;


implementation

{$R *.dfm}


procedure TFrmClientes.btnFecharClick(Sender: TObject);
begin
  Fechar;
end;

procedure TFrmClientes.fechar;
begin
  ControllerCliente.Free;
  self.Close;
end;

procedure TFrmClientes.FormShow(Sender: TObject);
begin

  ControllerCliente := TControllerCliente.create;

  selecionado.codigo := 0;
  selecionado.nome   := '';

end;



procedure TFrmClientes.SelecionarRegistro;
begin

  if TableClientes.IsEmpty then
  begin
    ExibirMensagem('Aten�ao','Nenhum registro selecionado !');
    abort;
  end;

  selecionado.codigo := TableClientescodigo.AsInteger;
  selecionado.Nome := TableClientesnome.AsString;

end;

procedure TFrmClientes.consultar;
var

 Lista : Tlist<DtoCliente>;
 codigo : integer;
 Nome, cidade : string;
 cliente : Dtocliente;
begin

  Codigo := 0;
  Nome   := '';
  Cidade := '';

  case cbBuscar.ItemIndex of

    0 :
    begin

      if trim(edbusca.Text) = '' then
      begin
        ExibirMensagem('Aten��o','Informe o c�digo');
        abort;
      end;

      try

       Codigo := strToInt(edbusca.Text);

      except
        ExibirMensagem('Erro','C�digo Inv�lido');
        abort;

      end;

    end;

   1: Nome := trim(edbusca.Text);
   2: cidade := trim(edbusca.Text);

  end;


  if not TableClientes.Active then  TableClientes.Open;


  tableClientes.EmptyDataSet;

  Lista := ControllerCliente.Consultar(codigo,nome,cidade);

  if Lista.Count >  0 then
  begin

    for cliente in  Lista do
    begin

      TableClientes.Insert;

      TableClientescodigo.AsInteger := cliente.Codigo;
      TableClientesNome.asString    := cliente.Nome;
      TableClientesCidade.AsString  := cliente.Cidade;
      TableClientesUF.AsString      := cliente.UF;

      TableClientes.post;

    end;

  end;

  ExibirMensagem('Informa��o','Consulta realizada com sucesso');

end;

procedure TFrmClientes.btnSelecionarClick(Sender: TObject);
begin

  SelecionarRegistro;
  fechar;

end;

procedure TFrmClientes.btnConsultarClick(Sender: TObject);

begin

  Consultar;

end;

end.
