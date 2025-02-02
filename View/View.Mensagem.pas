unit View.Mensagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFrmMensagem = class(TForm)
    pnTitulo: TPanel;
    pnFundo: TPanel;
    pnRodape: TPanel;
    Panel6: TPanel;
    ContainerOk: TPanel;
    btnok: TPanel;
    pnCentro: TPanel;
    lbmensagem: TLabel;
    containerCancelar: TPanel;
    btnCancelar: TPanel;
    procedure btnokClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }


  public
    { Public declarations }
    tipo: string;
    Confirmar : boolean;

  end;

var
  FrmMensagem: TFrmMensagem;

implementation

{$R *.dfm}

procedure TFrmMensagem.btnCancelarClick(Sender: TObject);
begin

  Confirmar := false;
  self.Close;
end;

procedure TFrmMensagem.btnokClick(Sender: TObject);
begin
  confirmar := true;
  self.Close;
end;

procedure TFrmMensagem.FormShow(Sender: TObject);
begin
  Confirmar := false;



  if tipo = 'confirmar' then
  begin
     pnTitulo.Caption := 'Confirmação';

     btnok.Caption := 'Sim';
     ContainerOk.Left := 10;
     containerCancelar.Left := 180;
     containerCancelar.Visible := true;

  end else
  begin

    ContainerOk.Left := 247;
    containerCancelar.Visible := false;

  end;





end;

end.
