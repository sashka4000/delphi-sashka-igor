unit dbMonitoring;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TFdb = class(TForm)
    pnlTop: TPanel;
    pnlDown: TPanel;
    ds_db: TDataSource;
    lblNameGrid: TLabel;
    dbnvgr_db: TDBNavigator;
    dbgrd_IDS: TDBGrid;
    pnlMiddle: TPanel;
    chk_bd: TCheckBox;
    btn_db_find: TButton;
    lbledt_db: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure btn_db_findClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  IP = '93.188.47.31';

var
  Fdb: TFdb;

implementation

uses
  dataModulFireDAC;

{$R *.dfm}

procedure TFdb.btn_db_findClick(Sender: TObject);
var
  flag: Boolean;
begin
  flag := True;
  dbgrd_IDS.DataSource.DataSet.First;
  while (not (dbgrd_IDS.DataSource.DataSet.Eof)) do
  begin
    if dbgrd_IDS.DataSource.DataSet.FieldByName('GUID').AsString = lbledt_db.Text then
    begin
      SetFocus;
      flag := False;
      Break;
    end
    else
    begin
      dbgrd_IDS.DataSource.DataSet.Next;
    end;
  end;
  if flag then
    MessageBox(Handle, PChar('Данный GUID не найден'), PChar('Внимание'), MB_ICONINFORMATION + MB_OK);

end;

procedure TFdb.FormCreate(Sender: TObject);
var
  p1: string;
  p2: string;
begin
  p1 := '';
  dbgrd_IDS.DataSource := ds_db;
  p2 := DateToStr(Now -60);
  if chk_bd.Checked then      p1 := IP;


  DM_fireDAC.fdqryLog_db.SQL.Text := 'select *  from IDS where ip <>  :p1 and  last_access  > :p2 order by SCADAVERSION';

  DM_fireDAC.fdqryLog_db.Active := True;

end;

end.

