unit setComboEx;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, setForm, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, parser;

type
  TfrmComboEx = class(TfrmSetSimple)
    lbl4: TLabel;
    mmoValues: TMemo;
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Init (S : TSimpleObject; OnCheckName  : TOnCheckName; OnOk, OnCancel : TNotifyEvent); override;
  end;

var
  frmComboEx: TfrmComboEx;

implementation

{$R *.dfm}

{ TfrmComboEx }

procedure TfrmComboEx.btnSaveClick(Sender: TObject);
var
 I  : Integer;
 sl : TStringList;
 sA : TStringArray;
begin
  inherited;
  // проверяем что человек ввел корректные число значение
  sl := TStringList.Create;
  sl.Sorted := true;
  i := 0;
  while i < mmoValues.lines.count do
  begin
     if Trim (mmoValues.Lines[i]) = '' then
     begin
        mmoValues.Lines.Delete(i);
        Continue;
     end;
     if mmoValues.Lines.Names[i] = '' then
     begin
      Application.MessageBox(PChar('Не указан Параметров в строке: ' + mmoValues.Lines[i]),
      PChar(Application.Title), MB_OK + MB_ICONSTOP);
      Exit;
     end;
     if sl.IndexOf(mmoValues.Lines.Names[i]) >= 0 then
     begin
      Application.MessageBox('Обнаружено дублирование Параметров',
      PChar(Application.Title), MB_OK + MB_ICONSTOP);
      Exit;
     end else
       sl.Add(mmoValues.Lines.Names[i]);
     inc (i);
  end;
  sl.Free;
  if mmoValues.Lines.Count > 0 then
  begin
     SetLength(sA, mmoValues.Lines.Count);
     for i := 0 to mmoValues.Lines.Count-1 do
       sA [i] := mmoValues.Lines[i];
     FS.Arguments := sA;
  end;
end;

procedure TfrmComboEx.Init(S: TSimpleObject; OnCheckName: TOnCheckName; OnOk,
  OnCancel: TNotifyEvent);
var
 I : Integer;
begin
  inherited;
  mmoValues.Clear;
  for i := 1 to High(FS.Arguments) do
    mmoValues.Lines.Add(FS.Arguments[i]);
end;

end.
