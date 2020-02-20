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
    procedure UniFormShow(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure undbgrdTripColumnFilter(Sender: TUniDBGrid; const Column: TUniDBGridColumn; const Value: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
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
begin
  S := Value;
  if S = '' then
    fdqryTripAd.Filtered := False
  else
  begin
    fdqryTripAd.Filter := 'TRIPTYPE = ' + S;
    fdqryTripAd.Filtered := True;
  end;
end;

procedure TfrmTripAdmin.UniFormShow(Sender: TObject);
begin
  undtmpckrBegin.DateTime := date - 14;
  undtmpckrEnd.DateTime := Date;
  btnRefreshClick(nil);
end;

initialization
  RegisterAppFormClass(TfrmTripAdmin);

end.

