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
    btnSave: TUniButton;
    btnExit: TUniButton;
    undbnvgtrTb1: TUniDBNavigator;
    procedure btnSaveClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure undbnvgtrTb1BeforeAction(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmRegistration: TfrmRegistration;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Main, FormLogin, FChange, FAdmin;

function frmRegistration: TfrmRegistration;
begin
  Result := TfrmRegistration(UniMainModule.GetFormInstance(TfrmRegistration));
end;

procedure TfrmRegistration.btnExitClick(Sender: TObject);
begin
frmRegistration.Close;
frmAdmin.Show(nil);
end;

procedure TfrmRegistration.btnSaveClick(Sender: TObject);
begin
  UniMainModule.fdmtblOne.SaveToFile('text', sfJSON);
  btnSave.Enabled := False;
end;

procedure TfrmRegistration.undbnvgtrTb1BeforeAction(Sender: TObject; Button: TNavigateBtn);
begin
    UniMainModule.fdmtblOne.Insert;
    UniMainModule.fdmtblOne.Fields[1].AsString := '';
    UniMainModule.fdmtblOne.Fields[2].AsString := '';
    UniMainModule.fdmtblOne.Fields[3].AsString := '';
    UniMainModule.fdmtblOne.Fields[4].AsBoolean := False;
    UniMainModule.fdmtblOne.Fields[5].AsString := '';
    UniMainModule.fdmtblOne.Post;
  btnSave.Enabled := (Button in [TNavigateBtn.nbDelete, TNavigateBtn.nbPost]);
end;

end.

