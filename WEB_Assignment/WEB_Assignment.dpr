program WEB_Assignment;

uses
  Forms,
  ServerModule in 'ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'MainModule.pas' {UniMainModule: TUniGUIMainModule},
  Main in 'Main.pas' {MainForm: TUniForm},
  FormLogin in 'FormLogin.pas' {LoginForm: TUniLoginForm},
  FGreeting in 'FGreeting.pas' {frmGreeting: TUniForm},
  FRegistration in 'FRegistration.pas' {frmRegistration: TUniForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
end.
