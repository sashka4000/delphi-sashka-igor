unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.DBCtrls,
 Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.StorageBin, Vcl.ExtDlgs, JPEG, PNGImage;

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
    dlgOpenSound: TOpenDialog;
    dlgOpenPicImage: TOpenPictureDialog;
    procedure FormCreate(Sender: TObject);
    procedure btnDoValuesClick(Sender: TObject);
    procedure btnDoTextClick(Sender: TObject);
  private
    { Private declarations }
    function GetImageFolder: string;
    function GetWavFolder: string;
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

procedure TfrmMain.btnDoTextClick(Sender: TObject);
var
  arr: array[0..3] of string;
  tmp: string;
  i, j: Integer;
begin
  arr[0] := 'S';
  arr[1] := 'N';
  arr[2] := 'A';
  arr[3] := 'C';
  if fdmtbl1.RecordCount > 0 then
  begin
    mmo1.Lines.Clear;                         //  очистка окна memo
    fdmtbl1.Open;
    fdmtbl1.First;
    for i := 0 to fdmtbl1.RecordCount - 1 do
    begin
      tmp := '';
      tmp := dbgrd1.Fields[0].AsString + '=' + dbgrd1.Fields[1].AsString;
      for j := 0 to 3 do
      begin
        if dbgrd1.Fields[j + 2].AsString <> '' then
          tmp := tmp + '; ' + arr[j] + ':' + dbgrd1.Fields[j + 2].AsString;
      end;
      mmo1.Lines.Add(tmp);
      fdmtbl1.Next;

    end;
    fdmtbl1.EmptyDataSet;
    fdmtbl1.Close;
  end
  else
  begin
    MessageBox(Handle, PChar('Пустая таблица'), PChar('Внимание'), MB_ICONINFORMATION + MB_OK);
    ;
  end;
end;

procedure TfrmMain.btnDoValuesClick(Sender: TObject);
var
  tmp, tmp1, tmp2: string;
  i, j: Integer;
  arr: array[0..3] of string;
begin
  arr[0] := 'S';
  arr[1] := 'N';
  arr[2] := 'A';
  arr[3] := 'C';
  tmp := '';
  fdmtbl1.Open;    // открытие БД
  for i := 0 to mmo1.Lines.Count - 1 do
  begin
  if Trim(mmo1.Lines.Strings[i]).Length =  0  then Continue
    else
     begin
    dbgrd1.DataSource.DataSet.Edit;
    tmp1 := mmo1.Lines.Strings[i];
    tmp := Trim(Fetch(tmp1, '='));
    dbgrd1.Fields[0].AsString := tmp;
    tmp := Trim(Fetch(tmp1, ';'));
    dbgrd1.Fields[1].AsString := tmp;
    for j := 0 to 3 do
    begin
      tmp2 := tmp1;
      tmp := Trim(Fetch(tmp2, ':'));
      if tmp = arr[j] then
      begin
        tmp := Fetch(tmp2, ';');
        tmp1 := tmp2;
        dbgrd1.Fields[j + 2].AsString := tmp;
      end;
    end;
    dbgrd1.DataSource.DataSet.Append;
  end;
  end;
   mmo1.Lines.Clear;
end;


procedure TfrmMain.DBGrid1EditButtonClick(Sender: TObject);
begin
// ShowMessage(DBGrd1.SelectedField.FieldName);

  if dbgrd1.SelectedField.FieldName = 'ImageFile' then
  begin
    dlgOpenPicImage.InitialDir := GetImageFolder;
    if dlgOpenPicImage.Execute then
    begin
        // ShowMessage(dlgOpenGrid.FileName);
      dbgrd1.DataSource.DataSet.Edit;
      dbgrd1.SelectedField.AsString := LowerCase(ExtractRelativePath(GetImageFolder, dlgOpenPicImage.Filename));
      dbgrd1.DataSource.DataSet.Post;
    end;
  end
  else if dbgrd1.SelectedField.FieldName = 'SoundFile' then
  begin
        dlgOpenSound.InitialDir := GetWavFolder;
   if dlgOpenSound.Execute then
  begin
    dbgrd1.DataSource.DataSet.Edit;
    dbgrd1.SelectedField.AsString := LowerCase(ExtractRelativePath(GetWavFolder, dlgOpenSound.Filename));
    dbgrd1.DataSource.DataSet.Post;
  end;
  end;

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
