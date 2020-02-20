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
    fdqryUsers: TFDQuery;
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
    fdqryUsersID: TLargeintField;
    fdqryUsersNAME: TStringField;
    cbbUSER: TUniDBLookupComboBox;
    dsAdmin: TDataSource;
    fdqryAdmin: TFDQuery;
    lrgntfld1: TLargeintField;
    strngfld1: TStringField;
    dsUser: TDataSource;
    fdqryUser: TFDQuery;
    lrgntfld2: TLargeintField;
    strngfld2: TStringField;
    cbbAdmin: TUniDBLookupComboBox;
    procedure UniFormShow(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure undbgrdTripColumnFilter(Sender: TUniDBGrid; const Column: TUniDBGridColumn; const Value: Variant);
  private
    { Private declarations }
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
  uniGUIVars, MainModule, uniGUIApplication;

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

procedure TfrmTripAdmin.undbgrdTripColumnFilter(Sender: TUniDBGrid; const Column: TUniDBGridColumn; const Value: Variant);
var
  S: string;
  tmp: string;
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
  FilterTT := '';
  FilterUSERNAME := '';
  FilterADMINNAME := '';
  fdqryTripAd.Filter := '';
  fdqryTripAd.Filtered := False;
  undtmpckrBegin.DateTime := date - 14;
  undtmpckrEnd.DateTime := Date;
  btnRefreshClick(nil);
end;

initialization
  RegisterAppFormClass(TfrmTripAdmin);

end.

