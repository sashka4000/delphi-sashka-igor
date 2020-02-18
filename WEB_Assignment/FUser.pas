unit FUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIForm,
  uniGUIBaseClasses, uniButton;

type
  TfrmUser = class(TUniForm)
    btn1: TUniButton;
    btnChange: TUniButton;
    procedure btnChangeClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmUser: TfrmUser;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, FChange, FTripUser;

function frmUser: TfrmUser;
begin
  Result := TfrmUser(UniMainModule.GetFormInstance(TfrmUser));
end;

procedure TfrmUser.btn1Click(Sender: TObject);
begin
 frmTripUser.ShowModal(nil) ;
end;

procedure TfrmUser.btnChangeClick(Sender: TObject);
begin
  frmUser.Close;
  frmChange.Show(nil);
end;

end.

