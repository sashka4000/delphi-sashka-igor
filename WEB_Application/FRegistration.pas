unit FRegistration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIForm, uniEdit,
  uniGUIBaseClasses, uniLabel, uniButton;

type
  TfrmRegistration = class(TUniForm)
    lbReg: TUniLabel;
    undtUserName: TUniEdit;
    undtLog: TUniEdit;
    undtPassword: TUniEdit;
    undtRepPass: TUniEdit;
    btnReg: TUniButton;
    btnCancel: TUniButton;
    btnReset: TUniButton;
    procedure undtUserNameKeyPress(Sender: TObject; var Key: Char);
    procedure undtLogKeyPress(Sender: TObject; var Key: Char);
    procedure undtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure undtRepPassKeyPress(Sender: TObject; var Key: Char);
    procedure btnRegClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmRegistration: TfrmRegistration;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Main, FormLogin;

function frmRegistration: TfrmRegistration;
begin
  Result := TfrmRegistration(UniMainModule.GetFormInstance(TfrmRegistration));
end;

procedure TfrmRegistration.btnRegClick(Sender: TObject);
begin
uniMainModule.fdmtblOne.Insert;
uniMainModule.fdmtblOne.Fields[1].AsString := UniMainModule.fDataArray[0];
uniMainModule.fdmtblOne.Fields[2].AsString := UniMainModule.fDataArray[1];
uniMainModule.fdmtblOne.Fields[3].AsString := UniMainModule.fDataArray[2];
uniMainModule.fdmtblOne.Post;
  ShowMessage('Вы зарегистрировались');
  frmRegistration.Hide;
  FormLogin.LoginForm.Show(nil);
end;

procedure TfrmRegistration.undtLogKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if (undtUserName.Text <> '') and (undtLog.Text <> '') then
    begin
//************* Блок проверки Логина *****************************************************
      UniMainModule.fdqryfdq.Close;
      UniMainModule.fdqryfdq.SQL.Clear;
      UniMainModule.fdqryfdq.SQL.Add('select id, username from Tb1 where Login=:login');
      UniMainModule.fdqryfdq.ParamByName('login').Value := undtLog.Text;
      UniMainModule.fdqryfdq.Open;
      if UniMainModule.fdqryfdq.RecordCount > 0 then
      begin
        ShowMessage('Данный логин занят!' + #10 + 'Введите другой логин!');
        undtLog.Clear;
        undtLog.SetFocus;
      end
      else
      begin
//****************************************************************************************
        UniMainModule.fDataArray[1] := undtLog.Text;
        undtPassword.Enabled := True;
        undtPassword.SetFocus;
        undtRepPass.Enabled := True;
      end;
    end
    else
      ShowMessage('Заполните необходимые поля!!!');
  end;
end;

procedure TfrmRegistration.undtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if (undtPassword.Text <> '') then
    begin
      undtRepPass.SetFocus;
    end
    else
      ShowMessage('Введите пароль!!!');
  end;
end;

procedure TfrmRegistration.undtRepPassKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if (undtPassword.Text <> '') and (undtRepPass.Text <> '') then
    begin
      if undtPassword.Text = undtRepPass.Text then
      begin
        UniMainModule.fDataArray[2] := undtPassword.Text;
        btnRegClick(nil);
      end
      else
        ShowMessage('Потвердите пароль!!!');
    end
    else
      ShowMessage('Введите пароль!!!');
  end;
end;

procedure TfrmRegistration.undtUserNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    if undtUserName.Text <> '' then
    begin
      undtLog.Enabled := true;
      undtLog.Clear;
      UniMainModule.fDataArray[0] := undtUserName.Text;
      undtLog.SetFocus;
      undtUserName.Enabled := False;
    end
    else
    begin
      ShowMessage('Введите пожалуйста ваше имя');
      undtLog.Enabled := False;
    end;
end;

end.

