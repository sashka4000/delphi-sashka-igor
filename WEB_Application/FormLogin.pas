unit FormLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIRegClasses,
  uniGUIForm, uniButton, uniEdit, uniGUIBaseClasses, uniLabel;

type
  TLoginForm = class(TUniLoginForm)
    lb_Welcome: TUniLabel;
    lb_Login: TUniLabel;
    lb_Password: TUniLabel;
    undtLogin: TUniEdit;
    undtPassword: TUniEdit;
    btnCancel: TUniButton;
    btnOk: TUniButton;
    btnReg: TUniButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function LoginForm: TLoginForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, FGreeting;

function LoginForm: TLoginForm;
begin
  Result := TLoginForm(UniMainModule.GetFormInstance(TLoginForm));
end;

procedure TLoginForm.btnCancelClick(Sender: TObject);
var
  i: Integer;
begin

end;

procedure TLoginForm.btnOkClick(Sender: TObject);
begin
  if (undtLogin.Text = '') and (undtPassword.Text = '') then
  begin

    LoginForm.Hide;
    FGreeting.frmGreeting.Show(nil);

  end
  else
    btnOk.ModalResult := mrCancel;
end;

initialization
  RegisterAppFormClass(TLoginForm);

end.

