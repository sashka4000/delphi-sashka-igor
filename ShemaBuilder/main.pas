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
// ************* Добавляю переменные


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
    DeviceName : String;    // Имя устройства
    LS, RS  : TObjectList; //  Коллекция объектов TColodka для Левой и Правой сторон устройства
    JA : TJumpAddress;
    function differenceColodka(LObject : TObjectList): integer;
    function changeDecToString(const Value : Integer): string;
   	procedure buildingColodka(const diffCol : Integer;LOject : TObjectList);
    procedure rayPaint(const diffCol : Integer; const Text : string; LOject : TObjectList);
    procedure jumpPosition (jumPos : string);
    // Нашел красивую функцию отрисовки Текста
    function DrawTextCentered(Canvas: TCanvas; const R: TRect; S: String): Integer;
  public
    { Public declarations }
    // в этой процедуре должно происходить рисование
  end;

var
  frmMain: TfrmMain;
implementation

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

  JA.Number := 18;
  JA.JumpersType := 3;


  LS := TObjectList.Create (true);
  C := TColodka.Create('Входы кнопок ПГУ');
  C.Contacts.Add(TContact.Create('K1',''));
  C.Contacts.Add(TContact.Create('K2','Подъезд'));
  C.Contacts.Add(TContact.Create('K3','Подъезд2'));
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
  C := TColodka.Create('Входы динамиков ПГУ');
  C.Contacts.Add(TContact.Create('Г1',''));
  C.Contacts.Add(TContact.Create('Г2','Подъезд'));
  C.Contacts.Add(TContact.Create('Г3','Подъезд2'));
  C.Contacts.Add(TContact.Create('Г4',''));
  LS.Add(C);

  C := TColodka.Create('Входы кнопок ПГУ');
  C.Contacts.Add(TContact.Create('K1',''));
  C.Contacts.Add(TContact.Create('K2','Подъезд'));
  C.Contacts.Add(TContact.Create('K3','Подъезд2'));
  C.Contacts.Add(TContact.Create('K4',''));
  C.Contacts.Add(TContact.Create('$',''));
  LS.Add(C);
//**********************************************
  RS := TObjectList.Create (true);
  C := TColodka.Create('Тест');
  C.Contacts.Add(TContact.Create('1','Тест'));
  RS.Add(C);

  // Вызываем перерисовку Доски

  pb1.Repaint;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  DeviceName := 'Пустой лист';
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
      ShowMessage('Ошибка адреса диапозона');
  end;
//****************************************************************************************

procedure TfrmMain.pb1Paint(Sender: TObject);
var
  X, W : Integer;
 differnceHeight : Integer;  // шаг между колодками
begin
  //******************** Прорисовываем основную подложку **************************************
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
//******************************* Для тренировки *****************************************

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

//********************************* Функция ******************************************************************
function TfrmMain.differenceColodka(LObject : TObjectList): integer;
  const
    heightContact = 15; // высота шрифта +2 пиксела
    widthContact  = 20; // ширина 3 символов +2 пиксела
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


//****************************** Функция отрисовки и цетровки текста **************************

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

//********************************* Процедура *************************************************
 procedure TfrmMain.buildingColodka(const diffCol : Integer;LOject : TObjectList);
  const
   XBeginIndexContactLS = 100;  // Начальная координата контакта LS
   XEndIndexContactLS = 125;    // Конечная  координата контакта LS
   XBeginIndexContactRS = 425;  // Начальная координата контакта RS
   XEndIndexContactRS = 450;    // Конечная  координата контакта RS
   heightContact = 15; // высота шрифта +2 пиксела
   widthContact  = 25; // ширина 3 символов +2 пиксела
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

   countColodka := LOject.Count;     // Количество колодок (LS, RS)
   i := 0;
   yIndex := differnceHeight;        // Начальный отступ в зависимости от количества колодок
   while i <= countColodka -1 do
     begin
       k := TColodka (LOject.Items[i]).Contacts.Count -1;
       yIndexBeginColodka := yIndex;
       for j := 0 to k do
         begin
           if LOject = LS then
             begin
               pb1.Canvas.Rectangle(XBeginIndexContactLS, yIndex, XEndIndexContactLS, yIndex + heightContact);
