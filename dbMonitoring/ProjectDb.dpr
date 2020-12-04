program ProjectDb;

uses
  Vcl.Forms,
  dbMonitoring in 'dbMonitoring.pas' {Fdb},
  dataModulFireDAC in 'dataModulFireDAC.pas' {DM_fireDAC: TDataModule},
  Fmodal in 'Fmodal.pas' {FMod},
  FParam in 'FParam.pas' {frmParm},
  settings in 'settings.pas',
  FInfo in 'FInfo.pas' {frmInfo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM_fireDAC, DM_fireDAC);
  Application.CreateForm(TFdb, Fdb);
  Application.CreateForm(TFMod, FMod);
  Application.CreateForm(TfrmParm, frmParm);
  Application.Run;
end.
