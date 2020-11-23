program ProjectDb;

uses
  Vcl.Forms,
  dbMonitoring in 'dbMonitoring.pas' {Fdb},
  dataModulFireDAC in 'dataModulFireDAC.pas' {DM_fireDAC: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM_fireDAC, DM_fireDAC);
  Application.CreateForm(TFdb, Fdb);
  Application.Run;
end.
