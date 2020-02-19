unit FTripUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIRegClasses,
  uniGUIForm, uniGUIBaseClasses, uniLabel, uniBasicGrid, uniDBGrid,
  Vcl.Imaging.jpeg, uniImage, FireDAC.Stan.Intf, FireDAC.Stan.Param,
  FireDAC.Phys.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, uniButton,
  uniDateTimePicker, uniDBNavigator, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, DateUtils, FireDAC.Stan.StorageBin, uniMultiItem,
  uniComboBox, uniDBComboBox, uniDBLookupComboBox, uniPanel;

type
  TfrmTripUser = class(TUniForm)
    fdqryTrip: TFDQuery;
    dsTrip: TDataSource;
    undbgrdTrip: TUniDBGrid;
    undbnvgtrTrip: TUniDBNavigator;
    lbTripTab: TUniLabel;
    undtmpckrBegin: TUniDateTimePicker;
    undtmpckrEnd: TUniDateTimePicker;
    btnRefresh: TUniButton;
    unhdnpnl1: TUniHiddenPanel;
    undblkpcmbx1: TUniDBLookupComboBox;
    strngfldTripNAME: TStringField;
    dtfldTripTRIPDATE: TDateField;
    smlntfldTripTRIPTYPE: TSmallintField;
    strngfldTripCOMMENT: TStringField;
    strngfldTripTT: TStringField;
    procedure UniFormShow(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure undbgrdTripColumnFilter(Sender: TUniDBGrid;
      const Column: TUniDBGridColumn; const Value: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmTripUser: TfrmTripUser;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication;

function frmTripUser: TfrmTripUser;
begin
  Result := TfrmTripUser(UniMainModule.GetFormInstance(TfrmTripUser));
end;

procedure TfrmTripUser.btnRefreshClick(Sender: TObject);
begin
  fdqryTrip.Close();
  fdqryTrip.ParamByName('d1').Value := undtmpckrBegin.DateTime;
  fdqryTrip.ParamByName('d2').Value := undtmpckrEnd.DateTime;
  fdqryTrip.Open;
end;

procedure TfrmTripUser.undbgrdTripColumnFilter(Sender: TUniDBGrid;
  const Column: TUniDBGridColumn; const Value: Variant);
var
 S : String;
begin
 S := Value;
 if S = ''
 then
   fdqryTrip.Filtered := False
 else
 begin
   fdqryTrip.Filter := 'TRIPTYPE = ' + S;
   fdqryTrip.Filtered := True;
 end;
end;

procedure TfrmTripUser.UniFormShow(Sender: TObject);
begin
  fdqryTrip.ParamByName('id').Value := UniMainModule.UserID;
  undtmpckrBegin.DateTime := date - 14;
  undtmpckrEnd.DateTime := Date;
  btnRefreshClick(nil);
end;

initialization
  RegisterAppFormClass(TfrmTripUser);

end.

