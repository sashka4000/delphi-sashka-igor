unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  System.Contnrs, System.types, System.IOUtils;

type
  TLUAObject = class
     Name : String;     // ���
     Code : String;     // ��� �������
    end;

   TLUAFunction = class
     Name : String;     // ���
     Code : String;     // ��� �������
     ParamCount: Integer; // ����� ������� ����������
     ParamNames : String; // ������� ���������
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
    ShowMessage('������ �� �������');
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
   lstFunctions.AddItem(TLUAFunction(OL_Object[i]).Name,nil);

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
    // ������� ������ �������� ������ ������ ��� ����������� �������
    fPath := ExtractFilePath(Application.ExeName) + 'scripts\' ;
    if FileExists(fPath +  entrylau) then    // ����������
      begin
        Result := TStringList.Create;
        ssList := TStringList.Create;
        ssList.LoadFromFile(fPath + entrylau);
        for I := 0 to ssList.Count -1 do
          begin
            lTemp := ssList[i];
            if ltemp.IndexOf('dofile2') > -1 then
              begin
                Fetch(lTemp,'"');  // ����� ��� � �� ("
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

procedure TForm1.lstObjectClick(Sender: TObject);
begin
  // ������� �� ���-�� ?
  if lstObject.ItemIndex < 0 then
    Exit;
  mmoObjectCode.Text := TLUAObject (OL_Object[lstObject.ItemIndex]).Code;
end;

//*************************** ��������� ������ ������� ***********************************
procedure TForm1.ScanFileForFunction(const FileName: string);
var
  sl : TStringList;
  i, j : Integer;
  LF : TLUAFunction;
  tmp, parTmp  : String;
begin
  // ������������ ����� ��� ������ ������� � ���������� OL_Function
 sl := TStringList.Create;
 sl.LoadFromFile(FileName);
 i := 0;
 while (i < sl.Count) do
   begin
//   ���� ������ � ���������� "function"
     for I := 0  to sl.Count - 1 do
       begin
         if not(sl.Strings[i].IndexOf('function') > -1) then
           Continue
         else if
           sl.Strings[i].IndexOf('function main_custom') > -1 then
             Continue
           else
             begin

               tmp := sl.Strings[i];
               LF := TLUAFunction.Create;
               Fetch(tmp,'function');
               LF.Name := Trim(Fetch(tmp,'('));
             end;
       end;

   end;


end;
//****************************************************************************************

//*************************** ��������� ������ �������� **********************************
procedure TForm1.ScanFileForObject(const Filename: String);
var
 sl : TStringList;
 i, j : Integer;
 LO : TLUAObject;
 tmp : String;
begin
 // ������������ ����� ��� ������ �������� � ���������� OL_Object
 sl := TStringList.Create;

 sl.LoadFromFile(FileName);

 i := 0;
 while (i < sl.Count) do
 begin
  // ���������� ������ � ��������� �������� ��������
  for j := 0 to High (objecttypes) do
  begin
   if pos  (objecttypes[j], sl.Strings[i]) > 0 then
   begin
      // ��� ������
      tmp :=  sl.Strings[i];
      LO := TLUAObject.Create;
      // Trim - ������ ��� �������
      LO.Name := Trim (Fetch(tmp,'=',False));
      LO.Code :=  sl.Strings[i];
      OL_Object.Add (LO);
      break; // ����� �� �����
   end;
  end;
  // ����� ��������� ������
  inc (i);
 end;

 sl.Free;
end;
//****************************************************************************************
end.
