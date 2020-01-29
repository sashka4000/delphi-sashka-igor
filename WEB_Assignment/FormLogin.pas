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
  UniMainModule.fdqryfdq.Close;
  UniMainModule.fdqryfdq.SQL.Clear;
  UniMainModule.fdqryfdq.SQL.Add('select id, username, status from Tb1 where Login=:login and Password=:password');
  UniMainModule.fdqryfdq.ParamByName('login').Value := Trim(UpperCase(undtLogin.Text));
  UniMainModule.fdqryfdq.ParamByName('password').Value := undtPassword.Text;
  UniMainModule.fdqryfdq.Open;
  if UniMainModule.fdqryfdq.RecordCount = 0 then
    ShowMessage('Неправильный Логин или Пароль!')
  else
  begin
    UniMainModule.UserName := UniMainModule.fdqryfdq.Fields [1].Value;
    UniMainModule.UserID  := UniMainModule.fdqryfdq.Fields [0].Value;
    UniMainModule.UserStaus := UniMainModule.fdqryfdq.Fields[2].Value;
//************* Проверека статуса ввода логин-пароля ***********************************************
  if UniMainModule.UserStaus then
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

procedure TLoginForm.btnCancelClick(Sender: TObject);
var
i: Integer;
begin

end;

initialization
  RegisterAppFormClass(TLoginForm);

end.

