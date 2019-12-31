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
    // название контакта отображается внутри прямоугольника
    // если название = $  - надо отрисовать символ заземление
     Contact : String;
    // подпись, если <> '' то рисуется линия и делается подпись
     Description : String;
     constructor Create (const asCont, asDesc : String);
  end;

  TColodka = class  // Коллекция объектов TContact   - набор контактов
   private
    Name : String;  // название группы контактов отображаемое внутри прямоугольника
    Contacts : TObjectList;
    constructor Create (const asName :String);
    // Деструктор нужен, чтобы вызвать Contacts.Free
    destructor Destroy; override;
  end;

  TJumpAddress = class    // Адрес выставленный перемычками
   public
    Number : Integer;   // нужный номер
    Description : TDescription; // содержит число перемычке и подписи под ними
    JumpersType : Integer; // 2 - двух контактные, 3 - трех контактные
    constructor Create (const jumNumber, jumJumpersType : Integer);
  end;

  TPictureBitmap = class (TBitmap)
    public
    FileName : string;
  end;

  TfrmMain = class(TForm)
    pb1: TPaintBox;
    lbl1: TLabel;
    btnTest1: TButton;
    btnSave: TButton;
    btnSaveToWord: TButton;
    procedure pb1Paint(Sender: TObject);
    procedure btnTest1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frmMainToBitmap(pb1 : TPaintBox; var PBitmap : TPictureBitmap);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveToWordClick(Sender: TObject);
  private
    { Private declarations }
    DeviceName : String;    // Имя устройства
    LS, RS  : TObjectList; //  Коллекция объектов TColodka для Левой и Правой сторон устройства
    JA : TJumpAddress;
    PBitmap : TPictureBitmap;
    function differenceColodka(LObject : TObjectList): integer;
    function changeDecToString(const Value : Integer): string;
   	procedure buildingColodka(const diffCol : Integer;LOject : TObjectList);
    procedure rayPaint(const diffCol : Integer; const Text : string; LOject : TObjectList);
    procedure jumpPosition (jumPos : string);
    // Нашел красивую функцию отрисовки Текста
    function DrawTextCentered(Canvas: TCanvas; const R: TRect; S: String): Integer;
  public
    { Public declarations }
  end;

const
RayWidthLeft  = 180;    // Луч
RayWidthRigth  = 60;    // Луч
DeltaY    = 100;
DeltaYJmp = 15;

var
  frmMain: TfrmMain;
implementation
Uses System.Win.ComObj;

{$R *.dfm}

procedure TfrmMain.btnTest1Click(Sender: TObject);
var
 C : TColodka;
begin
  // Освобождаю то что раньше было
  LS.Free;
  RS.Free;
  JA.Free;
  // Создаю новый набор
  DeviceName := 'КУН-2Д.1';

  // Левая сторона

  JA := TJumpAddress.Create(0,0);

  SetLength(JA.Description,5);
  JA.Description[0] := 'A1';
  JA.Description[1] := 'A2';
  JA.Description[2] := 'A3';
  JA.Description[3] := 'A4';
  JA.Description[4] := 'A5';

  JA.Number := 2;
  JA.JumpersType := 3;


  LS := TObjectList.Create (true);
  C := TColodka.Create('Входы кнопок ПГУ');
  C.Contacts.Add(TContact.Create('K1',''));
  C.Contacts.Add(TContact.Create('K2','Подъезд 23123132'));
  C.Contacts.Add(TContact.Create('K3','Подъезд2 2323'));
  C.Contacts.Add(TContact.Create('K4',''));
  C.Contacts.Add(TContact.Create('K5',''));
  LS.Add(C);

  C := TColodka.Create('Входы динамиков ПГУ');
  C.Contacts.Add(TContact.Create('Г1',''));
  C.Contacts.Add(TContact.Create('Г2','Подъезд'));
  C.Contacts.Add(TContact.Create('Г3','Подъезд2'));
  C.Contacts.Add(TContact.Create('Г4',''));
  LS.Add(C);
 //*******************************************
  C := TColodka.Create('Входы микрофонов ПГУ4');
  C.Contacts.Add(TContact.Create('М1',''));
  C.Contacts.Add(TContact.Create('М2','Подъезд'));
  C.Contacts.Add(TContact.Create('М3','Подъезд2'));
  C.Contacts.Add(TContact.Create('М4',''));
  LS.Add(C);

  C := TColodka.Create('Входы кнопок ПГУ');
  C.Contacts.Add(TContact.Create('K1',''));
  C.Contacts.Add(TContact.Create('K2','Подъезд'));
  C.Contacts.Add(TContact.Create('K3','Подъезд2'));
  C.Contacts.Add(TContact.Create('K4',''));
  C.Contacts.Add(TContact.Create('$',''));
  C.Contacts.Add(TContact.Create('&',''));
  LS.Add(C);
