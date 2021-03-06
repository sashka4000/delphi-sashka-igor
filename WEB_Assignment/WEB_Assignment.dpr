program WEB_Assignment;

uses
  Forms,
  ServerModule in 'ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'MainModule.pas' {UniMainModule: TUniGUIMainModule},
  FormLogin in 'FormLogin.pas' {LoginForm: TUniLoginForm},
  FRegistration in 'FRegistration.pas' {frmRegistration: TUniForm},
  FAdmin in 'FAdmin.pas' {frmAdmin: TUniForm},
  FUser in 'FUser.pas' {frmUser: TUniForm},
  FChange in 'FChange.pas' {frmChange: TUniForm},
  FTripUser in 'FTripUser.pas' {frmTripUser: TUniForm},
  FTripAdmin in 'FTripAdmin.pas' {frmTripAdmin: TUniForm},
  FRecord in 'FRecord.pas' {frmRecord: TUniForm},
  FAdminStat in 'FAdminStat.pas' {frmAdminStat: TUniForm},
  FTestFreeForm in 'FTestFreeForm.pas' {UniForm2: TUniForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
end.
