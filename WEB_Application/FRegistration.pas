unit FRegistration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIForm, uniEdit,
  uniGUIBaseClasses, uniLabel, uniButton;

type
  TfrmRegistration = class(TUniForm)
    lbReg: TUniLabel;
    lbuser: TUniLabel;
    lblog: TUniLabel;
    lbPassword: TUniLabel;
    lbRepPass: TUniLabel;
    undtuser: TUniEdit;
    undtlog: TUniEdit;
    undtpass: TUniEdit;
    undtreppass: TUniEdit;
    btnOk: TUniButton;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmRegistration: TfrmRegistration;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Main;

function frmRegistration: TfrmRegistration;
begin
  Result := TfrmRegistration(UniMainModule.GetFormInstance(TfrmRegistration));
end;

procedure TfrmRegistration.btnOkClick(Sender: TObject);
begin
  MainForm.Show(nil);
end;

end.

