unit setString;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, setForm, Vcl.StdCtrls, parser;

type
  TfrmString = class(TfrmSetSimple)
    edt2: TEdit;
    lbl3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
     procedure Init (S : TSimpleObject); override;
  end;

var
  frmString: TfrmString;

implementation

{$R *.dfm}

procedure TfrmString.Init(S: TSimpleObject);
begin
  inherited;
  edt2.Text := FS.Arguments[0];
end;

end.
