unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  System.Contnrs, System.types, System.IOUtils;

type
  TLUAObject = class
     Name : String;     // Имя
     Code : String;     // Код объекта
    end;

   TLUAFunction = class
     Name : String;     // Имя
     Code : String;     // Код функции
     ParamCount: Integer; // число входных параметров
     ParamNames : String; // Входные параметры
    end;



  TForm1 = class(TForm)
    mmoObjectCode: TMemo;
    lbl1: TLabel;
    lstObject: TListBox;
    lstFunctions: TListBox;
    lblFunction: TLabel;
    lbl2: TLabel;
    mmoFunctionCode: TMemo;
    lbl3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lstObjectClick(Sender: TObject);
  private
    { Private declarations }
    OL_Object : TObjectList;
    OL_Function : TObjectList;
    function SearchFileEntry_LUA : TStringList;
  public
    { Public declarations }
    function GetFilesForScan : TStringDynArray;
    procedure ScanFileForObject (const Filename: String);
    procedure ScanFileForFunction (const FileName : string);
  end;

var
  Form1: TForm1;
  FilesArray : TStringDynArray;
implementation
Uses IdGlobal;

{$R *.dfm}

const
  objecttypes : array [0..1] of String =
  (
   ('topc_string'),
   ('topc_string_min_max')
  );


procedure TForm1.FormCreate(Sender: TObject);
var
 FileNames : TStringDynArray;
  i: Integer;
begin
  OL_Object := TObjectList.Create (true);
  OL_Function := TObjectList.Create (true);
  FileNames := GetFilesForScan;
  for i := 0 to High(FileNames) do
  begin
     ScanFileForObject(FileNames[i]);
     ScanFileForFunction(FileNames[i]);
  end;

  for i := 0 to OL_Object.Count-1 do
   lstObject.AddItem(TLUAObject(OL_Object[i]).Name,nil);

  for i := 0 to OL_Function.Count-1 do
   lstFunctions.AddItem(TLUAFunction(OL_Object[i]).Name,nil);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  OL_Object.Free;
  OL_Function.Free;
end;

//*************** Функция поиска и парсинга файла entry.lua ******************************
function TForm1.SearchFileEntry_LUA : TStringList;
var
  sList, ssList : TStringList;
  fPath, nameTemp, lTemp : string;
  i, posishen : Integer;
  begin
    fPath := ExtractFilePath(Application.ExeName) + 'scripts\' ;
    if bool(TDirectory.GetFiles(fPath, 'entry.lua')) then
      begin
        sList := TStringList.Create;
        ssList := TStringList.Create;
        sList.LoadFromFile(fPath + 'entry.lua');
        for I := 0 to sList.Count -1 do
          begin
            lTemp := sList[i];
            if ltemp.IndexOf('dofile2') > -1 then
              begin
                Fetch(lTemp,'("');
                lTemp := Fetch(lTemp, '"');
                ssList.Add(lTemp);
              end;
          end;
        ssList.Insert(0,'entry.lua');
        Result := ssList;
        ssList.SaveToFile('config.txt');
      end;
      sList.Free;
      ssList.free;
 end;
//****************************************************************************************

function TForm1.GetFilesForScan: TStringDynArray;
var
  sList, ssList : TStringList;
  i : Integer;
  fPath : string;
  fFile : file;
begin
  // Функция должна получить список файлов для дальнейшего анализа
//******************* Реализация функции список файлов  **********************************
  sList := TStringList.Create;
  ssList := TStringList.Create;
  sList := SearchFileEntry_LUA;
  fPath := ExtractFilePath(Application.ExeName) + 'scripts\';
  FilesArray := TDirectory.GetFiles( fPath, '*.lua');
 // Дальше буду думать как содержимое всех файлов слить в один StringList для парсинга
{  for I := 0 to Length(FilesArray) - 1 do
    if FilesArray[i] = (fPath + sList[i]) then
      begin
        fFile
        fFile := filesArray[i];
        ssList.LoadFromFile(fFile);
      end; }
    end;



//****************************************************************************************

procedure TForm1.lstObjectClick(Sender: TObject);
begin
  // выбрано ли что-то ?
  if lstObject.ItemIndex < 0 then
    Exit;
  mmoObjectCode.Text := TLUAObject (OL_Object[lstObject.ItemIndex]).Code;
end;

procedure TForm1.ScanFileForFunction(const FileName: string);
begin
  // сканирование файла для поиска функций и заполнение OL_Function

end;

procedure TForm1.ScanFileForObject(const Filename: String);
var
 sl : TStringList;
 i, j : Integer;
 LO : TLUAObject;
 tmp : String;
begin
 // сканирование файла для поиска объектов и заполнение OL_Object
 sl := TStringList.Create;

 sl.LoadFromFile(FileName);

 i := 0;
 while (i < sl.Count) do
 begin
  // сравниваем строку с возможным перечнем объектов
  for j := 0 to High (objecttypes) do
  begin
   if pos  (objecttypes[j], sl.Strings[i]) > 0 then
   begin
      // Это объект
      tmp :=  sl.Strings[i];
      LO := TLUAObject.Create;
      // Trim - удалит все пробелы
      LO.Name := Trim (Fetch(tmp,'=',False));
      LO.Code :=  sl.Strings[i];
      OL_Object.Add (LO);
      break; // выход из цикла
   end;
  end;
  // берем следуюзую строку
  inc (i);
 end;

 sl.Free;
end;

end.
