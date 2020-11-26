unit dbMonitoring;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

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
    lblCountClient: TLabel;
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

//   192.168.254.1
var
  Fdb: TFdb;
  countClient: Integer;

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
  DS: TDataSource;
//  B: TBookmark;
  pIP: string;
begin
  DS := dbgrd_IDS.DataSource;
//  B := DS.DataSet.GetBookmark; // запомнили позицию
//  dbgrd_IDS.DataSource := nil; // отключился чтобы не пестрил
  if chk_bd.Checked then
    pIP := ''
  else
    pIP := TEKON_IP;

  DM_fireDAC.fdqryLog_db.Active := False;
  DM_fireDAC.fdqryLog_db.ParamByName('p1').AsString := pIP;
  DM_fireDAC.fdqryLog_db.ParamByName('p2').AsDateTime := Now - 60;
  DM_fireDAC.fdqryLog_db.Active := True;
  DS.DataSet.First;
//  countClient := 0;
// ******************************
  DM_fireDAC.fdqry_countClient.Active := False;
  DM_fireDAC.fdqry_countClient.ParamByName('p1').AsString := pIP;
  DM_fireDAC.fdqry_countClient.ParamByName('p2').AsDateTime := Now - 60;
  DM_fireDAC.fdqry_countClient.Active := True;
  countClient := DM_fireDAC.fdqry_countClient.FieldValues['USERCOUNT'];


// ************************
//  while (not (DS.DataSet.Eof)) do
//  begin
//    countClient := countClient + 1;
//    DS.DataSet.Next;
//  end;

   // восстанавливаем DataSource
//  dbgrd_IDS.DataSource := DS;

//********* Глюк прокрутки
  dbgrd_IDS.DataSource.DataSet.Next;
  dbgrd_IDS.DataSource.DataSet.First;
//****************************************
  lblCountClient.Caption := '';
  lblCountClient.Caption := 'Число активных клиентов - ' + IntToStr(countClient);
end;

procedure TFdb.FormCreate(Sender: TObject);
begin
  chk_bdClick(nil);
end;
end.

