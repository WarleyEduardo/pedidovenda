unit uUtils;

interface

uses
  Vcl.Dialogs, system.SysUtils, system.StrUtils,  View.Mensagem;

 procedure ExibirMensagem(Titulo, msg : string);
 function confirmar(msg : string) : boolean;

 function TratarData(Data : Tdate) : string;

implementation


 function TratarData(Data : Tdate) : string;
 var
  _data : string;
 begin


  _data := datetoStr(data);
  _data := copy(_data,7) + '-' + copy(_data,4,2) + '-' + copy(_data,1,2);
  Result := _data;

 end;

 function confirmar(msg : string) : boolean;
 var
  confirmar : boolean;
 begin

   FrmMensagem := TFrmMensagem.Create(nil);
   FrmMensagem.tipo := 'confirmar';
   FrmMensagem.pnTitulo.Caption := 'Confirmar';
   FrmMensagem.lbmensagem.Caption := msg;
   FrmMensagem.ShowModal;
   confirmar := FrmMensagem.Confirmar;
   FrmMensagem.Free;

   result := confirmar;

 end;

 procedure ExibirMensagem(Titulo, msg : string);
 begin
   FrmMensagem := TFrmMensagem.Create(nil);
   FrmMensagem.pnTitulo.Caption   := Titulo ;
   FrmMensagem.lbmensagem.Caption := msg;
   FrmMensagem.ShowModal;
   FrmMensagem.Free;
 end;

end.
