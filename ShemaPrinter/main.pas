unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, frxClass, frxExportRTF, frxExportBaseDialog,
  frxExportPDF, frxDBSet, frxOLE, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
    rg1: TRadioGroup;
    rg2: TRadioGroup;
    btn1: TButton;
    frxrprt1: TfrxReport;
    frxpdfxprt1: TfrxPDFExport;
    frxrtfxprt1: TfrxRTFExport;
    fdmtb1: TFDMemTable;
    frxDBDataset1: TfrxDBDataset;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  fPath: string;
  sFileRec: TSearchRec;
  stFileList: TStringList;
implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  i : Integer;
begin
  frxrprt1.LoadFromFile(ExtractFilePath(Application.ExeName) + 'ReportBig.fr3');
  if rg2.ItemIndex = 1 then
  begin
  frxrprt1.LoadFromFile(ExtractFilePath(Application.ExeName) + 'ReportSmall.fr3');
  end;
//**************************************************************************************************
  for i := 1 to stFileList.Count do
  begin
    fdmtb1.Insert;
    fdmtb1.Fields[0].AsInteger := i;
    fdmtb1.fields[1].AsString := stFileList.Strings[i - 1];
    (fdmtb1.FieldByName('IMAGE') as TBlobField).LoadFromFile(stFileList.Strings[i - 1]);
    fdmtb1.Post;
  end;
//   self.frxrprt1.PrepareReport();
stFileList.Free;
//**************************************************************************************************
  if rg1.ItemIndex = 2 then
  begin
    frxrprt1.ShowReport();
    frxpdfxprt1.FileName := 'allShemas.pdf';
    frxpdfxprt1.ShowDialog := true;
    frxrprt1.Export(frxpdfxprt1);
  end
  else if rg1.ItemIndex = 1 then
  begin
    frxrprt1.ShowReport();
    frxrtfxprt1.FileName := 'allShemas.rtf';
    frxrtfxprt1.ShowDialog := true;
    frxrprt1.Export(frxrtfxprt1);
  end
  else
  begin
    frxrprt1.ShowReport();
    frxrprt1.Print;
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
var
//  stFileList: TStringList;
  i, fMask: Integer;
begin
  stFileList := TStringList.Create;
  fPath := ExtractFilePath(Application.ExeName) + 'shema\';
    fMask := FindFirst(fPath + '*.bmp',faAnyFile, sFileRec);
    if fMask = 0 then
      begin
        stFileList.Clear;
        stFileList.add('shema\' + sFileRec.Name);
        while 0 = FindNext(sFileRec) do
          stFileList.add('shema\' + sFileRec.Name);
      end;
 {

//**************************************************************************************************
  for i := 1 to stFileList.Count do
  begin
    fdmtb1.Insert;
    fdmtb1.Fields[0].AsInteger := i;
    fdmtb1.fields[1].AsString := stFileList.Strings[i - 1];
    (fdmtb1.FieldByName('IMAGE') as TBlobField).LoadFromFile(stFileList.Strings[i - 1]);
    fdmtb1.Post;
  end;
stFileList.Free; }
end;
end.

