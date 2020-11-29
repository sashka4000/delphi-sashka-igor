unit FParam;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, VclTee.TeeGDIPlus, Data.DB, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.DBChart, VCLTee.Series, DateUtils;

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
    lbl_reg_text: TLabel;
    lbl_last_text: TLabel;
    lbl_reg_date: TLabel;
    lbl_last_date: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    SelectedClientID : Integer;
    SelectedClientRegDate, SelectedClientLastAccess : TDateTime;
  end;

var
  frmParm: TfrmParm;

implementation

uses
  dbMonitoring, dataModulFireDAC;

{$R *.dfm}

procedure TfrmParm.btnRefreshClick(Sender: TObject);
var
  SelectedParametr: string;
begin
  SelectedParametr := dbgrdPar.DataSource.DataSet.Fields[0].AsString;
  // Запрос должен вывести график изменения параметра на указанном интервале
  // для выбранного нами ранее пользователя
  // вопрос 1. строится ли запрос по выбранному пользователю SelectedClientID?
  // или как ?  решен
  // вопрос 2. при указаннии интервала 01.11.2020 по 01.11.2020 - построится ли что-то?
  // должно ли построиться по логике ? ожидания пользователя когда он хочет увидеть
  // изменения параметра за 1 ноября ?
  DM_fireDAC.fdqry_Chart_Par.Active := False;
  DM_fireDAC.fdqry_Chart_Par.ParamByName('p').AsString := SelectedParametr;
  DM_fireDAC.fdqry_Chart_Par.ParamByName('p1').AsInteger := SelectedClientID;
  if DateOf(dtpBegin.DateTime) = DateOf(dtpEnd.DateTime) then
  begin
    DM_fireDAC.fdqry_Chart_Par.ParamByName('tbegin').AsDateTime := dtpBegin.DateTime;
    DM_fireDAC.fdqry_Chart_Par.ParamByName('tend').AsDateTime := IncDay(dtpBegin.DateTime);
  end
  else
  begin
    DM_fireDAC.fdqry_Chart_Par.ParamByName('tbegin').AsDateTime := dtpBegin.DateTime;
    DM_fireDAC.fdqry_Chart_Par.ParamByName('tend').AsDateTime := dtpEnd.DateTime;
  end;

  DM_fireDAC.fdqry_Chart_Par.Active := True;
  dbchtParm.UndoZoom;
end;


procedure TfrmParm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dtpBegin.MaxDate := Now;
  dtpBegin.MinDate := 0;
  dtpEnd.MaxDate := Now;
  dtpEnd.MinDate := 0;
   DM_fireDAC.fdqry_Chart_Par.Active := False;
  dbchtParm.UndoZoom;
end;

procedure TfrmParm.FormShow(Sender: TObject);
begin
  DM_fireDAC.fdqryParam.Active := False;
  DM_fireDAC.fdqryParam.ParamByName('p').AsInteger := SelectedClientID;
  DM_fireDAC.fdqryParam.Active := True;
  dtpBegin.Date := DateOf(SelectedClientRegDate);
  dtpEnd.Date := DateOf(SelectedClientLastAccess);
  dtpBegin.MaxDate :=DateOf(SelectedClientLastAccess);
  dtpBegin.MinDate := DateOf(SelectedClientRegDate) ; // Постоянно выдает ошибку выхода за минимальны предел
  dtpEnd.MaxDate := DateOf(SelectedClientLastAccess);
  dtpEnd.MinDate := DateOf(SelectedClientRegDate) ;

  lbl_last_date.Caption := DateTimeToStr(SelectedClientLastAccess);
  lbl_reg_date.Caption := DateTimeToStr(SelectedClientRegDate);
end;

end.

