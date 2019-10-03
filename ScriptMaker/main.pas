unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.Menus, parser, Contnrs, Vcl.Imaging.pngimage;

type
  TfrmMain = class(TForm)
    pnl1: TPanel;
    sg1: TStringGrid;
    pnl2: TPanel;
    pm1: TPopupMenu;
    mniAddString: TMenuItem;
    mniAddStringEx: TMenuItem;
    mniAddCombo: TMenuItem;
    mniN3: TMenuItem;
    mniDelete: TMenuItem;
    img1: TImage;
    img2: TImage;
    img3: TImage;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    mniHelp: TMenuItem;
    lbl8: TLabel;
    mniN5: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure sg1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mniHelpClick(Sender: TObject);
    procedure mniAddStringClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mniAddComboClick(Sender: TObject);
    procedure mniAddStringExClick(Sender: TObject);
    procedure mniDeleteClick(Sender: TObject);
  private
    { Private declarations }
    ObjectList : TObjectList;
    strList, strListTwo : TStringList;  // Переменая класса TStringList
    fPath : string;         // Путь к файлу entry.lua
    fObject : Boolean;   // флаг наличие константы "strDofile2"
    fSection : Boolean;  // флаг секции
   const
    fileScripts = 'entry.lua'; // Имя файла скрипта
    strDofile2 = 'dofile2 ("..\\built-in\\prim_basec.lua")'; // Константа для вставки в скрипт строк
    procedure CancelClicked (Sender : TObject);
    procedure OkClicked (Sender : TObject);
    function CheckName (const Name : string) : Boolean;
    function GetNewName (const Name : String) : String;
  public
    { Public declarations }
  end;


var
  frmMain: TfrmMain;

implementation
Uses setForm, setString, setStringEx, setComboEx;

{$R *.dfm}

procedure TfrmMain.CancelClicked(Sender: TObject);
begin
  sg1Click(nil);
end;

function TfrmMain.CheckName(const Name: string): Boolean;
var
  i : Integer;
begin
 // код проверки Name
  Result := True;
  for I := 0 to ObjectList.Count-1 do
    begin
      if i = sg1.Row-1 then
       Continue;
      if Name = TSimpleObject(ObjectList[i]).Name  then
        begin
          Result := False;
          Exit;
        end;
    end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i,j: Integer;
  S : String;
  sl : TStringList;
begin
  if Application.MessageBox('Сохранить выполненные изменения в файле?',
    PChar(Application.Title), MB_OKCANCEL + MB_ICONQUESTION) = IDCANCEL then
    Exit;

  if fObject then
   strList.Insert(0, strDofile2);

  // Ищем первую заполненную строчку после всех dofile2
  i := 0;
  while (i < strList.Count)  do
  begin
     if strList[i] = '' then
     begin
       strList.Delete(i);
       Continue;
     end;
     if pos ('dofile2',strList[i]) <= 0 then
       Break;
     inc(i);
  end;

  sl := TStringList.Create;

  sl.Add('') ;
  sl.Add('-- **') ;
  sl.Add('-- Это специальная секция, созданная утилитой ') ;
  sl.Add('-- gui_scripts.exe ') ;
  sl.Add('-- Пожалуйста, не выполняйте редактирование вручную') ;
  for j := 0 to ObjectList.Count-1 do
   sl.Add ('  ' + TSimpleObject(ObjectList.Items[j]).ToString);
  sl.Add('-- Конец специальной секции') ;
  sl.Add('-- **') ;
  sl.Add('') ;

  for j := 0 to sl.Count-1 do
    strList.Insert(i+j, sl.Strings[j]);

  sl.Free;

  strList.SaveToFile(fileScripts);  // запись в файл
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
 S : TSimpleObject;
 i : Integer;
