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
    btnVer: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_db_findClick(Sender: TObject);
    procedure chk_bdClick(Sender: TObject);
    procedure btnVerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  IP = '93.188.47.31';
// IP =   '89.23.32.63' ;

var
  Fdb: TFdb;
  pIP: string;

implementation

uses
  dataModulFireDAC, Fmodal;

{$R *.dfm}

procedure TFdb.btnVerClick(Sender: TObject);
var
i: Integer;
begin
 FMod.ShowModal;
end;

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
procedure TFdb.chk_bdClick(Sender: TObject);
var
  pIP: string;
begin
if chk_bd.Checked then
   dbgrd_IDS.DataSource := ds_db;
  if chk_bd.Checked then
    pIP := IP;
  DM_fireDAC.fdqryLog_db.SQL.Text := 'select *  from IDS where ip <>  :p1 and  last_access  > :p2 order by SCADAVERSION';
  DM_fireDAC.fdqryLog_db.ParamByName('p1').AsString := pIP;
  DM_fireDAC.fdqryLog_db.ParamByName('p2').AsDateTime := Now - 60;
  DM_fireDAC.fdqryLog_db.Active := True;
end;

procedure TFdb.FormCreate(Sender: TObject);
//var
//  pIP: string;
begin
  pIP := '';
  dbgrd_IDS.DataSource := ds_db;
  if chk_bd.Checked then
    pIP := IP;
  DM_fireDAC.fdqryLog_db.SQL.Text := 'select *  from IDS where ip <>  :p1 and  last_access  > :p2 order by SCADAVERSION';
  DM_fireDAC.fdqryLog_db.ParamByName('p1').AsString := pIP;
  DM_fireDAC.fdqryLog_db.ParamByName('p2').AsDateTime := Now - 60;
  DM_fireDAC.fdqryLog_db.Active := True;

end;

end.

