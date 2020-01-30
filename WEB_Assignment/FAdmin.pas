unit FAdmin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniButton;

type
  TfrmAdmin = class(TUniForm)
    btn1: TUniButton;
    btn2: TUniButton;
    btnChange: TUniButton;
    procedure btn1Click(Sender: TObject);
    procedure btnChangeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmAdmin: TfrmAdmin;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, FRegistration, FChange;

function frmAdmin: TfrmAdmin;
begin
  Result := TfrmAdmin(UniMainModule.GetFormInstance(TfrmAdmin));
end;

procedure TfrmAdmin.btn1Click(Sender: TObject);
begin
frmAdmin.Close;
frmRegistration.Show(nil);
end;

procedure TfrmAdmin.btnChangeClick(Sender: TObject);
begin
frmAdmin.Close;
frmChange.Show(nil);
end;

end.
