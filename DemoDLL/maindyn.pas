unit maindyn;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnXX: TButton;
    edtX: TEdit;
    edtXX: TEdit;
    btnBigSmall: TButton;
    edtA: TEdit;
    edt4: TEdit;
    edtB: TEdit;
    btn1: TButton;
    edtStrNormal: TEdit;
    edtReverse: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnXXClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnBigSmallClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;


implementation

{$R *.dfm}
var
  H : THandle;
  fSQRT :    function (i: Integer): Real; stdcall;
  fCompare : function (i, j: Integer): Integer; stdcall;
  fRevers  : function (fChar: PWideChar): PWideChar; stdcall;
procedure TForm1.btn1Click(Sender: TObject);
begin
if H = 0 then
H := LoadLibrary('ProjectDll.dll');
if H <> 0 then
begin
 fRevers := GetProcAddress(H, 'fRevers');
  edtReverse.Text := fRevers(PWideChar(edtStrNormal.Text));
end
  else
    ShowMessage('Не удалось загрузить файл ProjectDll.dll');

end;

procedure TForm1.btnBigSmallClick(Sender: TObject);
begin
if H = 0 then
H := LoadLibrary('ProjectDll.dll');
if H <> 0 then
begin
 fCompare := GetProcAddress(H, 'fCompare');
  edt4.Text := IntToStr(fCompare(StrToInt(edtA.Text), StrToInt(edtB.Text)));
 end
  else
    ShowMessage('Не удалось загрузить файл ProjectDll.dll');
end;

procedure TForm1.btnXXClick(Sender: TObject);
begin
if H = 0 then
H := LoadLibrary('ProjectDll.dll');
if H <> 0 then
begin
 fSQRT := GetProcAddress(H, 'fSQRT');
 edtXX.Text := FloatToStr(fSQRT(StrToInt(edtX.Text)));
 end
  else
    ShowMessage('Не удалось загрузить файл ProjectDll.dll');
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 FreeLibrary(H)
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 edtX.Text := '';
 edtA.Text := '';
 edtB.Text := '';
 edtStrNormal.Text := '';
end;

end.

