unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, frxClass, frxExportRTF, frxExportBaseDialog,
  frxExportPDF, frxDBSet, frxOLE, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    rg1: TRadioGroup;
    rg2: TRadioGroup;
    btn1: TButton;
    frxrprtSmall: TfrxReport;
    frxpdfxprt1: TfrxPDFExport;
    frxrtfxprt1: TfrxRTFExport;
    fdmtb1: TFDMemTable;
    frxDBDataset1: TfrxDBDataset;
    intgrfldfdmtb1ID: TIntegerField;
    strngfldfdmtb1Name: TStringField;
    blbfldfdmtb1Image: TBlobField;
    frxrprtBig: TfrxReport;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
implementation
Uses System.IOUtils, System.Types;

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  Report : TfrxReport;
begin
   // ��� �������� ������� ������� - ����� ���� �������
   // ������ �� �������� ������ ��� ���������� ������
   // ��� ����� ������ ������������� �� TfrxReport
   // ������� ����� �������� ��� ....  � �������� ������ � �������� Report
   case rg2.ItemIndex of
     0 : Report := frxrprtBig;        // Report - ������ ������ �� ������� �����
     1 : Report := frxrprtSmall;      // Report - ������ ������ �� ������ �����
   end;

  if rg1.ItemIndex = 2 then
  begin
//    Report.ShowReport();
    frxpdfxprt1.FileName := 'allShemas.pdf';
    frxpdfxprt1.ShowDialog := true;
    Report.Export(frxpdfxprt1);
  end
  else if rg1.ItemIndex = 1 then
  begin
//   Report.ShowReport();
    frxrtfxprt1.FileName := 'allShemas.rtf';
    frxrtfxprt1.ShowDialog := true;
    Report.Export(frxrtfxprt1);
  end
  else
  begin
    Report.ShowReport();
    Report.Print;
  end;

end;


procedure TForm1.FormCreate(Sender: TObject);
var
//  sFileRec: TSearchRec;
//  fPath: string;
//  stFileList: TStringList;
  Files : TStringDynArray;
  i: Integer;
//  fMask : Integer;
begin
 { stFileList := TStringList.Create;

  fPath := ExtractFilePath(Application.ExeName) + 'shema\';
  fMask := FindFirst(fPath + '*.bmp',faAnyFile, sFileRec);
    if fMask = 0 then
      begin
        stFileList.Clear;
        stFileList.add('shema\' + sFileRec.Name);
        while 0 = FindNext(sFileRec) do
          stFileList.add('shema\' + sFileRec.Name);
      end;
   FindClose(sFileRec); }

  // ������ ��� ����������� ��� ����� ��� ����������
  //  ������ �������� ��
  //   var
  //   Files : TStringDynArray;
  //   ...
  Files :=  TDirectory.GetFiles( ExtractFilePath(Application.ExeName) + 'shema\','*.bmp');


 {  for i := 0 to stFileList.Count-1 do
  begin
    fdmtb1.Insert;
    fdmtb1.Fields[0].AsInteger := i;
    fdmtb1.fields[1].AsString := stFileList.Strings[i];
    (fdmtb1.FieldByName('IMAGE') as TBlobField).LoadFromFile(stFileList.Strings[i]);
    fdmtb1.Post;
  end;
  stFileList.Free;}
  for I := 0 to Length(Files) - 1 do
    begin
    fdmtb1.Insert;
    fdmtb1.Fields[0].AsInteger := i;
    fdmtb1.fields[1].AsString := Files[i];
    (fdmtb1.FieldByName('IMAGE') as TBlobField).LoadFromFile(Files[i]);
    fdmtb1.Post;
    end;

end;
end.

