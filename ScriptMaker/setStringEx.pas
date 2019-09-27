unit setStringEx;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, setForm, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmStringEx = class(TfrmSetSimple)
    edtMin: TEdit;
    lbl4: TLabel;
    edtMax: TEdit;
    lbl5: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStringEx: TfrmStringEx;

implementation

{$R *.dfm}

end.
