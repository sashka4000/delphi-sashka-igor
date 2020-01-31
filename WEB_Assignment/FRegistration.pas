unit FRegistration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIForm, uniEdit,
  uniGUIBaseClasses, uniLabel, uniButton, FireDAC.Stan.Intf, uniBasicGrid,
  uniDBGrid, uniCheckBox, uniPanel;

type
  TfrmRegistration = class(TUniForm)
    undtUserName: TUniEdit;
    undtLog: TUniEdit;
    undtPassword: TUniEdit;
    undtRepPass: TUniEdit;
    btnReg: TUniButton;
    btnReset: TUniButton;
    undbgrd1: TUniDBGrid;
    btnChange: TUniButton;
    lbNameTab: TUniLabel;
    PanReg: TUniPanel;
    lbReg: TUniLabel;
    unchckbxStatus: TUniCheckBox;
    btnPanReg: TUniButton;
    btnRefresh: TUniButton;
    btnExit: TUniButton;
    procedure btnRegClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnChangeClick(Sender: TObject);
    procedure btnPanRegClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmRegistration: TfrmRegistration;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Main, FormLogin, FChange, FAdmin;

function frmRegistration: TfrmRegistration;
begin
  Result := TfrmRegistration(UniMainModule.GetFormInstance(TfrmRegistration));
end;

procedure TfrmRegistration.btnChangeClick(Sender: TObject);
begin
  frmRegistration.Close;
  FChange.frmChange.Show(nil);
end;

procedure TfrmRegistration.btnExitClick(Sender: TObject);
begin
frmRegistration.Close;
frmAdmin.Show(nil);
end;

procedure TfrmRegistration.btnPanRegClick(Sender: TObject);
begin
  btnPanReg.Visible := False;
  PanReg.Visible := True;
end;

procedure TfrmRegistration.btnRefreshClick(Sender: TObject);
begin
  undbgrd1.Refresh;
end;

procedure TfrmRegistration.btnRegClick(Sender: TObject);
begin
  if (undtUserName.Text <> '') and (undtLog.Text <> '') and (undtPassword.Text <> '') and (undtPassword.Text = undtRepPass.Text) then
//*************** Проверка на наличие логина *******************************************************
  begin
    UniMainModule.fdqryfdq.Close;
    UniMainModule.fdqryfdq.SQL.Clear;
    UniMainModule.fdqryfdq.SQL.Add('select id, status from Tb1 where Login=:login');
    UniMainModule.fdqryfdq.ParamByName('login').Value := Trim(UpperCase(undtLog.Text));
    UniMainModule.fdqryfdq.Open;

    if UniMainModule.fdqryfdq.RecordCount > 0 then
    begin
      ShowMessage('Данный логин занят!' + #10 + 'Введите другой логин!');
      undtLog.Clear;
      undtLog.SetFocus;
    end
    else
    begin
      uniMainModule.fdmtblOne.Insert;
      uniMainModule.fdmtblOne.Fields[1].AsString := undtUserName.Text;
      uniMainModule.fdmtblOne.Fields[2].AsString := Trim(UpperCase(undtLog.Text));
      uniMainModule.fdmtblOne.Fields[3].AsString := undtPassword.Text;
      uniMainModule.fdmtblOne.Fields[4].AsBoolean := unchckbxStatus.Checked;
      uniMainModule.fdmtblOne.Fields[5].AsString := '';
      uniMainModule.fdmtblOne.Post;
      UniMainModule.fdmtblOne.SaveToFile('text', sfJSON);
      ShowMessage('Вы зарегистрировались');
      undbgrd1.Refresh;
      btnPanReg.Visible := True;
      PanReg.Visible := False;
      undtUserName.Clear;
      undtLog.Clear;
      undtPassword.Clear;
      undtRepPass.Clear;
      unchckbxStatus.Checked := False;
    end
  end
  else
  begin
    ShowMessage('Пожалуйста, заполните все поля!');
  end;
end;

procedure TfrmRegistration.btnResetClick(Sender: TObject);
begin
   btnPanReg.Visible := True;
   PanReg.Visible := False;
end;

end.

