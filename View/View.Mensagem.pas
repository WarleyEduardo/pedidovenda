unit View.Mensagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TFrmMensagem = class(TForm)
    pnTitulo: TPanel;
    pnFundo: TPanel;
    pnRodape: TPanel;
    Panel6: TPanel;
    pnCentro: TPanel;
    lbmensagem: TLabel;
    btnCancelar: TBitBtn;
    btnok: TBitBtn;
    procedure btnokClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TFrmMensagem.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;


end;

procedure TFrmMensagem.FormShow(Sender: TObject);
begin
  Confirmar := false;



  if tipo = 'confirmar' then
  begin
     pnTitulo.Caption := 'Confirmação';

     btnok.Caption := 'Sim';
     btnOk.Left := 10;
     btnCancelar.Left := 140;
     btnCancelar.Visible := true;

     btnOK.SetFocus;


  end else
  begin

    btnOk.Left := 247;
    btnCancelar.Visible := false;
    btnok.SetFocus;

  end;


end;

end.
