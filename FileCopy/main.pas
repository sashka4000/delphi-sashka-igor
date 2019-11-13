unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.FileCtrl, Vcl.StdCtrls,
   System.Contnrs, System.types, System.IOUtils, IdGlobal;

type
  TfrmMain = class(TForm)
    lbl1: TLabel;
    edtFlieName: TEdit;
    btnSelectFile: TButton;
    dlgOpen1: TOpenDialog;
    lbl2: TLabel;
    edtSourceFolder: TEdit;
    btnSelectSourceFolder: TButton;
    lbl3: TLabel;
    edtDestFolder: TEdit;
    btnSelectDestFolder: TButton;
    btnDoWork: TButton;
    lbl4: TLabel;
    mmo1: TMemo;
    procedure btnSelectFileClick(Sender: TObject);
    procedure btnSelectSourceFolderClick(Sender: TObject);
    procedure btnSelectDestFolderClick(Sender: TObject);
    procedure btnDoWorkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
      soursePath, destPath : string; // Пути к источнику и приёмнику файлов
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

//**************************** Процедура выбора файла *****************************************
 procedure TfrmMain.btnSelectFileClick(Sender: TObject);
begin
 if dlgOpen1.Execute then
   begin
     dlgOpen1.FilterIndex := 1;
     edtFlieName.Text  := dlgOpen1.FileName;
     btnDoWork.Enabled := True;
   end;
end;
//*********************************************************************************************

procedure TfrmMain.btnSelectDestFolderClick(Sender: TObject);
begin
 if SelectDirectory('Выберите папку назначения', '', destPath) then
   begin
     edtDestFolder.Text := destPath;
   end;
end;


procedure TfrmMain.btnSelectSourceFolderClick(Sender: TObject);
begin
 if SelectDirectory('Выберите папку источник', '', soursePath) then
   begin
     edtSourceFolder.Text := soursePath;
   end;
end;

//************************ Процедура перезаписи файлов ****************************************
procedure TfrmMain.btnDoWorkClick(Sender: TObject);
const
  IgnorList : array[0..1] of string = ('!_shared','hasp');
var
  PathSList : TStringList;
  i, j : Integer;
  PathTemp,Ftemp : string;
  PathSource, PathDest : string;
  fIndex : Integer;
  maskIgnor : Boolean;
begin
  mmo1.clear;
  PathSList := TStringList.Create;
  PathSList.LoadFromFile(edtFlieName.Text);
  if (destPath = '') or (soursePath = '') then
    ShowMessage('Введите все параметры')
  else
  begin
  for I := 0 to PathSList.Count -1 do
    begin
      Ftemp := Copy(PathSList.Strings[i],1,7);
      if Ftemp <> 'Source:' then
        Continue ;
      Ftemp := PathSList.Strings[i];
      Fetch(Ftemp,'Source: ');
      maskIgnor := False;
      for j := 0 to 1 do
        if  Copy(Ftemp,1,IgnorList[j].Length) = IgnorList[j] then
          maskIgnor := True;
        if  maskIgnor then Continue;
      PathSource := soursePath + '\' + Fetch(Ftemp,';');
      Fetch(Ftemp,'{app}');
      fIndex := PathSource.IndexOf('\*');
      if fIndex >= 0 then
        begin
          PathTemp := PathSource.Remove(fIndex +1);
          if TDirectory.Exists(PathTemp) then
            begin
              PathDest := destPath + Fetch(Ftemp,';') + '\';
              TDirectory.Copy(PathTemp, PathDest);
              Continue;
            end;
        end;
      if FileExists(PathSource) then
        begin
          PathDest := destPath + Fetch(Ftemp,';') + '\' + ExtractFileName(PathSource);
          TDirectory.CreateDirectory(ExtractFilePath (PathDest));
          CopyFile(PWideChar(PathSource), PWideChar(PathDest), False);
          end
        else
          mmo1.Lines.Add(PathSource);
    end;
  PathSList.Free;
   end;

end;

//*********************************************************************************************
end.
