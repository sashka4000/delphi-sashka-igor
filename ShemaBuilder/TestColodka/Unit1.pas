unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids;

type
  TForm1 = class(TForm)
    sg1: TStringGrid;
    btn1: TButton;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    edt5: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    procedure btn1Click(Sender: TObject);
    procedure sg1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    A : TArray<String>;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
 i : Integer;
 l : TArray<Integer>;
 S : String;
 TC : Integer;
 fc  : Integer;
 sl : Integer;
  j: Integer;
  k: Integer;
  z: Integer;
begin
 sg1.ColCount := String(edt5.Text).ToInteger();

 SetLength(A,sg1.ColCount);

 l := TArray<Integer>.Create(0,0,0,0);

 l[0] := String(edt1.Text).ToInteger();
 l[1] := String(edt2.Text).ToInteger();
 l[2] := String(edt3.Text).ToInteger();
 l[3] := String(edt4.Text).ToInteger();

 fc := sg1.ColCount;
 sl := 0;
 tc := 0;
 for i := 0 to 3 do
 begin
  sl := sl  +  l[i]*(I+1);
  if l[i] > 0 then
    tc := tc + l[i];
 end;

 if fc < sl + tc-1 then
 begin
    ShowMessage ('Ошибка. Не уместится ');
 end;


 fc := fc - sl;


 fc := fc div  (tc - 1);



  for i := 0 to High(A) do
    A[i] := '';

 i := 0;
   for j := 0 to 3 do
   begin
     if l[j] = 0  then  Continue;
     for k := 0 to l[j]-1 do
     begin
       for z := 1 to j+1 do
       begin
         A[i] := '1';
         Inc(i);
       end;
       inc (I,fc);
     end;
   end;


 for i := 0 to High(A) do
    sg1.Cells [i,0] := A[i];

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 edt5.Text := sg1.ColCount.ToString;
end;

procedure TForm1.sg1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
  if sg1.cells[ACol,ARow] <> ''  then
  begin
    sg1.Canvas.Brush.Color := clRed;
  end else
  begin
   sg1.Canvas.Brush.Color := clWhite;
  end;
  sg1.Canvas.FillRect(Rect);
end;

end.
