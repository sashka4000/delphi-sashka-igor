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
    ds_Par: TDataSource;
    lnsrsChLine: TLineSeries;
    procedure FormShow(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure dtpBeginChange(Sender: TObject);
    procedure dtpEndChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SelectedClientID : Integer;
  end;

var
  frmParm: TfrmParm;
  tBegin, tEnd : TDateTime;
implementation

uses
  dbMonitoring, dataModulFireDAC;

{$R *.dfm}

procedure TfrmParm.btnRefreshClick(Sender: TObject);
var
  SelectedParametr: string;
begin
  SelectedParametr := dbgrdPar.DataSource.DataSet.Fields[0].AsString;
  DM_fireDAC.fdqry_Chart_Par.Active := False;
  DM_fireDAC.fdqry_Chart_Par.ParamByName('p').AsString := SelectedParametr;
  DM_fireDAC.fdqry_Chart_Par.ParamByName('tbegin').AsDateTime := tBegin;
  DM_fireDAC.fdqry_Chart_Par.ParamByName('tend').AsDateTime := tEnd;
  DM_fireDAC.fdqry_Chart_Par.Active := True;
end;

procedure TfrmParm.dtpBeginChange(Sender: TObject);
begin
  tBegin := dtpBegin.DateTime;

end;

procedure TfrmParm.dtpEndChange(Sender: TObject);
begin
  tEnd := dtpEnd.DateTime;
end;

procedure TfrmParm.FormCreate(Sender: TObject);
begin
  tBegin := dtpBegin.DateTime;
  tEnd := dtpEnd.DateTime;
end;

procedure TfrmParm.FormShow(Sender: TObject);
begin
  DM_fireDAC.fdqryParam.Active := False;
  DM_fireDAC.fdqryParam.ParamByName('p').AsInteger := SelectedClientID;
  DM_fireDAC.fdqryParam.Active := True;
end;

end.

