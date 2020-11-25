unit Fmodal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, Data.DB, VCLTee.TeEngine, Vcl.ExtCtrls,
  VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart, VCLTee.Series, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFMod = class(TForm)
    dbcht_db: TDBChart;
    brsrsSeries_db: TBarSeries;
    ds_mod: TDataSource;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMod: TFMod;

implementation

uses
  dbMonitoring, dataModulFireDAC;

{$R *.dfm}

//   Dbchart, dataSource, Query

procedure TFMod.FormShow(Sender: TObject);
begin
pIP := dbMonitoring.pIP;

DM_fireDAC.fdqryLog_mod.SQL.Text :=  'select COUNT(*), SCADAVERSION  from IDS where ip <>:p1 and  last_access  > :p2 group by SCADAVERSION order by 1 ';
DM_fireDAC.fdqryLog_mod.ParamByName('p1').AsString := pIP;
DM_fireDAC.fdqryLog_mod.ParamByName('p2').AsDateTime := Now - 60;
DM_fireDAC.fdqryLog_mod.Active := True;
end;

end.
