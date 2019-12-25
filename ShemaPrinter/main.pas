unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, frxClass,
  frxExportRTF, frxExportBaseDialog, frxExportPDF;

type
  TForm1 = class(TForm)
    rg1: TRadioGroup;
    rg2: TRadioGroup;
    btn1: TButton;
    frxrprt1: TfrxReport;
    frxpdfxprt1: TfrxPDFExport;
    frxrtfxprt1: TfrxRTFExport;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);

begin
  frxrprt1.PrepareReport();
  frxpdfxprt1.FileName := '1.pdf';
  frxpdfxprt1.ShowDialog := true;
  frxrprt1.Export(frxpdfxprt1);

end;

end.
