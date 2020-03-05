unit FAdminStat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uniChart,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniGUIBaseClasses, uniPanel;

type
  TfrmAdminStat = class(TUniForm)
    unchrt1: TUniChart;
    unchrt2: TUniChart;
    fdqry1: TFDQuery;
    unpsrs1: TUniPieSeries;
    ds1: TDataSource;
    intgrfldfdqry1COUNT: TIntegerField;
    lrgntfldfdqry1USER_ID: TLargeintField;
    strngfldfdqry1TT: TStringField;
    unhrzbrsrs1: TUniHorizBarSeries;
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmAdminStat: TfrmAdminStat;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function frmAdminStat: TfrmAdminStat;
begin
  Result := TfrmAdminStat(UniMainModule.GetFormInstance(TfrmAdminStat));
end;

procedure TfrmAdminStat.UniFormShow(Sender: TObject);
begin
  fdqry1.Active := true;
end;

end.
