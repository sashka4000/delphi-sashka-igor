unit FChange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIForm,
  uniGUIBaseClasses, uniEdit, uniButton, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmChange = class(TUniForm)
    undtOldPass: TUniEdit;
    undtNewPass: TUniEdit;
    undtRepPas: TUniEdit;
    btnCancel: TUniButton;
    btnOk: TUniButton;
    fdqryChange: TFDQuery;
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
  MainModule, uniGUIApplication, FormLogin;

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
  if (UniMainModule.UserPassword = undtOldPass.Text) and (undtNewPass.Text = undtRepPas.Text) and (UniMainModule.UserPassword <> undtNewPass.Text) then
  begin


      fdqryChange.ParamByName('p').Value := undtNewPass.Text;
      fdqryChange.ParamByName('id').Value := UniMainModule.UserID;
      fdqryChange.ExecSQL;
      frmChange.Close;
      LoginForm.Show(nil);


  end
  else
  begin
    ShowMessage(('Вы не поменяли пароль!!'));
    undtNewPass.Clear;
    undtRepPas.Clear;
  end;
end;

end.

