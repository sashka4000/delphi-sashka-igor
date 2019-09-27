program Project1;

uses
  Vcl.Forms,
  main in 'main.pas' {frmMain},
  setForm in 'setForm.pas' {frmSetSimple},
  setString in 'setString.pas' {frmString},
  setStringEx in 'setStringEx.pas' {frmStringEx},
  parser in 'parser.pas',
  setComboEx in 'setComboEx.pas' {frmComboEx};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSetSimple, frmSetSimple);
  Application.CreateForm(TfrmString, frmString);
  Application.CreateForm(TfrmStringEx, frmStringEx);
  Application.CreateForm(TfrmComboEx, frmComboEx);
  Application.Run;
end.
