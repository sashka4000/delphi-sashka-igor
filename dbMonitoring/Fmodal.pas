unit Fmodal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, Data.DB, VCLTee.TeEngine, Vcl.ExtCtrls,
  VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart, VCLTee.Series, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls;

type
  TFMod = class(TForm)
    dbcht_db: TDBChart;
    brsrsSeries_db: TBarSeries;
    tmrRefresh: TTimer;
    procedure tmrRefreshTimer(Sender: TObject);
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

procedure TFMod.tmrRefreshTimer(Sender: TObject);
begin
  if not Visible then
    Exit;
  dbcht_db.RefreshData;
end;

end.
