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
  TEKON_IP = '93.188.47.31';
// IP =   '89.23.32.63' ;

var
  Fdb: TFdb;

implementation

uses
  dataModulFireDAC, Fmodal;

{$R *.dfm}

procedure TFdb.btnVerClick(Sender: TObject);
var
 pIP : string;
begin
  if chk_bd.Checked
   then pIP := ''
   else pIP := TEKON_IP;
  DM_fireDAC.fdqryLog_mod.Active := False;
 DM_fireDAC.fdqryLog_mod.Params[0].AsString := pIP;
 DM_fireDAC.fdqryLog_mod.Params[1].AsDateTime := NOW - 60;
  DM_fireDAC.fdqryLog_mod.Active := True;
 FMod.ShowModal;
end;

procedure TFdb.btn_db_findClick(Sender: TObject);
var
  flag: Boolean;
  DS : TDataSource;
  B : TBookmark;
begin
  flag := True;
  DS := dbgrd_IDS.DataSource;
  B := DS.DataSet.GetBookmark; // запомнили позицию
  dbgrd_IDS.DataSource := nil; // отключился чтобы не пестрил
  DS.DataSet.First;
  while (not (DS.DataSet.Eof)) do
  begin
    if DS.DataSet.FieldByName('GUID').AsString = lbledt_db.Text then
    begin
      SetFocus;
      flag := False;
      Break;
    end
    else
    begin
      DS.DataSet.Next;
    end;
  end;
  if flag then
  begin
     MessageBox(Handle, PChar('Данный GUID не найден'), PChar('Внимание'), MB_ICONINFORMATION + MB_OK);
     DS.DataSet.GotoBookmark(B);
  end;

  // восстанавливаем DataSource
  dbgrd_IDS.DataSource := DS;

end;
procedure TFdb.chk_bdClick(Sender: TObject);
var
  pIP: string;
begin
  if chk_bd.Checked
   then pIP := ''
   else pIP := TEKON_IP;
  DM_fireDAC.fdqryLog_db.Active := False;
  DM_fireDAC.fdqryLog_db.ParamByName('p1').AsString := pIP;
  DM_fireDAC.fdqryLog_db.ParamByName('p2').AsDateTime := Now - 60;
  DM_fireDAC.fdqryLog_db.Active := True;
  dbgrd_IDS.DataSource.DataSet.Next;
  dbgrd_IDS.DataSource.DataSet.First;

end;

procedure TFdb.FormCreate(Sender: TObject);
begin
  chk_bdClick(nil);
end;

end.

