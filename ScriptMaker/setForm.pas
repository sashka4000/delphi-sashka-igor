unit setForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmSetSimple = class(TForm)
    lbl1: TLabel;
    edt1: TEdit;
    lbl2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DoSave; virtual;
  end;

var
  frmSetSimple: TfrmSetSimple;

implementation

{$R *.dfm}

{ TForm2 }

procedure TfrmSetSimple.DoSave;
begin
 ;
end;

end.
