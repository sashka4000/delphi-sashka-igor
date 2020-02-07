unit FormLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIRegClasses,
  uniGUIForm, uniButton, uniEdit, uniGUIBaseClasses, uniLabel, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.SQLiteVDataSet, uniBasicGrid, uniDBGrid;

type
  TLoginForm = class(TUniLoginForm)
    lb_Welcome: TUniLabel;
    undtLogin: TUniEdit;
    undtPassword: TUniEdit;
    btnCancel: TUniButton;
    btnOk: TUniButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniLoginFormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function LoginForm: TLoginForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, FUser, FAdmin;

function LoginForm: TLoginForm;
begin
  Result := TLoginForm(UniMainModule.GetFormInstance(TLoginForm));
end;

procedure TLoginForm.btnOkClick(Sender: TObject);
begin
  UniMainModule.fdqryUsers.Close;
  UniMainModule.fdqryUsers.SQL.Clear;
  UniMainModule.fdqryUsers.SQL.Add('select id, login, password, superuser, blocked   from users where Login=:login and Password=:password');
  UniMainModule.fdqryUsers.ParamByName('login').Value := undtLogin.Text;
  UniMainModule.fdqryUsers.ParamByName('password').Value := undtPassword.Text;
  UniMainModule.fdqryUsers.Open;
  if UniMainModule.fdqryUsers.RecordCount = 0 then
  begin
    undtLogin.Clear;
    undtPassword.Clear;
    ShowMessage('Неправильный Логин или Пароль!');
  end
  else
  begin
    UniMainModule.UserID := UniMainModule.fdqryUsers.Fields[0].Value;
    UniMainModule.SuperUser := UniMainModule.fdqryUsers.Fields[3].Value;
    UniMainModule.Blocked := UniMainModule.fdqryUsers.Fields[4].Value;

//************* Проверека статуса ввода логин-пароля ***********************************************
    if UniMainModule.SuperUser = 1 then
    begin
  // Показать форму admin
      undtLogin.Clear;
      undtPassword.Clear;
      LoginForm.Hide;
      frmAdmin.show(nil);
    end
    else
    begin
  // Показать форму пользавателя
      undtLogin.Clear;
      undtPassword.Clear;
      LoginForm.Hide;
      frmUser.show(nil);
    end;
//**************************************************************************************************


  end;
end;

procedure TLoginForm.UniLoginFormShow(Sender: TObject);
begin
  ActiveControl := undtLogin;
end;

procedure TLoginForm.btnCancelClick(Sender: TObject);
var
  i: Integer;
begin
// Нет реализиции
end;

initialization
  RegisterAppFormClass(TLoginForm);

end.

