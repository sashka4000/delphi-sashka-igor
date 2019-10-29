unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Contnrs,
  Vcl.StdCtrls;

type
  TDescription = array of String;

  TContact = class
   public
    // �������� �������� ������������ ������ ��������������
    // ���� �������� = $  - ���� ���������� ������ ����������
     Contact : String;
    // �������, ���� <> '' �� �������� ����� � �������� �������
     Description : String;
     constructor Create (const asCont, asDesc : String);
  end;

  TColodka = class  // ��������� �������� TContact   - ����� ���������
   private
    Name : String;  // �������� ������ ��������� ������������ ������ ��������������
    Contacts : TObjectList;
    constructor Create (const asName :String);
    // ���������� �����, ����� ������� Contacts.Free
    destructor Destroy; override;
  end;

  TJumpAddress = class    // ����� ������������ �����������
   public
    Number : Integer;   // ������ �����
    Description : TDescription; // �������� ����� ��������� � ������� ��� ����
    JumpersType : Integer; // 2 - ���� ����������, 3 - ���� ����������
    constructor Create (const jumNumber, jumJumpersType : Integer);
  end;
// ���������� �������� ����� TBitmap
  TPictureBitmap = class (TBitmap)
    public
    FileName : string;

  end;

  TfrmMain = class(TForm)
    pb1: TPaintBox;
    lbl1: TLabel;
    btnTest1: TButton;
    btnSave: TButton;
    procedure pb1Paint(Sender: TObject);
    procedure btnTest1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frmMainToBitmap(pb1 : TPaintBox; var PBitmap : TPictureBitmap);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
    DeviceName : String;    // ��� ����������
    LS, RS  : TObjectList; //  ��������� �������� TColodka ��� ����� � ������ ������ ����������
    JA : TJumpAddress;
    PBitmap : TPictureBitmap;
    function differenceColodka(LObject : TObjectList): integer;
    function changeDecToString(const Value : Integer): string;
   	procedure buildingColodka(const diffCol : Integer;LOject : TObjectList);
    procedure rayPaint(const diffCol : Integer; const Text : string; LOject : TObjectList);
    procedure jumpPosition (jumPos : string);
    // ����� �������� ������� ��������� ������
    function DrawTextCentered(Canvas: TCanvas; const R: TRect; S: String): Integer;
  public
    { Public declarations }
    // � ���� ��������� ������ ����������� ���������
  end;

const
RayWidth  = 100;    // ���

var
  frmMain: TfrmMain;
implementation

{$R *.dfm}

procedure TfrmMain.btnTest1Click(Sender: TObject);
var
 C : TColodka;
begin
  // ���������� �� ��� ������ ����
  LS.Free;
  RS.Free;
  JA.Free;
  PBitmap.Free;
  // ������ ����� �����

  DeviceName := '���-2�.1';

  // ����� �������

  JA := TJumpAddress.Create(0,0);

  SetLength(JA.Description,5);
  JA.Description[0] := 'A1';
  JA.Description[1] := 'A2';
  JA.Description[2] := 'A3';
  JA.Description[3] := 'A4';
  JA.Description[4] := 'A5';

  JA.Number := 18;
  JA.JumpersType := 2;


  LS := TObjectList.Create (true);
  C := TColodka.Create('����� ������ ���');
  C.Contacts.Add(TContact.Create('K1',''));
  C.Contacts.Add(TContact.Create('K2','�������'));
  C.Contacts.Add(TContact.Create('K3','�������2'));
  C.Contacts.Add(TContact.Create('K4',''));
  C.Contacts.Add(TContact.Create('K5',''));
  LS.Add(C);

  C := TColodka.Create('����� ��������� ���');
  C.Contacts.Add(TContact.Create('�1',''));
  C.Contacts.Add(TContact.Create('�2','�������'));
  C.Contacts.Add(TContact.Create('�3','�������2'));
  C.Contacts.Add(TContact.Create('�4',''));
  LS.Add(C);
 //*******************************************
  C := TColodka.Create('����� ��������� ���');
  C.Contacts.Add(TContact.Create('�1',''));
  C.Contacts.Add(TContact.Create('�2','�������'));
  C.Contacts.Add(TContact.Create('�3','�������2'));
  C.Contacts.Add(TContact.Create('�4',''));
  LS.Add(C);

  C := TColodka.Create('����� ������ ���');
  C.Contacts.Add(TContact.Create('K1',''));
  C.Contacts.Add(TContact.Create('K2','�������'));
  C.Contacts.Add(TContact.Create('K3','�������2'));
  C.Contacts.Add(TContact.Create('K4',''));
  C.Contacts.Add(TContact.Create('$',''));
  LS.Add(C);
