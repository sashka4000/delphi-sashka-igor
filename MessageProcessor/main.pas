unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.StorageBin;

type
  TfrmMain = class(TForm)
    pnl1: TPanel;
    spl1: TSplitter;
    pnl2: TPanel;
    mmo1: TMemo;
    dbgrd1: TDBGrid;
    dbnvgr1: TDBNavigator;
    btnDoText: TButton;
    btnDoValues: TButton;
    fdmtbl1: TFDMemTable;
    dsTb: TDataSource;
    fdmtbl1Value: TStringField;
    fdmtbl1ImageFile: TStringField;
    fdmtbl1SoundFile: TStringField;
    fdmtbl1AlertName: TStringField;
    fdmtbl1Alert: TStringField;
    fdmtbl1Commanf: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure btnDoValuesClick(Sender: TObject);
  private
    { Private declarations }
    function GetImageFolder: String;
    function GetWavFolder: String;
    procedure DBGrid1EditButtonClick(Sender: TObject);
  public
    { Public declarations }
  end;


var
  frmMain: TfrmMain;

implementation

{$R *.dfm}
  uses
  IdGlobal;


{ TfrmMain }



procedure TfrmMain.btnDoValuesClick(Sender: TObject);
var
  tmp, tmp1, tmp2: string;
  i, j: Integer;
begin
  tmp := '';
  for i := 0 to mmo1.Lines.Count - 1 do
  begin


    dbgrd1.DataSource.DataSet.Edit;
    tmp1 := mmo1.Lines.Strings[i];
    tmp := Fetch(tmp1, '=');
    dbgrd1.Fields[0].AsString := tmp;
    tmp := Fetch(tmp1, ';');
    dbgrd1.Fields[1].AsString := tmp;

    tmp2 :=tmp1;
    tmp := Fetch(tmp2, ':');
    if tmp = ' S' then
    begin
      tmp := Fetch(tmp2, ';');
      tmp1 :=tmp2;
      dbgrd1.Fields[2].AsString := tmp;
    end;

    tmp2 := tmp1;
    tmp := Fetch(tmp2, ':');
    if tmp = ' N' then
    begin
      tmp := Fetch(tmp2, ';');
      tmp1 :=tmp2;
      dbgrd1.Fields[3].AsString := tmp;
    end;

    tmp2 := tmp1;
    tmp := Fetch(tmp2, ':');
    if tmp = ' A' then
    begin
      tmp := Fetch(tmp2, ';');
      tmp1 :=tmp2;
      dbgrd1.Fields[4].AsString := tmp;
    end;

    tmp2 := tmp1;
    tmp := Fetch(tmp2, ':');
    if tmp = ' C' then
    begin
      tmp := Fetch(tmp2, ';');
      dbgrd1.Fields[5].AsString := tmp;

    end;
    dbgrd1.DataSource.DataSet.Append;
//    fdmtbl1.Append;
//    fdmtbl1.Fields[0].AsString := tmp;
//    fdmtbl1.Post;
  end;

end;

procedure TfrmMain.DBGrid1EditButtonClick(Sender: TObject);
begin
 ShowMessage(DBGrd1.SelectedField.FieldName);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin



  dbgrd1.OnEditButtonClick:= DBGrid1EditButtonClick;
end;

function TfrmMain.GetImageFolder: String;
begin
  Result := ExtractFilePath (Application.ExeName) +  'Images\';
  if not DirectoryExists(Result) then
   CreateDir(Result);
end;

function TfrmMain.GetWavFolder: String;
begin
  Result :=  ExtractFilePath (Application.ExeName) +  'Sounds\';
  if not DirectoryExists(Result) then
   CreateDir(Result);
end;

end.
