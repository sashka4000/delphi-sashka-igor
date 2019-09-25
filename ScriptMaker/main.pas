unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.Menus, parser, Contnrs;

type
  TForm1 = class(TForm)
    pnl1: TPanel;
    sg1: TStringGrid;
    pnl2: TPanel;
    btn1: TButton;
    btn2: TButton;
    pm1: TPopupMenu;
    mniLj1: TMenuItem;
    mniN1: TMenuItem;
    mniN2: TMenuItem;
    mniN3: TMenuItem;
    mniN4: TMenuItem;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sg1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ObjectList : TObjectList;
  public
    { Public declarations }
  end;


var
  Form1: TForm1;


implementation
Uses setForm, setString, setStringEx;

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
 S : TSimpleObject;
 i : Integer;
begin
  ObjectList := TObjectList.Create (True);
  // чтение объектов из файла

  S := TSimpleObject.Create;
  S.Parse('tstringex = topc_string_min_max ("Комментарий",0,100)');

  ObjectList.Add(S);

  S := TSimpleObject.Create;
  S.Parse('tstring = topc_string ("Комментарий")');

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
      frmString.ParentWindow := pnl2.Handle;
      frmString.Init (S);
      frmString.Show;
     end;
    otStringEx:
     begin
       frmStringEx.ParentWindow := pnl2.Handle;
       frmStringEx.Init  (S);
       frmStringEx.Show;
     end;
    otCombo: ;
    otComboEx: ;
  end;
end;

end.
