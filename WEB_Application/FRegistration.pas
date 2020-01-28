unit FRegistration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIForm, uniEdit,
  uniGUIBaseClasses, uniLabel, uniButton, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, frxClass, frxDBSet, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Win.ADODB, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Phys.SQLiteVDataSet, FireDAC.DApt, FireDAC.Stan.StorageJSON;

type
  TfrmRegistration = class(TUniForm)
    lbReg: TUniLabel;
    undtUserName: TUniEdit;
    undtLog: TUniEdit;
    undtPassword: TUniEdit;
    undtRepPass: TUniEdit;
    btnReg: TUniButton;
    btnReset: TUniButton;
    procedure btnRegClick(Sender: TObject);
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


procedure TfrmRegistration.btnRegClick(Sender: TObject);
begin
  if (undtUserName.Text <> '') and (undtLog.Text <> '') and (undtPassword.Text <> '') and (undtPassword.Text = undtRepPass.Text) then
//*************** Проверка на наличие логина *******************************************************
  begin
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
      uniMainModule.fdmtblOne.Insert;
      uniMainModule.fdmtblOne.Fields[1].AsString := undtUserName.Text;
      uniMainModule.fdmtblOne.Fields[2].AsString := undtLog.Text;
      uniMainModule.fdmtblOne.Fields[3].AsString := undtPassword.Text;
      uniMainModule.fdmtblOne.Post;
      UniMainModule.fdmtblOne.SaveToFile('text', sfJSON);
      ShowMessage('Вы зарегистрировались');
      frmRegistration.Close;
      FormLogin.LoginForm.Show(nil);
    end
  end
  else
  begin
    ShowMessage('Пожалуйста, заполните все поля!');
  end;
end;

procedure TfrmRegistration.btnResetClick(Sender: TObject);
begin
  frmRegistration.Close;
  FormLogin.LoginForm.Show(nil);
end;

end.

