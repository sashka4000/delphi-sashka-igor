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
    procedure btnCancelClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
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

procedure TfrmRegistration.undtUserNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    if undtUserName.Text <> '' then
    begin
      undtLog.Enabled := true;
      undtLog.Clear;
      undtLog.SetFocus;
      undtUserName.Enabled := False;
    end
    else
    begin
      ShowMessage('������� ���������� ���� ���');
      undtLog.Enabled := False;
    end;
end;



procedure TfrmRegistration.undtLogKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if (undtUserName.Text <> '') and (undtLog.Text <> '') then
    begin
//************* ���� �������� ������ *****************************************************
      UniMainModule.fdqryfdq.Close;
      UniMainModule.fdqryfdq.SQL.Clear;
      UniMainModule.fdqryfdq.SQL.Add('select id, username from Tb1 where Login=:login');
      UniMainModule.fdqryfdq.ParamByName('login').Value := undtLog.Text;
      UniMainModule.fdqryfdq.Open;
      if UniMainModule.fdqryfdq.RecordCount > 0 then
      begin
        ShowMessage('������ ����� �����!' + #10 + '������� ������ �����!');
        undtLog.Clear;
        undtLog.SetFocus;
      end
      else
      begin
//****************************************************************************************
        undtLog.Enabled :=False;
        undtPassword.Enabled := True;
        undtPassword.SetFocus;
        undtRepPass.Enabled := True;
      end;
    end
    else
      ShowMessage('��������� ����������� ����!!!');
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
      ShowMessage('������� ������!!!');
  end;
end;

procedure TfrmRegistration.undtRepPassKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if (undtPassword.Text <> '') then
    begin
      if undtPassword.Text = undtRepPass.Text then
      begin
       btnReg.Visible :=True;
      end
      else
        ShowMessage('���������� ������!!!');
    end
    else
      ShowMessage('������� ������!!!');
  end;
end;



procedure TfrmRegistration.btnRegClick(Sender: TObject);
begin
if (undtUserName.Text <> '') and (undtLog.Text <> '') and (undtPassword.Text <> '')
    and (undtPassword.Text = undtRepPass.Text) then

uniMainModule.fdmtblOne.Insert;
uniMainModule.fdmtblOne.Fields[1].AsString := undtUserName.Text;
uniMainModule.fdmtblOne.Fields[2].AsString := undtLog.Text;
uniMainModule.fdmtblOne.Fields[3].AsString := undtPassword.Text;
uniMainModule.fdmtblOne.Post;
  ShowMessage('�� ������������������');
  frmRegistration.Hide;
  FormLogin.LoginForm.Show(nil);
end;


procedure TfrmRegistration.btnCancelClick(Sender: TObject);
begin
   undtUserName.Clear;
   undtLog.Clear;
   undtPassword.Clear;
   undtRepPass.Clear;
   undtPassword.Enabled := False;
   undtRepPass.Enabled := False;
   undtUserName.Enabled := True;
   undtUserName.SetFocus;
end;

procedure TfrmRegistration.btnResetClick(Sender: TObject);
begin
 frmRegistration.Close;
  FormLogin.LoginForm.Show(nil);
end;
end.