//**********************************************
  RS := TObjectList.Create (true);
  C := TColodka.Create('Линия связи 2 (ПС)');
  C.Contacts.Add(TContact.Create('1','Тест2322323 23123'));
  C.Contacts.Add(TContact.Create('1','Тест2322323 23123'));
  C.Contacts.Add(TContact.Create('1','Тест2322323 23123'));
  RS.Add(C);

  // Вызываем перерисовку Доски

  pb1.Repaint;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  DeviceName := 'Empty List';
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  LS.Free;
  RS.Free;
  JA.Free;
end;

//************************** Реализация функции changeDecToString *********************************
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
      ShowMessage('Ошибка адреса диапозона');
  end;
//****************************************************************************************

procedure TfrmMain.pb1Paint(Sender: TObject);
var
  X, W : Integer;
 differnceHeight : Integer;  // шаг между колодками
begin
  //******************** Прорисовываем основную подложку **************************************
  pb1.Canvas.Brush.Color := clWhite;
    pb1.Canvas.FillRect( pb1.Canvas.ClipRect);
  with pb1.Canvas do
    begin
      Pen.Width := 1;
      Pen.Color := clBlue;
      Pen.Style := psSolid;
      Rectangle(RayWidthLeft, DeltaY, pb1.Width - RayWidthRigth, pb1.Height);
      Pen.Color := clBlack;
    end;

  if DeviceName <> '' then
  begin
    pb1.Canvas.Font.Style := [fsBold];
    pb1.Canvas.TextOut(20,5,DeviceName + 'номер: 202');
    pb1.Canvas.TextOut(20,25,'Положение перемычке Адреса:');
    pb1.Canvas.Font.Style := [];
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


destructor TColodka.Destroy;
begin
  Contacts.Free;
  inherited;
end;

//********************************* Функция ******************************************************************
function TfrmMain.differenceColodka(LObject : TObjectList): integer;
  const
    heightContact = 15; // высота шрифта +2 пиксела
    widthContact  = 20; // ширина 3 символов +2 пиксела
  var
    countColodka, countContact, HeightWind : Integer;
    i : Integer;
  begin
     HeightWind := pb1.Height - DeltaY;
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


//****************************** Функция отрисовки и цетровки текста **************************

function TfrmMain.DrawTextCentered(Canvas: TCanvas; const R: TRect;
  S: String): Integer;
var
  DrawRect: TRect;
  DrawFlags: Cardinal;
  DrawParams: TDrawTextParams;
begin
  DrawRect := R;
  DrawRect.Inflate(-1,0);
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