// Пробую подмену
               if TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact = '$' then  // Код подмены
                 pb1.Canvas.TextOut( XBeginIndexContactLS + 5, yIndex + 1 ,   #9178)         // ************
               else
                 pb1.Canvas.TextOut( XBeginIndexContactLS + 5, yIndex + 1 , TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact);
               Text := TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Description;
               if not(Text = '') then
                  rayPaint(yIndex, Text, LOject);

               yIndex := yIndex + heightContact;  // Приращение на высоту контакта
             end
           else
             begin
               pb1.Canvas.Rectangle(XBeginIndexContactRS, yIndex, XEndIndexContactRS, yIndex + heightContact);
// Пробую подмену
               if TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact = '$' then    // Код подмены
                pb1.Canvas.TextOut(XBeginIndexContactRS + 3, yIndex + 1 ,   #9178)             // ***********
               else
                 pb1.Canvas.TextOut(XBeginIndexContactRS + 3, yIndex + 1 , TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Contact);
               Text := TContact( TColodka(LOject.Items[i]).Contacts.Items[j]).Description;
               if not(Text = '') then
                  rayPaint(yIndex, Text, LOject);

               yIndex := yIndex + heightContact;   // Приращение на высоту контакта
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

// ************************** Процедура прорисовки лучей ***********************************
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

// ***************************************  Реализация jumpPosition  *********************
procedure TfrmMain.jumpPosition (jumPos : string);
const
  XrecBeginThree = 230;     // Координата по Х начало прямоугольника
  XrecEndThree = 240;       // Координата по Х конец прямоугольника
  XellBeginThree =232;      // Координата по Х начало эллипса
  XellEndThree =238;        // Координата по Х конец эллипса
  YellBeginThree = 26;      // Координата по Y начало эллипса
  YellEndThree = 32;        // Координата по Y конец эллипса
  YrecBeginThreeUp = 24;    // Координата по Y начоло прямоугольника    А_=1
  YrecBeginThreeDown = 34;  // Координата по Y начоло прямоугольника    А_=0
  YrecEndThreeUp = 44;      // Координата по Y конец прямоугольника      А_=1
  YrecEndThreeDown = 54;    // Координата по Y конец прямоугольника      А_=0
  XbeginText = 228;         // Начало текста

var
  stepRecAndEllipse : Integer; // общее приращение по X
  stepEll : Integer;           // общее приращение для построения группы из двух/трёх эллипсов
  i, j: Integer;           // Переменные циклов
  Position: string;           // Строка положения перемычек
 begin
   stepRecAndEllipse := 0; // общее приращение по X
   Position := jumPos;
   if ja.JumpersType = 3 then
// выбор количесво джамперов (для трех контактных)
     begin
       for I :=0 to 4 do
         begin
           if Position[i + 1] = '1'  then     // для А_=1
              pb1.Canvas.Rectangle(XrecBeginThree + stepRecAndEllipse, YrecBeginThreeUp,// + stepRecAndEllipse,
                                    XrecEndThree + stepRecAndEllipse, YrecEndThreeUp)// + stepRecAndEllipse)
           else                                   // для А_=0
              pb1.Canvas.Rectangle(XrecBeginThree + stepRecAndEllipse, YrecBeginThreeDown,// + stepRecAndEllipse,
                                    XrecEndThree + stepRecAndEllipse, YrecEndThreeDown);// + stepRecAndEllipse);
         pb1.Canvas.Brush.Color := clBlack;
         stepEll := 0;
         for j := 0 to 2 do            // Рисуем для трех контактных
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
// выбор количесво джамперов (для двух контактных)
     begin

     end;

 end;

end.
