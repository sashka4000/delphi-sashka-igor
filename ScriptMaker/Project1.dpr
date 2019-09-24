program Project1;

uses
  Vcl.Forms,
  main in 'main.pas' {Form1},
  setForm in 'setForm.pas' {frmSetSimple},
  setString in 'setString.pas' {frmString},
  setStringEx in 'setStringEx.pas' {frmStringEx},
  parser in 'parser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmSetSimple, frmSetSimple);
  Application.CreateForm(TfrmString, frmString);
  Application.CreateForm(TfrmStringEx, frmStringEx);
  Application.Run;
end.
