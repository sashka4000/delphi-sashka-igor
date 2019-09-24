unit setString;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, setForm, Vcl.StdCtrls;

type
  TfrmString = class(TfrmSetSimple)
    edt2: TEdit;
    lbl3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmString: TfrmString;

implementation

{$R *.dfm}

end.
