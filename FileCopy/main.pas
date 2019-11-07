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

procedure TfrmMain.btnSelectDestFolderClick(Sender: TObject);
var
  outDirectory : string ;
begin
 if SelectDirectory('Выберите папку назначения', '', outDirectory) then
   begin
     edtDestFolder.Text := outDirectory;

   end;
end;

procedure TfrmMain.btnSelectFileClick(Sender: TObject);
var
  inFile : string ;
begin
 if dlgOpen1.Execute then
   begin
     dlgOpen1.FilterIndex := 1;
     edtFlieName.Text  := dlgOpen1.FileName;

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
