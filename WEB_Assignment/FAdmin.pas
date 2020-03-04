unit FAdmin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIForm,
  uniGUIBaseClasses, uniButton;

type
  TfrmAdmin = class(TUniForm)
    btn1: TUniButton;
    btn2: TUniButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmAdmin: TfrmAdmin;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Main, FRegistration, FTripAdmin;

function frmAdmin: TfrmAdmin;
begin
  Result := TfrmAdmin(UniMainModule.GetFormInstance(TfrmAdmin));
end;

procedure TfrmAdmin.btn1Click(Sender: TObject);
begin
  frmAdmin.Close;
  frmRegistration.Show(nil);
end;

procedure TfrmAdmin.btn2Click(Sender: TObject);
begin
  frmAdmin.Close;
  frmTripAdmin.Show(nil);
end;

end.

