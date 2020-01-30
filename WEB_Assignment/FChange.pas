unit FChange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIForm,
  uniGUIBaseClasses, uniEdit, uniButton;

type
  TfrmChange = class(TUniForm)
    undtOldPass: TUniEdit;
    undtNewPass: TUniEdit;
    undtRepPas: TUniEdit;
    btnCancel: TUniButton;
    btnOk: TUniButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmChange: TfrmChange;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, FormLogin, FireDAC.Stan.Intf;

function frmChange: TfrmChange;
begin
  Result := TfrmChange(UniMainModule.GetFormInstance(TfrmChange));
end;

procedure TfrmChange.btnCancelClick(Sender: TObject);
begin
  frmChange.Close;
  LoginForm.Show(nil);
end;

procedure TfrmChange.btnOkClick(Sender: TObject);
begin
  if (UniMainModule.UserPassword = undtOldPass.Text) and (undtNewPass.Text = undtRepPas.Text)
  and (UniMainModule.UserPassword <> undtNewPass.Text) then
  begin
    UniMainModule.fdqryfdq.Close;
    UniMainModule.fdqryfdq.SQL.Clear;
    UniMainModule.fdqryfdq.SQL.Add('update Tb1 set password = :p where id = :id');
    UniMainModule.fdqryfdq.ParamByName('p').Value := undtNewPass.Text;
    UniMainModule.fdqryfdq.ParamByName('id').Value := UniMainModule.UserID;
    UniMainModule.fdqryfdq.ExecSQL;
    UniMainModule.fdqryfdq.Close;
    UniMainModule.fdmtblOne.SaveToFile('text', sfJSON);
    frmChange.Close;
    LoginForm.Show(nil);
  end;

end;

end.

