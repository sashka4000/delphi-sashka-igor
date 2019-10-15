unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Contnrs,
  Vcl.StdCtrls;

type

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

  // Создаю новый набор

  DeviceName := 'КУН-2Д.1';

  // Левая сторона

  LS := TObjectList.Create (true);

  C := TColodka.Create('Входы кнопок ПГУ');
  C.Contacts.Add(TContact.Create('K1',''));
  C.Contacts.Add(TContact.Create('K2','Подъезд'));
  C.Contacts.Add(TContact.Create('K3','Подъезд2'));
  C.Contacts.Add(TContact.Create('K4',''));
  LS.Add(C);

  C := TColodka.Create('Входы динамиков ПГУ');
  C.Contacts.Add(TContact.Create('Г1',''));
  C.Contacts.Add(TContact.Create('Г2','Подъезд'));
  C.Contacts.Add(TContact.Create('Г3','Подъезд2'));
  C.Contacts.Add(TContact.Create('Г4',''));
  LS.Add(C);


  RS := TObjectList.Create (true);
  C := TColodka.Create('Тест');
  C.Contacts.Add(TContact.Create('1','Тест'));
  RS.Add(C);

  // Вызываем перерисовку Доски

  pb1.Repaint;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  DeviceName := 'просто так себе рисунок';
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  LS.Free;
  RS.Free;
end;

procedure TfrmMain.pb1Paint(Sender: TObject);
var
 W : Integer;
 X : Integer;
begin
  // Чтобы Доска перерисовывалась нормально рисовать нужно в этом методе
  // Пример определения центра для вывода текста
  if DeviceName <> '' then
  begin
     w := pb1.Canvas.TextWidth(DeviceName);
     X := pb1.Width div 2 - W div 2;
     pb1.Canvas.TextOut(X,5,DeviceName);
  end;

  if (LS = nil)  and (RS = nil) then
  begin
    // линия
    pb1.Canvas.MoveTo(0,0);
    pb1.Canvas.LineTo(50,50);
    // прямоуголник
    pb1.Canvas.Rectangle(150,150,450,450);
    // текст
    pb1.Canvas.TextOut(50,50,'Это мой первый рисунок');
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

destructor TColodka.Destroy;
begin
  Contacts.Free;
  inherited;
end;

end.
