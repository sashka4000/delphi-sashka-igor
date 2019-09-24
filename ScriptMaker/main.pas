unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.Menus;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TObjectRecord = record
     Name : String;
     ObjType : String;
     Params : String;
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
begin
 // Load settings
 with sg1 do
   begin
     Cells [0,1] := 'Test1';
     Cells [1,1] := 'topc_string';
     Cells [0,2] := 'Test2';
     Cells [1,2] := 'topc_string_ex';

   end;
end;

procedure TForm1.sg1Click(Sender: TObject);
begin
  if sg1.Cells [1, sg1.Row] = 'topc_string' then
  begin
   frmString.ParentWindow := pnl2.Handle;
   frmString.Show;
  end;
  if sg1.Cells [1, sg1.Row] = 'topc_string_ex' then
  begin
   frmStringEx.ParentWindow := pnl2.Handle;
   frmStringEx.Show;
  end;

end;

end.