//**********************************************
  RS := TObjectList.Create (true);
  C := TColodka.Create('����');
  C.Contacts.Add(TContact.Create('1','����'));
  RS.Add(C);

  // �������� ����������� �����

  pb1.Repaint;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  DeviceName := '������ ����';
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  LS.Free;
  RS.Free;
  JA.Free;
end;

//************************** ���������� ������� changeDecToString *********************************
function TfrmMain.changeDecToString(const Value : Integer): string;
var
vArray : array of Integer;
i : Integer;
v : Integer;
  begin
    Result := '';
    v := Value;
    SetLength(vArray,Length(JA.Description));
    if (v >= 0) and (v <= 31) then
    begin
    for I := 0 to High(vArray) do
      begin
        vArray[i] := v and 1 ;
        v := v shr 1;
      end;
    for I := 0 to High(vArray) do
      Result := Result + vArray[i].ToString;
    end
    else
      ShowMessage('������ ������ ���������');
  end;
//****************************************************************************************

procedure TfrmMain.pb1Paint(Sender: TObject);
var
  X, W : Integer;
 differnceHeight : Integer;  // ��� ����� ���������
begin
  //******************** ������������� �������� �������� **************************************
  with pb1.Canvas do
    begin
      Pen.Width := 1;
      Pen.Color := clBlue;
      Pen.Style := psSolid;
      Rectangle(RayWidth, 0, pb1.Width - RayWidth, pb1.Height);
      Pen.Color := clBlack;
    end;

  if DeviceName <> '' then
  begin
     w := pb1.Canvas.TextWidth(DeviceName) +2;
     X := pb1.Width div 2 - W div 2;
     pb1.Canvas.TextOut(X,5,DeviceName);
  end;

  if (LS = nil) or (RS =nil) then
  else
    begin
      differnceHeight := differenceColodka(LS);
      buildingColodka(differnceHeight, LS);
      differnceHeight := differenceColodka(RS);
      buildingColodka(differnceHeight, RS);
      jumpPosition(changeDecToString(JA.Number));
    end;
end;

{ TContact }

constructor TContact.Create(const asCont, asDesc: String);
begin
  Contact := asCont;
  Description := asDesc;
end;

{ TColodka }

constructor TColodka.Create(const asName: String);
begin
 Name := asName;
 Contacts := TObjectList.Create (True);
end;

{ TJumpAddress }

constructor TJumpAddress.Create(const jumNumber, jumJumpersType : Integer);
begin
  Number := jumNumber;
  JumpersType := jumJumpersType;
end;

{ TPictureBitmap }
{
constructor TPictureBitmap.Create(const FileName : string);
begin
end; }

destructor TColodka.Destroy;
begin
  Contacts.Free;
  inherited;
end;

//********************************* ������� ******************************************************************
function TfrmMain.differenceColodka(LObject : TObjectList): integer;
  const
    heightContact = 15; // ������ ������ +2 �������
    widthContact  = 20; // ������ 3 �������� +2 �������
  var
    countColodka, countContact, HeightWind : Integer;
    i : Integer;
  begin
     HeightWind := pb1.Height;
     countColodka := LObject.Count;
     countContact := 0;
     i := 0;
        while i <= countColodka - 1 do
          begin
            countContact := countContact + TColodka (LObject.Items[i]).Contacts.Count;
            Inc(i);
          end;
  Result := Round(((HeightWind - heightContact * countContact)/(countColodka +1)));
  end;


//****************************** ������� ��������� � �������� ������ **************************

function TfrmMain.DrawTextCentered(Canvas: TCanvas; const R: TRect;
  S: String): Integer;
var
  DrawRect: TRect;
  DrawFlags: Cardinal;
  DrawParams: TDrawTextParams;
begin
  DrawRect := R;
  DrawFlags := DT_END_ELLIPSIS or DT_NOPREFIX or DT_WORDBREAK or
    DT_EDITCONTROL or DT_CENTER;
  DrawText(Canvas.Handle, PChar(S), -1, DrawRect, DrawFlags or DT_CALCRECT);
  DrawRect.Right := R.Right;
  if DrawRect.Bottom < R.Bottom then
    OffsetRect(DrawRect, 0, (R.Bottom - DrawRect.Bottom) div 2)
  else
    DrawRect.Bottom := R.Bottom;
  ZeroMemory(@DrawParams, SizeOf(DrawParams));
  DrawParams.cbSize := SizeOf(DrawParams);
  DrawTextEx(Canvas.Handle, PChar(S), -1, DrawRect, DrawFlags, @DrawParams);
  Result := DrawParams.uiLengthDrawn;
end;

