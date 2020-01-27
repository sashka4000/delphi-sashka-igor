unit FRegistration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIForm, uniEdit,
  uniGUIBaseClasses, uniLabel, uniButton;

type
  TfrmRegistration = class(TUniForm)
    lbReg: TUniLabel;
    undt1: TUniEdit;
    UniEdit1: TUniEdit;
    undt2: TUniEdit;
    undt3: TUniEdit;
    btnReg: TUniButton;
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

