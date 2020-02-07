unit FRegistration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIForm, uniEdit,
  uniGUIBaseClasses, uniLabel, uniButton, FireDAC.Stan.Intf, uniBasicGrid,
  uniDBGrid, uniCheckBox, uniPanel, uniDBNavigator, FireDAC.Stan.Param,
  FireDAC.Phys.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmRegistration = class(TUniForm)
    undbgrd1: TUniDBGrid;
    lbNameTab: TUniLabel;
    btnExit: TUniButton;
    undbnvgtrTb1: TUniDBNavigator;
    dsUsers: TDataSource;
    fdpdtsqlUsers: TFDUpdateSQL;
    fdqryUsers: TFDQuery;
    fdqryCheckLogin: TFDQuery;
    procedure btnExitClick(Sender: TObject);
    procedure fdqryUsersBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmRegistration: TfrmRegistration;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Main, FormLogin, FAdmin;

function frmRegistration: TfrmRegistration;
begin
  Result := TfrmRegistration(UniMainModule.GetFormInstance(TfrmRegistration));
end;

procedure TfrmRegistration.btnExitClick(Sender: TObject);
begin
  frmRegistration.Close;
  frmAdmin.Show(nil);
end;


procedure TfrmRegistration.fdqryUsersBeforePost(DataSet: TDataSet);
begin
//   if (DataSet.FieldByName('UserName').AsString = '') or (DataSet.FieldByName('login').AsString = '') or (DataSet.FieldByName('password').AsString = '') then
//  begin
//    raise UniErrorException.Create('Заполните все поля!');
//  end;
  fdqryCheckLogin.ParamByName('login').Value := DataSet.FieldByName('login').Value;
  fdqryCheckLogin.Open;
  if fdqryCheckLogin.RecordCount > 0 then
  begin
    fdqryCheckLogin.Close;
    raise UniErrorException.Create('Такой логин уже существует!');
  end else
   fdqryCheckLogin.Close;
end;

end.

