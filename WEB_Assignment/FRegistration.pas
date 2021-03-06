unit FRegistration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIForm, uniEdit,
  uniGUIBaseClasses, uniLabel, uniButton, FireDAC.Stan.Intf, uniBasicGrid,
  uniDBGrid, uniCheckBox, uniPanel, uniDBNavigator, FireDAC.Stan.Param,
  FireDAC.Phys.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageBin, uniMultiItem, uniComboBox,
  uniDBComboBox, uniDBLookupComboBox;

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
    unhdnpnlSuperUser: TUniHiddenPanel;
    cbbStatus: TUniDBLookupComboBox;
    cbbBlock: TUniDBLookupComboBox;
    lrgntfldUsersID: TLargeintField;
    strngfldUsersNAME: TStringField;
    strngfldUsersLOGIN: TStringField;
    strngfldUsersPASSWORD: TStringField;
    smlntfldUsersSUPERUSER: TSmallintField;
    smlntfldUsersBLOCKED: TSmallintField;
    strngfldUsersStrStatus: TStringField;
    strngfldUsersStrBlock: TStringField;
    procedure btnExitClick(Sender: TObject);
    procedure fdqryUsersBeforePost(DataSet: TDataSet);
    procedure UniFormShow(Sender: TObject);
    procedure undbgrd1ColumnFilter(Sender: TUniDBGrid; const Column: TUniDBGridColumn;
      const Value: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
    FilterStrStatus : string;
    FilterStrBlock : string;
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
  if fdqryUsers.State in [dsInsert] then
  begin
    fdqryCheckLogin.ParamByName('login').Value := DataSet.FieldByName('login').Value;
    fdqryCheckLogin.Open;
    if fdqryCheckLogin.RecordCount > 0 then
    begin
      fdqryCheckLogin.Close;
      raise UniErrorException.Create('����� ����� ��� ����������!');
    end
    else
      fdqryCheckLogin.Close;
  end;
end;
procedure TfrmRegistration.undbgrd1ColumnFilter(Sender: TUniDBGrid; const Column: TUniDBGridColumn; const Value: Variant);
var
  S: string;
begin
S := Value;
  if Column.FieldName = 'StrStatus' then
  begin
    if S = '' then
      FilterStrStatus := ''
    else
    begin
      FilterStrStatus := '(SUPERUSER = ' + S + ')';
    end;
  end;

  if Column.FieldName = 'StrBlock' then
  begin
    if S = '' then
      FilterStrBlock := ''
    else
    begin
      FilterStrBlock := '(BLOCKED = ' + S + ')';
    end;
  end;

  fdqryUsers.Filter := '';
 if FilterStrStatus <> '' then
 fdqryUsers.Filter := FilterStrStatus;

 if FilterStrBlock <> '' then
   if fdqryUsers.Filter <> '' then
   fdqryUsers.Filter := fdqryUsers.Filter + ' AND ' + FilterStrBlock
   else
   fdqryUsers.Filter := FilterStrBlock;
 if (FilterStrStatus <> '') or (FilterStrBlock <> '') then
  fdqryUsers.Filtered := True;

end;

procedure TfrmRegistration.UniFormShow(Sender: TObject);
begin
  fdqryUsers.Active := True;

  FilterStrStatus := '';
  FilterStrBlock := '';
  fdqryUsers.Filter := '';
  fdqryUsers.Filtered := False;
end;

end.

