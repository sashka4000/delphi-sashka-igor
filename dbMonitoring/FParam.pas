unit FParam;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, VclTee.TeeGDIPlus, Data.DB, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.DBChart, VCLTee.Series;

type
  TfrmParm = class(TForm)
    pnlTop: TPanel;
    pnlFooter: TPanel;
    pnlLeft: TPanel;
    pnlRight: TPanel;
    dbchtParm: TDBChart;
    dbgrdPar: TDBGrid;
    dtpBegin: TDateTimePicker;
    dtpEnd: TDateTimePicker;
    btnRefresh: TButton;
    lnsrsChLine: TLineSeries;
  private
    { Private declarations }
  public
    { Public declarations }
    SelectedClientID : Integer;
  end;

var
  frmParm: TfrmParm;

implementation

uses
  dbMonitoring, dataModulFireDAC;

{$R *.dfm}

end.
