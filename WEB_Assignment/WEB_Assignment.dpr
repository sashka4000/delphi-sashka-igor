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
  FTripUser in 'FTripUser.pas' {frmTripUser: TUniForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
end.
