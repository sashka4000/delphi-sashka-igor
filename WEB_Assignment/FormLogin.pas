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
    fdqryCheckLogin: TFDQuery;
    procedure btnOkClick(Sender: TObject);
    procedure UniLoginFormShow(Sender: TObject);
    procedure undtPasswordKeyPress(Sender: TObject; var Key: Char);

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
  fdqryCheckLogin.ParamByName('l').Value := undtLogin.Text;
  fdqryCheckLogin.ParamByName('p').Value := undtPassword.Text;
  fdqryCheckLogin.Open;
  if fdqryCheckLogin.RecordCount = 0 then
  begin
    fdqryCheckLogin.Close; // не забываем закрыть запрос
    ShowMessage('Неправильный Логин или Пароль!');
  end
  else
  begin
    if fdqryCheckLogin.FieldByName('BLOCKED').AsInteger = 1 then
    begin
      fdqryCheckLogin.Close; // не забываем закрыть запрос
      ShowMessage('Пользователь заблокирован. Обратитесь к Админу');
    end;

    UniMainModule.UserID := fdqryCheckLogin.FieldByName('ID').Value;
    UniMainModule.SuperUser := fdqryCheckLogin.FieldByName('SUPERUSER').Value;
    UniMainModule.UserPassword := undtPassword.Text;
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



procedure TLoginForm.undtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnOkClick(nil);
end;

procedure TLoginForm.UniLoginFormShow(Sender: TObject);
begin
  ActiveControl := undtLogin;
end;

initialization
  RegisterAppFormClass(TLoginForm);

end.

