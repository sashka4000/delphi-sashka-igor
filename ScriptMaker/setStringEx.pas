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
    procedure edtMinKeyPress(Sender: TObject; var Key: Char);
    procedure edtMaxKeyPress(Sender: TObject; var Key: Char);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStringEx: TfrmStringEx;

implementation

{$R *.dfm}

procedure TfrmStringEx.btnSaveClick(Sender: TObject);
var
  i : integer;
begin
  inherited;

//************* Проверка Min & Max *******************************************************
  if FS.ObjType = parser.otStringEx then
    begin
      if StrToInt(frmStringEx.edtMin.Text) >= StrToInt(frmStringEx.edtMax.Text)   then
         begin
           frmStringEx.edtMax.Clear;
           ShowMessage('Min не может быть больше или равен Max' + #10+ 'Введите пожалуста корректное значение');
           frmStringEx.edtMax.SetFocus;
         end;
    end;

//****************************************************************************************

  FS.Arguments[1] := edtMin.Text;
  FS.Arguments[2] := edtMax.Text;
end;

procedure TfrmStringEx.edtMaxKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
case Key of
    '0'..'9',#8:;
    #32 : key:=#0;
    #13: begin
           if StrToInt(edtMin.Text) >= StrToInt(edtMax.Text) then
             begin
               edtMax.Clear;
               ShowMessage('Min не может быть больше или равен Max' + #10+ 'Введите пожалуста корректное значение');
               edtMax.SetFocus;
             end
           else btnCancel.SetFocus;
         end
    else
    Key := #0;
    end;
end;

procedure TfrmStringEx.edtMinKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
case Key of
    '0'..'9',#8:;
    #32 : key:=#0;
    #13: edtMax.SetFocus;
    else
    Key := #0;
    end;
end;

end.
