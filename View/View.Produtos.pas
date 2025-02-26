unit View.Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,  uDtoProduto,
   system.Generics.Collections, uControllerProduto,uUtils;

type

  Tselecionado = record
    codigo : integer;
    Descricao   : string;
    Preco       : currency;
   end;

  TFrmProdutos = class(TForm)
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
    TableProdutos: TFDMemTable;
    DataSource1: TDataSource;
    TableProdutoscodigo: TIntegerField;
    TableProdutosdescricao: TStringField;
    TableProdutosprecovenda: TCurrencyField;
    cbBuscar: TComboBox;
    edBusca: TEdit;
    procedure btnFecharClick(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    ControllerProduto : TControllerProduto;

    procedure consultar;
    procedure SelecionarRegistro;
    procedure fechar;

  public
    { Public declarations }

    Selecionado : Tselecionado;
  end;

var
  FrmProdutos: TFrmProdutos;

implementation

{$R *.dfm}

procedure TFrmProdutos.btnConsultarClick(Sender: TObject);
begin
  Consultar;
end;

procedure TFrmProdutos.btnFecharClick(Sender: TObject);
begin
 fechar;
end;

procedure TFrmProdutos.btnSelecionarClick(Sender: TObject);
begin
  SelecionarRegistro;
  fechar;;
end;

procedure TFrmProdutos.consultar;
var
 Lista : TList<DtoProduto>;
 produto: DtoProduto;
 codigo : integer;
 descricao : string;
begin
  codigo := 0;
  descricao := '';

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

    1: descricao := trim(edbusca.Text);
  end;

  Lista := ControllerProduto.Consultar(codigo,Descricao) ;

  if not TableProdutos.Active then  TableProdutos.Open;

  TableProdutos.EmptyDataSet;

  if Lista.Count >  0 then
  begin

    for produto in  Lista do
    begin

      TableProdutos.Insert;

      TableProdutoscodigo.AsInteger := produto.Codigo;
      TableProdutosdescricao.asString    := produto.descricao;
      TableProdutosprecovenda.Ascurrency  := produto.precovenda;

      TableProdutos.post;

    end;

  end;

  ExibirMensagem('Informa��o','Consulta realizada com sucesso');


end;

procedure TFrmProdutos.fechar;
begin

  ControllerProduto.Free;
  self.Close;
end;

procedure TFrmProdutos.FormShow(Sender: TObject);
begin

  ControllerProduto := TControllerProduto.create;

  selecionado.codigo    := 0 ;
  selecionado.Descricao := '';
  selecionado.Preco     := 0;

end;

procedure TFrmProdutos.SelecionarRegistro;
begin

  if TableProdutos.IsEmpty then
  begin
    ExibirMensagem('Aten��o','Nenhum registro selecionado !');
    abort;
  end;

  selecionado.codigo    := TableProdutosCodigo.AsInteger;
  selecionado.Descricao := TableProdutosDescricao.AsString;
  selecionado.Preco     := TableProdutosPrecoVenda.Ascurrency;

end;

end.
