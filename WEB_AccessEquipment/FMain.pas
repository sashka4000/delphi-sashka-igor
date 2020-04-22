unit FMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniBasicGrid, uniDBGrid,
  uniDBNavigator, unimDBNavigator, Vcl.Menus, uniMainMenu;

type
  TfrmMain = class(TUniForm)
    undbgrdClient: TUniDBGrid;
    unmnmnMain: TUniMainMenu;
    unmntmOption: TUniMenuItem;
    unmntmMode: TUniMenuItem;
    unmntmHelp: TUniMenuItem;
    unmdbnvgtrClient: TUnimDBNavigator;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication;

function frmMain: TfrmMain;
begin
  Result := TfrmMain(UniMainModule.GetFormInstance(TfrmMain));
end;

initialization
  RegisterAppFormClass(TfrmMain);

end.
