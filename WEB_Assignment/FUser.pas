unit FUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniButton;

type
  TfrmUser = class(TUniForm)
    btn1: TUniButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmUser: TfrmUser;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function frmUser: TfrmUser;
begin
  Result := TfrmUser(UniMainModule.GetFormInstance(TfrmUser));
end;

end.
