unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, frxClass,
  frxExportRTF, frxExportBaseDialog, frxExportPDF, frxDBSet, frxOLE, jpeg, Data.DB,
  Data.Win.ADODB, Vcl.ExtDlgs;

type
  TForm1 = class(TForm)
    rg1: TRadioGroup;
    rg2: TRadioGroup;
    btn1: TButton;
    frxrprt1: TfrxReport;
    frxpdfxprt1: TfrxPDFExport;
    frxrtfxprt1: TfrxRTFExport;
    frxDBDataset1: TfrxDBDataset;
    ADOTable1: TADOTable;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  fPath : string;
implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  fOneList : Boolean;
begin
//frxrprt1.PrepareReport();
if rg2.ItemIndex = 1 then   fOneList := False;
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
  jpeg: TJPEGImage;
  bmp: TBitmap;
begin
  fPath := ExtractFilePath(Application.ExeName) + 'shema\';
 // frxrprt1.PrepareReport();
  if  OpenPictureDialog1.Execute then
      begin
        jpeg := TJPEGImage.Create;
        bmp := TBitmap.Create;
        try
          jpeg.LoadFromFile(OpenPictureDialog1.FileName);
          bmp.Assign(jpeg);
          ADOTable1.Edit;                  // режим редактирования
          ADOTable1.FieldByName('Foto').Assign(bmp);//загрузка фото
          ADOTable1.Post;                  // сохраняем данные
        finally
          jpeg.Free;
          bmp.Free;
        end;
      end;
end;

{
uses jpeg;

    procedure TForm1.Button1Click(Sender: TObject);
    var
      jpeg: TJPEGImage;
      bmp: TBitmap;
    begin
      if  PictureDialog1.Execute then
      begin
        jpeg := TJPEGImage.Create;
        bmp := TBitmap.Create;
        try
          jpeg.LoadFromFile(PictureDialog1.FileName);
          bmp.Assign(jpeg);
          ADOTable1.Edit;                  // режим редактирования
          ADOTable1.FieldByName('Foto').Assign(bmp);//загрузка фото
          ADOTable1.Post;                  // сохраняем данные
        finally
          jpeg.Free;
          bmp.Free;
        end;
      end;
    end;
 }
end.