begin
  ObjectList := TObjectList.Create (True);

  strList := TStringList.Create;
  strListTwo := TStringList.Create;

  fPath:= ExtractFilePath(Application.ExeName) + fileScripts;

  if not(FileExists(fPath)) then
  begin
    Application.MessageBox('Файл entry.lua не найден',
       PChar(Application.Title), MB_OK + MB_ICONSTOP);
    Exit; // Если его нет это оч плохо
  end
  else
  begin
      strList.LoadFromFile(fPath);   // чтение из файла entry.lua
  end;

  fObject := True;
  fSection := True;

  i := 0;
  while (i< strList.Count) do
  begin
     if strList.Strings[i] = strDofile2 then
      fObject := False;
     if (strList.Strings[i] = '-- **') then
      fSection := not fSection;
     if (not fSection) or (strList.Strings[i] = '-- **') then
       begin
         strListTwo.Add(strList.Strings[i]);
         strList.Delete(i);
         Continue;
       end;
     inc (i);
  end;

  //*********  Формируем ObjectList ***************
  // Вдруг в секции будет не наш объект
  S := TSimpleObject.Create ('');

  for I := 0 to strListTwo.Count - 1  do
  begin
   S.Parse(strListTwo.Strings[i]);
   if S.ObjType <> otUnck then
   begin
    ObjectList.Add(S);
    S := TSimpleObject.Create ('');
   end;
  end;

  S.Free;

  strListTwo.Free;
  //************************************************

  sg1.RowCount := ObjectList.Count + 1;

  i := 0;
  while (i < ObjectList.Count) do
  begin
     sg1.Cells [0,i+1] := TSimpleObject(ObjectList[i]).Name;
     sg1.Cells [1,i+1] := TSimpleObject(ObjectList[i]).ObjTypeToString;
     Inc(I);
  end;

  sg1.Cells [0,0] := 'Имя объекта';
  sg1.Cells [1,0] := 'Тип объекта';

end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
 ObjectList.Free;
 strList.Free;
end;

function TfrmMain.GetNewName(const Name: String): String;
var
 i : Integer;
begin
 i := 0;
 while (True) do
 begin
    Result := Name + IntToStr(i);
    if CheckName(Result) then
     Exit;
    inc (i);
 end;
end;

procedure TfrmMain.mniAddComboClick(Sender: TObject);
var
 S    : TComboParser;
begin
  S := TComboParser.Create (GetNewName ('cmb'));
  ObjectList.Add(S);
  sg1.RowCount := sg1.RowCount + 1;
  sg1.Row := sg1.RowCount-1;
  sg1.Cells [0, sg1.RowCount-1] := S.Name;
  sg1.Cells [1, sg1.RowCount-1] := S.ObjTypeToString;
  sg1Click(nil);
end;

procedure TfrmMain.mniAddStringClick(Sender: TObject);
var
 S    : TStringParser;
begin
  sg1.Row := 1;
  S := TStringParser.Create (GetNewName ('str'));
  ObjectList.Add(S);
  sg1.RowCount := sg1.RowCount + 1;
  sg1.Row := sg1.RowCount-1;
  sg1.Cells [0, sg1.RowCount-1] := S.Name;
  sg1.Cells [1, sg1.RowCount-1] := S.ObjTypeToString;
  sg1Click(nil);
end;

procedure TfrmMain.mniAddStringExClick(Sender: TObject);
var
 S : TStringExParser;
begin
  S := TStringExParser.Create (GetNewName ('strEx'));
  ObjectList.Add(S);
  sg1.RowCount := sg1.RowCount + 1;
  sg1.Row := sg1.RowCount-1;
  sg1.Cells [0, sg1.RowCount-1] := S.Name;
  sg1.Cells [1, sg1.RowCount-1] := S.ObjTypeToString;
  sg1Click(nil);
end;

//********* Описание кода удаления объекта ***********************************************
procedure TfrmMain.mniDeleteClick(Sender: TObject);
begin
  // Игорь, код удаления не описан
end;
//****************************************************************************************

procedure TfrmMain.mniHelpClick(Sender: TObject);
begin
 frmString.Hide;
 frmStringEx.Hide;
 pnl2.Invalidate;
end;

procedure TfrmMain.OkClicked(Sender: TObject);
begin
 sg1.Cells [0, sg1.Row] := TSimpleObject (ObjectList[sg1.Row-1]).Name;
end;

procedure TfrmMain.sg1Click(Sender: TObject);
var
 ObjectType : TObjectType;
 S : TSimpleObject;
begin
  S :=  TSimpleObject (ObjectList[sg1.Row-1]);
  ObjectType := S.ObjType;
  case ObjectType of
    otUnck: ;
    otString:
     begin
      frmString.Parent := pnl2;
      frmString.Init (S, CheckName, OkClicked, CancelClicked);
      frmString.Show;
     end;
    otStringEx:
     begin
       frmStringEx.Parent:= pnl2;
       frmStringEx.Init  (S, CheckName, OkClicked, CancelClicked);
       frmStringEx.Show;
     end;
    otComboEx:
    begin
     frmComboEx.Parent := pnl2;
     frmComboEx.Init  (S, CheckName, OkClicked, CancelClicked);
     frmComboEx.Show;
    end;
  end;
end;

end.
