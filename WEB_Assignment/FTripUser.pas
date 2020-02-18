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
  FireDAC.Comp.Client, DateUtils;

type
  TfrmTripUser = class(TUniForm)
    fdpdtsqlTrip: TFDUpdateSQL;
    fdqryTrip: TFDQuery;
    dsTrip: TDataSource;
    undbgrdTrip: TUniDBGrid;
    undbnvgtrTrip: TUniDBNavigator;
    lbTripTab: TUniLabel;
    undtmpckrBegin: TUniDateTimePicker;
    undtmpckrEnd: TUniDateTimePicker;
    btnRefresh: TUniButton;
    procedure UniFormShow(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
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

