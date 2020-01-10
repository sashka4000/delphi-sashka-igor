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
//    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.IOUtils, System.Types;

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  Report: TfrxReport;
  Files: TStringDynArray;
  i: Integer;
begin
//****************************************************************************************
  while (fdmtb1.RecordCount > 0) do
    fdmtb1.Delete;
  if TDirectory.Exists(ExtractFilePath(Application.ExeName) + 'shema\') then
  begin
    Files := TDirectory.GetFiles(ExtractFilePath(Application.ExeName) + 'shema\', '*.bmp');
    for i := 0 to Length(Files) - 1 do
    begin
      fdmtb1.Insert;
      fdmtb1.Fields[0].AsInteger := i;
      fdmtb1.fields[1].AsString := Files[i];
      (fdmtb1.FieldByName('IMAGE') as TBlobField).LoadFromFile(Files[i]);
      fdmtb1.Post;
    end;
  end
  else
  begin
    ShowMessage('Папка \Shema не найдена!');
    Exit;
  end;


//****************************************************************************************

  if fdmtb1.RecordCount = 0 then
  begin
    ShowMessage('Не найдено ни одной схемы в папке \Shema');
    Exit;
  end
  else
  begin
   // Это довольно типовое решение - когда надо выбрать
   // одного из потомков класса для дальнейшей работы
   // Оба нащих отчета занаследованы от TfrxReport
   // поэтому можно написать так ....  и работать дальше с объектом Report
    case rg2.ItemIndex of
      0:
        Report := frxrprtBig;        // Report - просто ссылка на большой отчет
      1:
        Report := frxrprtSmall;      // Report - просто ссылка на мелкий отчет
    end;

    if rg1.ItemIndex = 2 then
    begin
      Report.PrepareReport();
      frxpdfxprt1.FileName := 'allShemas.pdf';
      frxpdfxprt1.ShowDialog := true;
      Report.Export(frxpdfxprt1);
    end
    else if rg1.ItemIndex = 1 then
    begin
      Report.PrepareReport();
      frxrtfxprt1.FileName := 'allShemas.rtf';
      frxrtfxprt1.ShowDialog := true;
      Report.Export(frxrtfxprt1);
    end
    else
    begin
//      Report.PrepareReport();
      Report.ShowReport();
      Report.Print;
    end;
  end;

end;

end.

