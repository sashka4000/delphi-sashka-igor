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
// ************* �������� ����������


  end;

  TfrmMain = class(TForm)
    pb1: TPaintBox;
    lbl1: TLabel;
    btnTest1: TButton;
    procedure pb1Paint(Sender: TObject);
    procedure btnTest1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    DeviceName : String;    // ��� ����������
    LS, RS  : TObjectList; //  ��������� �������� TColodka ��� ����� � ������ ������ ����������
    JA : TJumpAddress;
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
    SetLength(vArray,5);
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
      Rectangle(100, 0, 450, pb1.Height);
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
{//****************************************************************************************
//******************************* ��� ���������� *****************************************

  k := 0;
  for I := 0 to 4 do
   begin
     pb1.Canvas.Rectangle(230 +k, 34, 240 +k, 54);
     pb1.Canvas.Brush.Color := clBlack;
     pb1.Canvas.Ellipse(232 +k,26,238 +k,32);
     pb1.Canvas.Ellipse(232+k,36,238+k,42);
     pb1.Canvas.Ellipse(232+k,46,238+k,52);
     pb1.Canvas.Brush.Style := bsClear;
//     pb1.Canvas.TextOut(228 + k, 53, 'A' + IntToStr(i + 1));
     pb1.Canvas.TextOut(228 + k, 53, JA.Description[i]);
     k := k + 20;

   end;
//****************************************************************************************

}
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
    widthWind = 450;
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
   XBeginIndexContactLS = 100;  // ��������� ���������� �������� LS
   XEndIndexContactLS = 125;    // ��������  ���������� �������� LS
   XBeginIndexContactRS = 425;  // ��������� ���������� �������� RS
   XEndIndexContactRS = 450;    // ��������  ���������� �������� RS
   heightContact = 15; // ������ ������ +2 �������
   widthContact  = 25; // ������ 3 �������� +2 �������
   widthWind = 450;
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
               pb1.Canvas.Rectangle(XBeginIndexContactLS, yIndex, XEndIndexContactLS, yIndex + heightContact);
