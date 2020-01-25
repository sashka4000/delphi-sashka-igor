unit FormLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIRegClasses,
  uniGUIForm, uniButton, uniEdit, uniGUIBaseClasses, uniLabel, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.SQLiteVDataSet;

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
    procedure btnRegClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function LoginForm: TLoginForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, FGreeting, FRegistration;

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
  UniMainModule.fdqryfdq.Close;
  UniMainModule.fdqryfdq.SQL.Clear;
  UniMainModule.fdqryfdq.SQL.Add('select id from Tb1 where Login=:username and Password=:password');
  UniMainModule.fdqryfdq.ParamByName('username').Value := undtLogin.Text;
  UniMainModule.fdqryfdq.ParamByName('password').Value := undtPassword.Text;
  UniMainModule.fdqryfdq.Open;
  if UniMainModule.fdqryfdq.RecordCount = 0 then
    ShowMessage('Incorrect Username or Password!')
  else
  begin
    ModalResult := mrOk;
  end;
end;

procedure TLoginForm.btnRegClick(Sender: TObject);
begin
  LoginForm.Hide;
  FRegistration.frmRegistration.Show(nil);

end;

initialization
  RegisterAppFormClass(TLoginForm);

end.

