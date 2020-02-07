unit FRegistration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIForm, uniEdit,
  uniGUIBaseClasses, uniLabel, uniButton, FireDAC.Stan.Intf, uniBasicGrid,
  uniDBGrid, uniCheckBox, uniPanel, uniDBNavigator;

type
  TfrmRegistration = class(TUniForm)
    undbgrd1: TUniDBGrid;
    lbNameTab: TUniLabel;
    btnExit: TUniButton;
    undbnvgtrTb1: TUniDBNavigator;
    procedure btnExitClick(Sender: TObject);
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


end.

