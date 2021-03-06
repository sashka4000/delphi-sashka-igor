unit FTripAdmin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIRegClasses,
  uniGUIForm, uniGUIBaseClasses, uniLabel, uniBasicGrid, uniDBGrid,
  Vcl.Imaging.jpeg, uniImage, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, FireDAC.Stan.Async, FireDAC.DApt,
  uniDBNavigator, FireDAC.Comp.Client, Data.DB, uniDateTimePicker, uniButton,
  FireDAC.Comp.DataSet, uniMultiItem, uniComboBox, uniDBComboBox,
  uniDBLookupComboBox, uniPanel;

type
  TfrmTripAdmin = class(TUniForm)
    undbgrdTrip: TUniDBGrid;
    lbTripTab: TUniLabel;
    btnRefresh: TUniButton;
    undtmpckrEnd: TUniDateTimePicker;
    undtmpckrBegin: TUniDateTimePicker;
    dsTripAd: TDataSource;
    fdqryTripAd: TFDQuery;
    fdpdtsqlAd: TFDUpdateSQL;
    undbnvgtrAd: TUniDBNavigator;
    lrgntfldTripAdID: TLargeintField;
    lrgntfldTripAdUSER_ID: TLargeintField;
    lrgntfldTripAdADMIN_ID: TLargeintField;
    dtfldTripAdTRIPDATE: TDateField;
    smlntfldTripAdTRIPTYPE: TSmallintField;
    strngfldTripAdCOMMENT: TStringField;
    strngfldTripAdUSERNAME: TStringField;
    strngfldTripAdADMINNAME: TStringField;
    strngfldTripAdTT: TStringField;
    unhdnpnlAd: TUniHiddenPanel;
    cbbAd: TUniDBLookupComboBox;
    cbbUSER: TUniDBLookupComboBox;
    dsAdmin: TDataSource;
    fdqryAdmin: TFDQuery;
    lrgntfld1: TLargeintField;
    strngfld1: TStringField;
    cbbAdmin: TUniDBLookupComboBox;
    btnRecord: TUniButton;
    btnBack: TUniButton;
    undtmpckrSelectDate: TUniDateTimePicker;
    procedure UniFormShow(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure undbgrdTripColumnFilter(Sender: TUniDBGrid; const Column: TUniDBGridColumn; const Value: Variant);
    procedure btnRecordClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
  private
    { Private declarations }
    procedure ShowCallBack(Sender: TComponent; AResult: Integer);
  public
    { Public declarations }
    FilterTT: string;
    FilterUSERNAME: string;
    FilterADMINNAME: string;
  end;

function frmTripAdmin: TfrmTripAdmin;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, FRecord, FAdmin;

function frmTripAdmin: TfrmTripAdmin;
begin
  Result := TfrmTripAdmin(UniMainModule.GetFormInstance(TfrmTripAdmin));
end;

procedure TfrmTripAdmin.btnRefreshClick(Sender: TObject);
begin
  fdqryTripAd.Close();
  fdqryTripAd.ParamByName('d1').Value := undtmpckrBegin.DateTime;
  fdqryTripAd.ParamByName('d2').Value := undtmpckrEnd.DateTime;
  fdqryTripAd.Open;
end;

procedure TfrmTripAdmin.ShowCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult = mrOk then
    btnRefreshClick(nil);
end;

procedure TfrmTripAdmin.undbgrdTripColumnFilter(Sender: TUniDBGrid; const Column: TUniDBGridColumn; const Value: Variant);
var
  S: string;
begin
  S := Value;

  if Column.FieldName = 'TT' then
  begin
    if S = '' then
      FilterTT := ''
    else
    begin
      FilterTT := '(TRIPTYPE = ' + S + ')';
    end;
  end;

  if Column.FieldName = 'USERNAME' then
  begin
    if S = '' then
      FilterUSERNAME := ''
    else
    begin
      FilterUSERNAME := '(USER_ID = ' + S + ')';
    end;
  end;

  //  ADMIN COLUMN
  if Column.FieldName = 'ADMINNAME' then
  begin
    if S = '' then
      FilterADMINNAME := ''
    else
    begin
      FilterADMINNAME := '(ADMIN_ID = ' + S + ')';
    end;
  end;
  fdqryTripAd.Filter := '';

  if FilterTT <> '' then
    fdqryTripAd.Filter := FilterTT;

  if FilterUSERNAME <> '' then
    if fdqryTripAd.Filter <> '' then
      fdqryTripAd.Filter := fdqryTripAd.Filter + ' AND ' + FilterUSERNAME
    else
      fdqryTripAd.Filter := FilterUSERNAME;

  //  ADMIN
  if FilterADMINNAME <> '' then
    if fdqryTripAd.Filter <> '' then
      fdqryTripAd.Filter := fdqryTripAd.Filter + ' AND ' + FilterADMINNAME
    else
      fdqryTripAd.Filter := FilterADMINNAME;

  if (FilterTT <> '') or (FilterUSERNAME <> '') or (FilterADMINNAME <> '') then
    fdqryTripAd.Filtered := True;
end;

procedure TfrmTripAdmin.UniFormShow(Sender: TObject);
begin
  fdqryAdmin.Active := True;
  FilterTT := '';
  FilterUSERNAME := '';
  FilterADMINNAME := '';
  fdqryTripAd.Filter := '';
  fdqryTripAd.Filtered := False;
  undtmpckrBegin.DateTime := date - 14;
  undtmpckrEnd.DateTime := Date;
  btnRefreshClick(nil);
end;

procedure TfrmTripAdmin.btnBackClick(Sender: TObject);
begin
  frmTripAdmin.Hide;
  frmAdmin.Show(nil);
end;

procedure TfrmTripAdmin.btnRecordClick(Sender: TObject);
begin
  frmRecord.ShowModal(ShowCallBack);
 // ����� ���������� ��������� ������� ����� ���� ���������
 // ��� �� ��� � VCL
end;

initialization
  RegisterAppFormClass(TfrmTripAdmin);

end.

