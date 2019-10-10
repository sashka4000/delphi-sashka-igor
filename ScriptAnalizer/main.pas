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
     Code : TStringList;     // Код функции
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
    procedure lstFunctionsClick(Sender: TObject);
  private
    { Private declarations }
    OL_Object : TObjectList;
    OL_Function : TObjectList;
  public
    { Public declarations }
    function GetFilesForScan : TStringList;
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
  entrylau = 'entry.lua';

  objecttypes : array [0..1] of String =
  (
   ('topc_string'),
   ('topc_string_min_max')
  );


procedure TForm1.FormCreate(Sender: TObject);
var
  FileNames : TStringList;
  i: Integer;
begin
  OL_Object := TObjectList.Create (true);
  OL_Function := TObjectList.Create (true);


  FileNames := GetFilesForScan;

  if (FileNames = nil) or (FileNames.Count = 0) then
  begin
    ShowMessage('Ничего не найдено');
    Exit;
  end;

  for i := 0 to FileNames.Count-1 do
  begin
     ScanFileForObject(FileNames[i]);
     ScanFileForFunction(FileNames[i]);
  end;

  FileNames.Free;

  for i := 0 to OL_Object.Count-1 do
   lstObject.AddItem(TLUAObject(OL_Object[i]).Name,nil);

  for i := 0 to OL_Function.Count-1 do
   lstFunctions.AddItem(TLUAFunction(OL_Function[i]).Name,nil);

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  OL_Object.Free;
  OL_Function.Free;
end;

//****************************************************************************************

function TForm1.GetFilesForScan: TStringList;
var
  ssList : TStringList;
  fPath, nameTemp, lTemp : string;
  i, posishen : Integer;
begin
    // Функция должна получить список файлов для дальнейшего анализа
    fPath := ExtractFilePath(Application.ExeName) + 'scripts\' ;
    if FileExists(fPath +  entrylau) then    // Исправлено
      begin
        Result := TStringList.Create;
        ssList := TStringList.Create;
        ssList.LoadFromFile(fPath + entrylau);
        for I := 0 to ssList.Count -1 do
          begin
            lTemp := ssList[i];
            if ltemp.IndexOf('dofile2') > -1 then
              begin
                Fetch(lTemp,'"');  // лучше так а не ("
                lTemp := Fetch(lTemp, '"');
                Result.Add(fpath + lTemp);
              end;
          end;
        Result.Insert(0,fpath + entrylau);
        ssList.Free;
      end else
       Result := nil;
end;



//****************************************************************************************

//****************** Выбор из TListBox ***************************************************
procedure TForm1.lstFunctionsClick(Sender: TObject);
var
  i : integer;
begin
  if lstFunctions.ItemIndex < 0 then
    Exit;
  mmoFunctionCode.Clear;
  mmoFunctionCode.Lines[0] := 'Name : ' + TLUAFunction (OL_Function[lstFunctions.ItemIndex]).Name;

  mmoFunctionCode.Lines.Add('Code : ');
  mmoFunctionCode.Lines.Add('******************************************************');
  for I := 0 to TLUAFunction (OL_Function[lstFunctions.ItemIndex]).Code.Count -1 do
    mmoFunctionCode.Lines.Add(TLUAFunction (OL_Function[lstFunctions.ItemIndex]).Code.Strings[i]);
  mmoFunctionCode.Lines.Add('******************************************************');
  mmoFunctionCode.Lines.Add('ParametrCount : ' + IntToStr(TLUAFunction (OL_Function[lstFunctions.ItemIndex]).ParamCount));
  mmoFunctionCode.Lines.Add('ParametrNames : ' + TLUAFunction (OL_Function[lstFunctions.ItemIndex]).ParamNames);
end;

procedure TForm1.lstObjectClick(Sender: TObject);
begin
  // выбрано ли что-то ?
  if lstObject.ItemIndex < 0 then
    Exit;
  mmoObjectCode.Text := TLUAObject (OL_Object[lstObject.ItemIndex]).Code;
end;
//****************************************************************************************


//*************************** Процедура поиска функций ***********************************
procedure TForm1.ScanFileForFunction(const FileName: string);
var
  sl : TStringList;
  i, indexBegin, indexEnd : Integer;
  LF  : TLUAFunction;
  tmp : String;
begin
  // сканирование файла для поиска функций и заполнение OL_Function
 sl := TStringList.Create;
 sl.LoadFromFile(FileName);
 i:= 0;
 indexBegin := 0;
 indexEnd  := 0;
//   ищем строку с заголовком "function"
     while I < sl.Count - 1  do
       begin
         if not(sl.Strings[i].IndexOf('function') > -1) then
         begin
           Inc(i);
           Continue
         end
         else if
// исключаем функцию 'function main_custom', не хотелось в первом "if" городить
// сложное условие
           sl.Strings[i].IndexOf('function main_custom') > -1 then
             begin
               Inc(i);
               Continue ;
             end;


             LF := TLUAFunction.Create;
             LF.Code := TStringList.Create(True);
             indexBegin := i;
             tmp := sl.Strings[i];
             LF.ParamCount :=0;
             Fetch(tmp,'function');
             LF.Name := Trim(Fetch(tmp,'('));
             LF.ParamNames := '(' + tmp;
             tmp := Trim(Fetch(tmp, ')'));
               while tmp <> '' do
                 begin
                   Trim(Fetch(tmp, ','));
                   Inc(LF.ParamCount);
                 end;
              inc(i);
//************** Вырезаю тело функции ****************************************************
           while i < sl.Count  do
             if sl.Strings[i].IndexOf('end') > -1 then
               begin
                 indexEnd := i;
                 if i = sl.Count -1 then
                   begin
                     while indexBegin <= indexEnd do
                       begin
                         LF.Code.add(sl.Strings[indexBegin]);
                         Inc(indexBegin);
                       end;
                    OL_Function.Add(LF);
                   end;
                 inc(i);
                 Continue
               end
             else if
              (sl.Strings[i].IndexOf('function') > -1) or (i = sl.Count -1) then
                begin
                  while indexBegin <= indexEnd do
                    begin
                      LF.Code.add(sl.Strings[indexBegin]);
                      Inc(indexBegin);
                    end;
                  OL_Function.Add(LF);
                  Break;
                end
             else  inc(i);

       end;
  sl.Free;
   end;

//****************************************************************************************

//*************************** Процедура поиска объектов **********************************
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
  // берем следующую строку
  inc (i);
 end;

 sl.Free;
end;
//****************************************************************************************
end.
