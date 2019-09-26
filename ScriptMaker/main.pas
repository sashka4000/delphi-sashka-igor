unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.Menus, parser, Contnrs, Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    pnl1: TPanel;
    sg1: TStringGrid;
    pnl2: TPanel;
    pm1: TPopupMenu;
    mniLj1: TMenuItem;
    mniN1: TMenuItem;
    mniN2: TMenuItem;
    mniN3: TMenuItem;
    mniN4: TMenuItem;
    img1: TImage;
    img2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure sg1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ObjectList : TObjectList;
    procedure CancelClicked (Sender : TObject);
    function CheckName (const Name : string) : Boolean;
  public
    { Public declarations }
  end;


var
  Form1: TForm1;


implementation
Uses setForm, setString, setStringEx;

{$R *.dfm}

procedure TForm1.CancelClicked(Sender: TObject);
begin
  sg1Click(nil);
end;

function TForm1.CheckName(const Name: string): Boolean;
begin
 Result := True;
 // Игорь - необходимо написать Текст процедуры проверки
 // что Имя Name, которое ввел пользователь еще не используется
 // Result = true   - все Ок, Имя еще не используется
 // Result = false  - имя уже используется
end;

procedure TForm1.FormCreate(Sender: TObject);
var
 S : TSimpleObject;
 i : Integer;
begin
  ObjectList := TObjectList.Create (True);
  // чтение объектов из файла

  S := TSimpleObject.Create;
  S.Parse('obj1 = topc_string_min_max ("Комментарий",0,100)');

  ObjectList.Add(S);

  S := TSimpleObject.Create;
  S.Parse('obj2 = topc_string ("Комментарий")');

  ObjectList.Add(S);
  //

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

procedure TForm1.FormDestroy(Sender: TObject);
begin
 ObjectList.Free;
end;

procedure TForm1.sg1Click(Sender: TObject);
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
      frmString.Init (S, CheckName, CancelClicked);
      frmString.Show;
     end;
    otStringEx:
     begin
       frmStringEx.Parent:= pnl2;
       frmStringEx.Init  (S, CheckName, CancelClicked);
       frmStringEx.Show;
     end;
    otCombo: ;
    otComboEx: ;
  end;
end;

end.