//********************************* Процедура *************************************************
 procedure TfrmMain.buildingColodka(const diffCol : Integer;LOject : TObjectList);
  const
   heightContact = 15; // высота шрифта +2 пиксела
   widthContact  = 25; // ширина 3 символов +2 пиксела
 var
  yIndexBeginColodka, yIndexEndColodka : Integer;
  countColodka : Integer;
  yIndex : Integer;
  differnceHeight : Integer;
  i, j, k : Integer;
  R : TRect;
  Text : string;
 begin
   differnceHeight := diffCol;

   with pb1.Canvas do
     begin
       Pen.Color := clBlack;
       Pen.Style := psSolid;
     end;

   countColodka := LOject.Count;     // Количество колодок (LS, RS)
   i := 0;
   yIndex := differnceHeight + DeltaY;        // Начальный отступ в зависимости от количества колодок
   while i <= countColodka -1 do
     begin
       k := TColodka (LOject.Items[i]).Contacts.Count -1;
       yIndexBeginColodka := yIndex;
       for j := 0 to k do
         begin
           if LOject = LS then
             begin
               pb1.Canvas.Rectangle(RayWidthLeft, yIndex, RayWidthLeft + widthContact, yIndex + heightContact);
               if TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact = '$' then  // Код подмены
                 pb1.Canvas.TextOut( RayWidthLeft + 5, yIndex + 1 ,   #9178)
                else
                 if TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact = '&' then  // Код подмены
                    pb1.Canvas.TextOut( RayWidthLeft + 5, yIndex + 1 ,   #8869)
                   else
                     pb1.Canvas.TextOut( RayWidthLeft + 5, yIndex + 1 , TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact);
               Text := TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Description;
               if not(Text = '') then
                  rayPaint(yIndex, Text, LOject);

               yIndex := yIndex + heightContact;  // Приращение на высоту контакта
             end
           else
             begin
               pb1.Canvas.Rectangle(pb1.Width - RayWidthRigth - widthContact, yIndex, pb1.Width - RayWidthRigth, yIndex + heightContact);
               if TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact = '$' then    // Код подмены
                pb1.Canvas.TextOut(pb1.Width - RayWidthRigth - widthContact + 3, yIndex + 1 ,   #9178)             // ***********
               else
                 pb1.Canvas.TextOut(pb1.Width - RayWidthRigth - widthContact + 3, yIndex + 1 , TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact);
               Text := TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Description;
               if not(Text = '') then
                  rayPaint(yIndex, Text, LOject);

               yIndex := yIndex + heightContact;   // Приращение на высоту контакта
             end;
         end;
      yIndexEndColodka := yIndex;
      if LOject = LS then
        begin
          R := TRect.Create(RayWidthLeft + widthContact, yIndexBeginColodka, RayWidthLeft + widthContact + 90, yIndexEndColodka);
          pb1.Canvas.Rectangle(R);
          DrawTextCentered(pb1.Canvas, R, TColodka(LOject.Items[i]).Name);
          yIndex := yIndexEndColodka + differnceHeight;
        end
      else
        begin
          R := TRect.Create( pb1.Width - RayWidthRigth - 100, yIndexBeginColodka,pb1.Width - RayWidthRigth - widthContact , yIndexEndColodka);
          pb1.Canvas.Rectangle(R);
          DrawTextCentered(pb1.Canvas, R, TColodka(LOject.Items[i]).Name);
          yIndex := yIndexEndColodka + differnceHeight;
        end;
      Inc(i);
     end;
 end;

// ************************** Процедура прорисовки лучей ***********************************
 procedure TfrmMain.rayPaint(const diffCol : Integer; const Text : string; LOject : TObjectList);
 const
   StepColodka = 7;
 var
 yIndex : Integer;
 i : Integer;
 fText : string;
 R : TRect;
 begin
  fText := Text;
  yIndex := diffCol;
  if LOject = LS then
    begin
      pb1.Canvas.MoveTo(0, yIndex + StepColodka);
      pb1.Canvas.LineTo(RayWidthLeft, yIndex + StepColodka);
      R.Create(0, yIndex - StepColodka +1, RayWidthLeft, yIndex + StepColodka);
      DrawTextCentered (pb1.Canvas,R,Text);
      // pb1.Canvas.TextOut( 2, yIndex - StepColodka +1, Text);
    end
  else
    begin
      pb1.Canvas.MoveTo(pb1.Width - RayWidthRigth, yIndex + StepColodka);
      pb1.Canvas.LineTo(pb1.Width, yIndex + StepColodka);
      R.Create(pb1.Width - RayWidthRigth + 4, yIndex - StepColodka +1, pb1.Width, yIndex + StepColodka);
      DrawTextCentered (pb1.Canvas,R,Text);
     // pb1.Canvas.TextOut( pb1.Width - RayWidth + 4, yIndex - StepColodka +1, Text);
    end;
 end;
// ***************************************************************************************

// ***************************************  Реализация jumpPosition  *********************
procedure TfrmMain.jumpPosition (jumPos : string);
const
  dRec = 10;          // Приращение для прямоугольника
  dEll = 6;           // Приращение для эллипса
var
  XbeginText : Integer;
  StartXRec  : Integer;
  StartXEll  : Integer;
  StartYUp   : Integer;
  StartYDown : Integer;
  StartYEll  : Integer;
  stepRecAndEllipse : Integer; // общее приращение по X
  stepEll : Integer;           // общее приращение для построения группы из двух/трёх эллипсов
  i, j: Integer;           // Переменные циклов
 begin
   StartXRec   :=  pb1.Width - RayWidthLeft div 2 -  pb1.Width div 2;   // Координаты по X начало прямоугольника
   StartXEll   := pb1.Width -  RayWidthLeft div 2 - pb1.Width div 2 + 2;   // Координаты по X начало эллипса
   // Координаты по Y
   StartYUp    := 24 - DeltaYJmp;  // Координаты по Y начало прямоугольника А_=1
   StartYDown  := 34 - DeltaYJmp ; // Координаты по Y начало прямоугольника А_=0
   StartYEll   := 26 - DeltaYJmp ; // Координаты по Y начало эллипса

   XbeginText := pb1.Width -  RayWidthLeft div 2 - pb1.Width div 2;  // Начало текста
   stepRecAndEllipse := 0; // общее приращение по X
   if ja.JumpersType = 3 then
// выбор количесво джамперов (для трех контактных)
     begin
       for I :=0 to Length(JA.Description) - 1 do
         begin
           if jumPos[i + 1] = '1'  then     // для А_=1
              pb1.Canvas.Rectangle(StartXRec + stepRecAndEllipse, StartYUp,
                                    StartXRec + dRec + stepRecAndEllipse, StartYUp + dRec *2)
           else                                   // для А_=0
              pb1.Canvas.Rectangle(StartXRec + stepRecAndEllipse, StartYDown,
                                    StartXRec + dRec + stepRecAndEllipse, StartYDown + dRec *2);
         pb1.Canvas.Brush.Color := clBlack;
         stepEll := 0;
         for j := 0 to 2 do            // Рисуем для трех контактных
           begin
             pb1.Canvas.Ellipse(StartXEll + stepRecAndEllipse, StartYEll + stepEll,
                                StartXEll + dEll + stepRecAndEllipse, StartYEll + dEll + stepEll);
             stepEll := stepEll + 10;
           end;
         pb1.Canvas.Brush.Style := bsClear;
         pb1.Canvas.TextOut(XbeginText + stepRecAndEllipse,55- DeltaYJmp, JA.Description[i]);
         stepRecAndEllipse := stepRecAndEllipse + 20;
         end;
     end
   else
// выбор количесво джамперов (для двух контактных)
     begin
      for I :=0 to Length(JA.Description) -1 do
         begin
           if jumPos[i + 1] = '1'  then     // для А_=1
           else                                   // для А_=0
              pb1.Canvas.Rectangle(StartXRec + stepRecAndEllipse, StartYUp,
                                   StartXRec +dRec + stepRecAndEllipse, StartYUp + dRec *2);
         pb1.Canvas.Brush.Color := clBlack;
         stepEll := 0;
         for j := 0 to 1 do            // Рисуем для двух контактных
           begin
             pb1.Canvas.Ellipse(StartXEll + stepRecAndEllipse, StartYEll + stepEll,
                                StartXEll + dEll + stepRecAndEllipse, StartYEll + dEll + stepEll);
             stepEll := stepEll + 10;
           end;
         pb1.Canvas.Brush.Style := bsClear;
         pb1.Canvas.TextOut(XbeginText + stepRecAndEllipse,48 - DeltaYJmp, JA.Description[i]);
         stepRecAndEllipse := stepRecAndEllipse + 20;

         end;
     end;
 end;

//**************** Запись в файл MS Word    ***************************************************
procedure TfrmMain.btnSaveToWordClick(Sender: TObject);
const
  wdAlignParagraphCenter = 1;
  wdAlignParagraphLeft = 0;
  wdAlignParagraphRight = 2;
var
 wd : Variant;
 s  : Variant;
 fname : String;
begin
 fname := ExtractFilePath(Application.ExeName) + 'picture.bmp';
 if not FileExists(fname) then
  Exit;

//
 wd:= CreateOleObject('Word.Application');
 wd.Documents.Add;
 wd.ActiveDocument.Select;
 wd.Selection.Copy;
 wd.Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
 wd.Selection.Font.Bold := True;
 wd.Selection.TypeText('TEST PICTURE');
 wd.Selection.TypeParagraph;
 wd.Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
 // Вставим изображение
 wd.Selection.InlineShapes.AddPicture(fname, True, True);
 wd.ActiveDocument.SaveAs (ExtractFilePath(Application.ExeName) + 'test.doc');
 wd.Quit;
 wd := Unassigned;
end;
// **************************Запись в файл  .bmp   *************************************
procedure TfrmMain.btnSaveClick(Sender: TObject);
begin
  frmMainToBitmap(pb1,PBitmap);
  PBitmap.SaveToFile('picture.bmp');
  PBitmap.Free;
end;

//*********************************************************************************************

//**************************** Создаем экзепляр класса Bitmap ***********************************************

procedure TfrmMain.frmMainToBitmap(pb1 : TPaintBox; var PBitmap : TPictureBitmap);
var
  fFile : string;
  r : TRect;
begin
// Задаём прямоугольную область
  r.Left := 0;
  r.Right := pb1.Width;
  r.Top := 0;
  r.Bottom := pb1.Height;

// Создаём Bitmap
  PBitmap := TPictureBitmap.Create;
  PBitmap.Width := pb1.Width;
  PBitmap.Height := pb1.Height;
// Копируем картинку из формы в Bitmap
  PBitmap.Canvas.CopyRect(r,pb1.Canvas,r);
end;
//*********************************************************************************************
end.

