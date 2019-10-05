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
    strList, strListTwo : TStringList;  // ��������� ������ TStringList
    fPath : string;         // ���� � ����� entry.lua
    fObject : Boolean;   // ���� ������� ��������� "strDofile2"
    fSection : Boolean;  // ���� ������
    fSelectedIndex : Integer;
   const
    fileScripts = 'entry.lua'; // ��� ����� �������
    strDofile2 = 'dofile2 ("..\\built-in\\prim_basec.lua")'; // ��������� ��� ������� � ������ �����
    procedure CancelClicked (Sender : TObject);
    procedure OkClicked (Sender : TObject);
    procedure createTable(Sender : TObject);
    procedure addString(const nameStr : string);
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

//********************************

//****************************************************************************************

procedure TfrmMain.CancelClicked(Sender: TObject);
begin
  sg1Click(nil);
end;

function TfrmMain.CheckName(const Name: string): Boolean;
var
  i : Integer;
begin
 // ��� �������� Name
  Result := True;
  for I := 0 to ObjectList.Count-1 do
    begin
      if i = fSelectedIndex then
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
//  S : String;
  sl : TStringList;
begin
  if Application.MessageBox('��������� ����������� ��������� � �����?',
    PChar(Application.Title), MB_OKCANCEL + MB_ICONQUESTION) = IDCANCEL then
    Exit;

  if fObject then
   strList.Insert(0, strDofile2);

  // ���� ������ ����������� ������� ����� ���� dofile2
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
  sl.Add('-- ��� ����������� ������, ��������� �������� ') ;
  sl.Add('-- gui_scripts.exe ') ;
  sl.Add('-- ����������, �� ���������� �������������� �������') ;
  for j := 0 to ObjectList.Count-1 do
   sl.Add (TSimpleObject(ObjectList.Items[j]).ToString);
  sl.Add('-- ����� ����������� ������') ;
  sl.Add('-- **') ;
  sl.Add('') ;

  for j := 0 to sl.Count-1 do
    strList.Insert(i+j, sl.Strings[j]);

  sl.Free;

  strList.SaveToFile(fileScripts);  // ������ � ����
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
 S : TSimpleObject;
 i : Integer;
begin
  ObjectList := TObjectList.Create (True);

  strList := TStringList.Create;
  strListTwo := TStringList.Create;

  fSelectedIndex := -1;

  fPath:= ExtractFilePath(Application.ExeName) + fileScripts;

  if not(FileExists(fPath)) then
  begin
    Application.MessageBox('���� entry.lua �� ������',
       PChar(Application.Title), MB_OK + MB_ICONSTOP);
    Exit; // ���� ��� ��� ��� �� �����
  end
  else
  begin
      strList.LoadFromFile(fPath);   // ������ �� ����� entry.lua
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

  //*********  ��������� ObjectList ***************
  // ����� � ������ ����� �� ��� ������
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
  createTable(nil);
  sg1.Cells [0,0] := '��� �������';
  sg1.Cells [1,0] := '��� �������';

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
// ********************* ��������� ���������� �������� ****************************************
procedure TfrmMain.mniAddStringClick(Sender: TObject);
var
  nameObject : string;
  begin
    nameObject := 'str';
    addString(nameObject);

  end;

procedure TfrmMain.mniAddStringExClick(Sender: TObject);
var
  nameObject : string;
begin
  nameObject := 'strEx';
  addString(nameObject);
end;

procedure TfrmMain.mniAddComboClick(Sender: TObject);
var
  nameObject : string;
begin
  nameObject := 'cmd';
  addString(nameObject);
end;
//*********************************************************************************************

//********* �������� ���� �������� ������� ***********************************************
procedure TfrmMain.mniDeleteClick(Sender: TObject);
var
  i : Integer;
begin
   if sg1.RowCount = 1 then
    Exit;
   if Application.MessageBox('�� �������, ��� ������ ������� ������?',
    PChar(Application.Title), MB_OKCANCEL + MB_ICONQUESTION) = IDCANCEL then
    Exit;
    ObjectList.Delete(sg1.Row -1);
    for I := 1 to sg1.RowCount -1 do
      sg1.Rows[i].clear;
    sg1.RowCount := ObjectList.Count + 1;
    createTable(nil);
  if sg1.RowCount > 1 then
  begin
   sg1.Row := sg1.RowCount-1;
   sg1Click(nil);
  end else
   fSelectedIndex := -1;
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
  if sg1.Row = 0 then
   Exit;
  fSelectedIndex := sg1.Row-1;
  S :=  TSimpleObject (ObjectList[fSelectedIndex]);
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

//******************* ��������� ������������ ������� ******************************************
procedure TfrmMain.createTable(Sender : TObject);
var
  i : Integer;
begin
 i := 0;
  while (i < ObjectList.Count) do
  begin
     sg1.Cells [0,i+1] := TSimpleObject(ObjectList[i]).Name;
     sg1.Cells [1,i+1] := TSimpleObject(ObjectList[i]).ObjTypeToString;
     Inc(I);
  end;
end;
//*********************************************************************************************

//********************** ��������� ������������� ������ ***************************************
procedure TfrmMain.addString(const nameStr : string);
var
 S : TSimpleObject;
begin
  fSelectedIndex := -1;
  if nameStr = 'str' then
     S := TStringParser.Create (GetNewName (nameStr))
  else if nameStr = 'strEx' then
     S := TStringExParser.Create (GetNewName (nameStr))
  else
     S := TComboParser.Create (GetNewName (nameStr));
  ObjectList.Add(S);
  sg1.RowCount := sg1.RowCount + 1;
  sg1.Cells [0, sg1.RowCount-1] := S.Name;
  sg1.Cells [1, sg1.RowCount-1] := S.ObjTypeToString;
  sg1Click(nil);
  end;

//*********************************************************************************************
end.
