unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uniThreadTimer, Windows, Messages, Variants, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIRegClasses,
  uniGUIForm, uniGUIBaseClasses, uniBasicGrid, uniDBGrid, uniDBNavigator,
  unimDBNavigator, Vcl.Menus, uniMainMenu, uniChart, uniPanel, uniButton,
  uniMemo, FireDAC.Stan.StorageJSON, syncobjs, IdBaseComponent, IdComponent,
  IdRawBase, IdRawClient, IdIcmpClient, FireDAC.Stan.Async, FireDAC.DApt,
  DateUtils;

type
  TUniMainModule = class(TUniGUIMainModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function UniMainModule: TUniMainModule;

implementation

{$R *.dfm}

uses
  UniGUIVars, ServerModule, uniGUIApplication, FMain;

function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule)
end;



initialization
  RegisterMainModuleClass(TUniMainModule);

end.


