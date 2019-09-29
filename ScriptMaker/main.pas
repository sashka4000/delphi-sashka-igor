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
  private
    { Private declarations }
    ObjectList : TObjectList;
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
  fName : string;
  i : Integer;
begin
  fName := Name;
  for I := 0 to ObjectList.Count-1 do
    begin
// код проверки Name
      if fName = TSimpleObject(ObjectList[i]).Name  then
        begin
          ShowMessage('Данное имя уже существует ' + #10 + 'Присвойте другое имя.');
          Result := False;
          Abort
        end;

    end;


  Result := True;
 // Игорь - необходимо написать Текст процедуры проверки
 // что Имя Name, которое ввел пользователь еще не используется
 // Result = true   - все Ок, Имя еще не используется
 // Result = false  - имя уже используется
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
  S : String;
begin
  if Application.MessageBox('Сохранить выполненные изменения в файле?',
    PChar(Application.Title), MB_OKCANCEL + MB_ICONQUESTION) = IDCANCEL then
    Exit;
  //  Код сохранения ObjList to File
  // ....
  //
  S := '';
  for i := 0 to ObjectList.Count-1 do
  begin
    S := S + TSimpleObject(ObjectList.Items[i]).ToString + #13#10;
  end;
  ShowMessage(S);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
 S : TSimpleObject;
 i : Integer;
begin
  ObjectList := TObjectList.Create (True);
  // чтение объектов из файла
  // ....
  //

  // После добавления чтения этот код убрать
  S := TSimpleObject.Create ('');
  S.Parse('obj1 = topc_string_min_max ("Комментарий",0,100)');

  ObjectList.Add(S);

  S := TSimpleObject.Create ('');
  S.Parse('obj2 = topc_string ("Комментарий")');

  ObjectList.Add(S);

  S := TSimpleObject.Create ('');
  S.Parse('obj3 = topc_string ("Комментарий")');

  ObjectList.Add(S);
  // -------------------------------------------

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
