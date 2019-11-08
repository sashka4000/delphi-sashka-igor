unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.FileCtrl;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

//**************************** Процедура выбора файла *****************************************
 procedure TfrmMain.btnSelectFileClick(Sender: TObject);
var
  oneSList, twoSList : TStringList;
  fString : string ;
  soursePath, destPath : string;
  i, j : Integer;
begin
 if dlgOpen1.Execute then
   begin
     dlgOpen1.FilterIndex := 1;
     edtFlieName.Text  := dlgOpen1.FileName;
     oneSList := TStringList.Create(True);
     oneSList.LoadFromFile(edtFlieName.Text);
     twoSList := TStringList.Create(True);
     i := oneSList.Count;
     j := 0;
     while i > 0 do
       begin
         if oneSList.Strings[j] = '[Files]' then
           while oneSList.Strings[j] <> '[Icons]' do
             begin
               twoSList.Add(oneSList.Strings[j]);
               Inc(j);
               Dec(i);
             end
         else
           begin
             Dec(i);
             Inc(j);
             Continue;
           end;
       end;
//     twoSList.SaveToFile('test.txt');
 oneSList.Clear;
     for I := 0 to twoSList.Count -1 do
         begin
           j := twoSList.Strings[i].IndexOf('Source:');
           if j = 0 then
             oneSList.add(twoSList[i]);
         end;
   twoSList.Clear;
     for i := 0 to oneSList.Count -1 do
       begin
       fString := oneSList[i];
       if not((fString.IndexOf('!_shared') > -1) or (fString.IndexOf('hasp') > -1)) then
         twoSList.add(oneSList.Strings[i]);
       end;
  oneSList.Clear;
  twoSList.SaveToFile('test.txt');



   end;
end;
//*********************************************************************************************

procedure TfrmMain.btnSelectDestFolderClick(Sender: TObject);
var
  outDirectory : string ;
begin
 if SelectDirectory('Выберите папку назначения', '', outDirectory) then
   begin
     edtDestFolder.Text := outDirectory;

   end;
end;


procedure TfrmMain.btnSelectSourceFolderClick(Sender: TObject);
var
  inDirectory : string ;
begin
 if SelectDirectory('Выберите папку источник', '', inDirectory) then
   begin
     edtSourceFolder.Text := inDirectory;

   end;
end;

end.
