unit setStringEx;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, setForm, Vcl.StdCtrls, parser,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmStringEx = class(TfrmSetSimple)
    edtMin: TEdit;
    lbl4: TLabel;
    edtMax: TEdit;
    lbl5: TLabel;
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Init (S : TSimpleObject; OnCheckName  : TOnCheckName; OnOk, OnCancel : TNotifyEvent); override;
  end;

var
  frmStringEx: TfrmStringEx;

implementation

{$R *.dfm}

procedure TfrmStringEx.btnSaveClick(Sender: TObject);
var
  i : integer;
  eMin, eMax : Integer;
begin
  inherited;
  // Проверка на валидность
  eMin := StrToIntDef (edtMin.Text, 0);
  edtMin.Text := IntToStr(eMin);

  eMax := StrToIntDef (edtMax.Text, 100);
  edtMax.Text := IntToStr(eMax);

  if eMin  >= eMax   then
  begin
     Application.MessageBox('Граничные значения указаны не верно. Min >= Max',
       PChar(Application.Title), MB_OK + MB_ICONSTOP);
        edtMax.Clear;
        edtMax.SetFocus;
     Exit;
  end;

  FS.Arguments[1] := edtMin.Text;
  FS.Arguments[2] := edtMax.Text;
end;

procedure TfrmStringEx.Init(S: TSimpleObject; OnCheckName: TOnCheckName; OnOk,
  OnCancel: TNotifyEvent);
begin
  inherited;
  edtMin.Text  :=  FS.Arguments[1];
  edtMax.Text  :=  FS.Arguments[2];
end;

end.
