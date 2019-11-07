unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

end.