//********************************* ��������� *************************************************
 procedure TfrmMain.buildingColodka(const diffCol : Integer;LOject : TObjectList);
  const
   heightContact = 15; // ������ ������ +2 �������
   widthContact  = 25; // ������ 3 �������� +2 �������
 var
  HeightWind : Integer;
  yIndexBeginColodka, yIndexEndColodka : Integer;
  countColodka : Integer;
  yIndex : Integer;
  differnceHeight : Integer;
  i, j, k : Integer;
  R : TRect;
  Text : string;
 begin
    HeightWind := pb1.Height;
   differnceHeight := diffCol;

   with pb1.Canvas do
     begin
       Pen.Color := clBlack;
       Pen.Style := psSolid;
     end;

   countColodka := LOject.Count;     // ���������� ������� (LS, RS)
   i := 0;
   yIndex := differnceHeight;        // ��������� ������ � ����������� �� ���������� �������
   while i <= countColodka -1 do
     begin
       k := TColodka (LOject.Items[i]).Contacts.Count -1;
       yIndexBeginColodka := yIndex;
       for j := 0 to k do
         begin
           if LOject = LS then
             begin
               pb1.Canvas.Rectangle(RayWidth, yIndex, RayWidth + widthContact, yIndex + heightContact);
// ������ �������
               if TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact = '$' then  // ��� �������
                 pb1.Canvas.TextOut( RayWidth + 5, yIndex + 1 ,   #9178)                     // ************
               else
                 pb1.Canvas.TextOut( RayWidth + 5, yIndex + 1 , TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact);
               Text := TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Description;
               if not(Text = '') then
                  rayPaint(yIndex, Text, LOject);

               yIndex := yIndex + heightContact;  // ���������� �� ������ ��������
             end
           else
             begin
               pb1.Canvas.Rectangle(pb1.Width - RayWidth - widthContact, yIndex, pb1.Width - RayWidth, yIndex + heightContact);
// ������ �������
               if TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact = '$' then    // ��� �������
                pb1.Canvas.TextOut(pb1.Width - RayWidth - widthContact + 3, yIndex + 1 ,   #9178)             // ***********
               else
                 pb1.Canvas.TextOut(pb1.Width - RayWidth - widthContact + 3, yIndex + 1 , TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact);
               Text := TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Description;
               if not(Text = '') then
                  rayPaint(yIndex, Text, LOject);

               yIndex := yIndex + heightContact;   // ���������� �� ������ ��������
             end;
         end;
      yIndexEndColodka := yIndex;
      if LOject = LS then
        begin
          R := TRect.Create(RayWidth + widthContact, yIndexBeginColodka, RayWidth + widthContact + 90, yIndexEndColodka);
          pb1.Canvas.Rectangle(R);
          DrawTextCentered(pb1.Canvas, R, TColodka(LOject.Items[i]).Name);
          yIndex := yIndexEndColodka + differnceHeight;
        end
      else
        begin
          R := TRect.Create( pb1.Width - RayWidth - 100, yIndexBeginColodka,pb1.Width - RayWidth - widthContact , yIndexEndColodka);
          pb1.Canvas.Rectangle(R);
          DrawTextCentered(pb1.Canvas, R, TColodka(LOject.Items[i]).Name);
          yIndex := yIndexEndColodka + differnceHeight;
        end;
      Inc(i);
     end;
 end;

// ************************** ��������� ���������� ����� ***********************************
 procedure TfrmMain.rayPaint(const diffCol : Integer; const Text : string; LOject : TObjectList);
 const
   StepColodka = 7;
 var
 yIndex : Integer;
 i : Integer;
 fText : string;
 begin
  fText := Text;
  yIndex := diffCol;
  if LOject = LS then
    begin
      pb1.Canvas.MoveTo(0, yIndex + StepColodka);
      pb1.Canvas.LineTo(RayWidth, yIndex + StepColodka);
      pb1.Canvas.TextOut( 2, yIndex - StepColodka +1, Text);
    end
  else
    begin
      pb1.Canvas.MoveTo(pb1.Width - RayWidth, yIndex + StepColodka);
      pb1.Canvas.LineTo(pb1.Width, yIndex + StepColodka);
      pb1.Canvas.TextOut( pb1.Width - RayWidth + 4, yIndex - StepColodka +1, Text);
    end;
 end;
// ***************************************************************************************

// ***************************************  ���������� jumpPosition  *********************
procedure TfrmMain.jumpPosition (jumPos : string);
const
  dRec = 10;          // ���������� ��� ��������������
  dEll = 6;           // ���������� ��� �������
var
  XbeginText : Integer;
  StartXRec  : Integer;
  StartXEll  : Integer;
  StartYUp   : Integer;
  StartYDown : Integer;
  StartYEll  : Integer;

  stepRecAndEllipse : Integer; // ����� ���������� �� X
  stepEll : Integer;           // ����� ���������� ��� ���������� ������ �� ����/��� ��������
  i, j: Integer;           // ���������� ������
 begin
   StartXRec   := pb1.Width - 320;   // ���������� �� X ������ ��������������
   StartXEll   := pb1.Width - 318;   // ���������� �� X ������ �������
 // �������� �� ������ ��������, ����� ������ � ���� ����������� ���-�� �� ����������?
//   StartYUp    := pb1.Height - 576;  // ���������� �� Y ������ �������������� �_=1
//   StartYDown  := pb1.Height - 566 ; // ���������� �� Y ������ �������������� �_=0
//   StartYEll   := pb1.Height - 574 ; // ���������� �� Y ������ �������

   StartYUp    := 24;  // ���������� �� Y ������ �������������� �_=1
   StartYDown  := 34 ; // ���������� �� Y ������ �������������� �_=0
   StartYEll   := 26 ; // ���������� �� Y ������ �������

   XbeginText := pb1.Width - 322;  // ������ ������
   stepRecAndEllipse := 0; // ����� ���������� �� X
   if ja.JumpersType = 3 then
// ����� ��������� ��������� (��� ���� ����������)
     begin
       for I :=0 to Length(JA.Description) - 1 do
         begin
           if jumPos[i + 1] = '1'  then     // ��� �_=1
              pb1.Canvas.Rectangle(StartXRec + stepRecAndEllipse, StartYUp,
                                    StartXRec + dRec + stepRecAndEllipse, StartYUp + dRec *2)
           else                                   // ��� �_=0
              pb1.Canvas.Rectangle(StartXRec + stepRecAndEllipse, StartYDown,
                                    StartXRec + dRec + stepRecAndEllipse, StartYDown + dRec *2);
         pb1.Canvas.Brush.Color := clBlack;
         stepEll := 0;
         for j := 0 to 2 do            // ������ ��� ���� ����������
           begin
             pb1.Canvas.Ellipse(StartXEll + stepRecAndEllipse, StartYEll + stepEll,
                                StartXEll + dEll + stepRecAndEllipse, StartYEll + dEll + stepEll);
             stepEll := stepEll + 10;
           end;
         pb1.Canvas.Brush.Style := bsClear;
         pb1.Canvas.TextOut(XbeginText + stepRecAndEllipse,53, JA.Description[i]);
         stepRecAndEllipse := stepRecAndEllipse + 20;
         end;
     end
   else
// ����� ��������� ��������� (��� ���� ����������)
     begin
      for I :=0 to Length(JA.Description) -1 do
         begin
           if jumPos[i + 1] = '1'  then     // ��� �_=1
           else                                   // ��� �_=0
              pb1.Canvas.Rectangle(StartXRec + stepRecAndEllipse, StartYUp,
                                   StartXRec +dRec + stepRecAndEllipse, StartYUp + dRec *2);
         pb1.Canvas.Brush.Color := clBlack;
         stepEll := 0;
         for j := 0 to 1 do            // ������ ��� ���� ����������
           begin
             pb1.Canvas.Ellipse(StartXEll + stepRecAndEllipse, StartYEll + stepEll,
                                StartXEll + dEll + stepRecAndEllipse, StartYEll + dEll + stepEll);
             stepEll := stepEll + 10;
           end;
         pb1.Canvas.Brush.Style := bsClear;
         pb1.Canvas.TextOut(XbeginText + stepRecAndEllipse,48, JA.Description[i]);
         stepRecAndEllipse := stepRecAndEllipse + 20;

         end;
     end;
 end;

//**************** ������ � ������� ������ � ���� *********************************************
procedure TfrmMain.btnSaveClick(Sender: TObject);
begin
  frmMainToBitmap(pb1,PBitmap);
  PBitmap.SaveToFile('picture.bmp');
end;

//*********************************************************************************************

//**************************** ������� � Bitmap ***********************************************

procedure TfrmMain.frmMainToBitmap(pb1 : TPaintBox; var PBitmap : TPictureBitmap);
var
  fFile : string;
  r : TRect;
begin
// ����� ������������� �������
  r.Left := 0;
  r.Right := pb1.Width;
  r.Top := 0;
  r.Bottom := pb1.Height;
// ������ Bitmap
  PBitmap := TPictureBitmap.Create;
  PBitmap.Width := pb1.Width;
  PBitmap.Height := pb1.Height;
// �������� �������� �� ����� � Bitmap
  PBitmap.Canvas.CopyRect(r,pb1.Canvas,r);
end;
//*********************************************************************************************
end.