// ������ �������
               if TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact = '$' then  // ��� �������
                 pb1.Canvas.TextOut( XBeginIndexContactLS + 5, yIndex + 1 ,   #9178)         // ************
               else
                 pb1.Canvas.TextOut( XBeginIndexContactLS + 5, yIndex + 1 , TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact);
               Text := TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Description;
               if not(Text = '') then
                  rayPaint(yIndex, Text, LOject);

               yIndex := yIndex + heightContact;  // ���������� �� ������ ��������
             end
           else
             begin
               pb1.Canvas.Rectangle(XBeginIndexContactRS, yIndex, XEndIndexContactRS, yIndex + heightContact);
// ������ �������
               if TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact = '$' then    // ��� �������
                pb1.Canvas.TextOut(XBeginIndexContactRS + 3, yIndex + 1 ,   #9178)             // ***********
               else
                 pb1.Canvas.TextOut(XBeginIndexContactRS + 3, yIndex + 1 , TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact);
               Text := TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Description;
               if not(Text = '') then
                  rayPaint(yIndex, Text, LOject);

               yIndex := yIndex + heightContact;   // ���������� �� ������ ��������
             end;
         end;
      yIndexEndColodka := yIndex;
      if LOject = LS then
        begin
          R := TRect.Create(XEndIndexContactLS, yIndexBeginColodka, XEndIndexContactLS +90, yIndexEndColodka);
          pb1.Canvas.Rectangle(R);
          DrawTextCentered(pb1.Canvas, R, TColodka(LOject.Items[i]).Name);
          yIndex := yIndexEndColodka + differnceHeight;
        end
      else
        begin
          R := TRect.Create( XEndIndexContactRS - 100, yIndexBeginColodka,XBeginIndexContactRS , yIndexEndColodka);
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
   XindexbeginLS = 0;
   XindexendLS = 100;
   XindexbeginRS = 450;
   XindexendRS = 550;
 var
 yIndex : Integer;
 i : Integer;
 fText : string;
 begin
  fText := Text;
  yIndex := diffCol;
  if LOject = LS then
    begin
      pb1.Canvas.MoveTo(XindexbeginLS, yIndex + StepColodka);
      pb1.Canvas.LineTo(XindexendLS, yIndex + StepColodka);
      pb1.Canvas.TextOut( XindexbeginLS + 2, yIndex - StepColodka +1, Text);
    end
  else
    begin
      pb1.Canvas.MoveTo(XindexbeginRS, yIndex + StepColodka);
      pb1.Canvas.LineTo(XindexendRS, yIndex + StepColodka);
      pb1.Canvas.TextOut( XindexbeginRS + 4, yIndex - StepColodka +1, Text);
    end;



 end;

// ***************************************************************************************

// ***************************************  ���������� jumpPosition  *********************
procedure TfrmMain.jumpPosition (jumPos : string);
const
  XrecBeginThree = 230;     // ���������� �� � ������ ��������������
  XrecEndThree = 240;       // ���������� �� � ����� ��������������
  XellBeginThree =232;      // ���������� �� � ������ �������
  XellEndThree =238;        // ���������� �� � ����� �������
  YellBeginThree = 26;      // ���������� �� Y ������ �������
  YellEndThree = 32;        // ���������� �� Y ����� �������
  YrecBeginThreeUp = 24;    // ���������� �� Y ������ ��������������    �_=1
  YrecBeginThreeDown = 34;  // ���������� �� Y ������ ��������������    �_=0
  YrecEndThreeUp = 44;      // ���������� �� Y ����� ��������������      �_=1
  YrecEndThreeDown = 54;    // ���������� �� Y ����� ��������������      �_=0
  XbeginText = 228;         // ������ ������

var
  stepRecAndEllipse : Integer; // ����� ���������� �� X
  stepEll : Integer;           // ����� ���������� ��� ���������� ������ �� ����/��� ��������
  i, j: Integer;           // ���������� ������
  Position: string;           // ������ ��������� ���������
 begin
   stepRecAndEllipse := 0; // ����� ���������� �� X
   Position := jumPos;
   if ja.JumpersType = 3 then
// ����� ��������� ��������� (��� ���� ����������)
     begin
       for I :=0 to 4 do
         begin
           if Position[i + 1] = '1'  then     // ��� �_=1
              pb1.Canvas.Rectangle(XrecBeginThree + stepRecAndEllipse, YrecBeginThreeUp,
                                    XrecEndThree + stepRecAndEllipse, YrecEndThreeUp)
           else                                   // ��� �_=0
              pb1.Canvas.Rectangle(XrecBeginThree + stepRecAndEllipse, YrecBeginThreeDown,
                                    XrecEndThree + stepRecAndEllipse, YrecEndThreeDown);
         pb1.Canvas.Brush.Color := clBlack;
         stepEll := 0;
         for j := 0 to 2 do            // ������ ��� ���� ����������
           begin
             pb1.Canvas.Ellipse(XellBeginThree + stepRecAndEllipse, YellBeginThree + stepEll,
                                XellEndThree + stepRecAndEllipse, YellEndThree + stepEll  );
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
      for I :=0 to 4 do
         begin
           if Position[i + 1] = '1'  then     // ��� �_=1
           else                                   // ��� �_=0
              pb1.Canvas.Rectangle(XrecBeginThree + stepRecAndEllipse, YrecBeginThreeUp,
                                    XrecEndThree + stepRecAndEllipse, YrecEndThreeUp);
         pb1.Canvas.Brush.Color := clBlack;
         stepEll := 0;
         for j := 0 to 1 do            // ������ ��� ���� ����������
           begin
             pb1.Canvas.Ellipse(XellBeginThree + stepRecAndEllipse, YellBeginThree + stepEll,
                                XellEndThree + stepRecAndEllipse, YellEndThree + stepEll  );
             stepEll := stepEll + 10;
           end;
         pb1.Canvas.Brush.Style := bsClear;
         pb1.Canvas.TextOut(XbeginText + stepRecAndEllipse,48, JA.Description[i]);
         stepRecAndEllipse := stepRecAndEllipse + 20;

         end;
     end;
 end;
end.