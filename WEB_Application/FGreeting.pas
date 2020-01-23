unit FGreeting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniGUIBaseClasses, uniLabel;

type
  TfrmGreeting = class(TUniForm)
    UniLbGreeting: TUniLabel;
    btnGreetingOk: TUniButton;
    procedure btnGreetingOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmGreeting: TfrmGreeting;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Main, FormLogin;

function frmGreeting: TfrmGreeting;
begin
  Result := TfrmGreeting(UniMainModule.GetFormInstance(TfrmGreeting));
end;

procedure TfrmGreeting.btnGreetingOkClick(Sender: TObject);
begin
 frmGreeting.Hide;
 MainForm.Show(nil);
end;

end.
