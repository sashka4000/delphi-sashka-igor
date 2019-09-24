unit setStringEx;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, setForm, Vcl.StdCtrls;

type
  TfrmStringEx = class(TfrmSetSimple)
    edt2: TEdit;
    lbl3: TLabel;
    edt3: TEdit;
    lbl4: TLabel;
    edt4: TEdit;
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
