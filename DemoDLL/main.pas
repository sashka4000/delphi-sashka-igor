unit main;

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
    procedure btnXXClick(Sender: TObject);
    procedure btnBigSmallClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function fSQRT(i: Integer): Real; stdcall; external 'ProjectDll.dll';

function fCompare(i, j: Integer): Integer; stdcall; external 'ProjectDll.dll';

function fRevers(fChar: PWideChar): PWideChar; stdcall; external 'ProjectDll.dll';

procedure TForm1.btn1Click(Sender: TObject);
begin
  edtReverse.Text := fRevers(PWideChar(edtStrNormal.Text));
end;

procedure TForm1.btnBigSmallClick(Sender: TObject);
begin
  edt4.Text := IntToStr(fCompare(StrToInt(edtA.Text), StrToInt(edtB.Text)));
end;

procedure TForm1.btnXXClick(Sender: TObject);
begin
  edtXX.Text := FloatToStr(fSQRT(StrToInt(edtX.Text)));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  edtX.Text := '';
  edtA.Text := '';
  edtB.Text := '';
  edtStrNormal.Text := '';
end;

end.

