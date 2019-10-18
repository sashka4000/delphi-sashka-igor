unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Contnrs,
  Vcl.StdCtrls;

type

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
    function differenceColodka(LObject : TObjectList): integer;
   	procedure buildingColodka(const diffCol : Integer;LOject : TObjectList);
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

  // ������ ����� �����

  DeviceName := '���-2�.1';

  // ����� �������

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
  C.Contacts.Add(TContact.Create('K5',''));
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
  DeviceName := 'K99';
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
 differnceHeight : Integer;  // ��� ����� ���������
begin
  // ����� ����� ���������������� ��������� �������� ����� � ���� ������
  // ������ ����������� ������ ��� ������ ������
  //******************** ������������� �������� �������� **************************************
  with pb1.Canvas do
    begin
      Pen.Width := 1;
      Pen.Color := clBlue;
      Pen.Style := psSolid;
      Rectangle(100,0,450,600);
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

//********************************* ������� ******************************************************************
function TfrmMain.differenceColodka(LObject : TObjectList): integer;
  var
    countColodka, countContact : Integer;
    i : Integer;
  const
    heightContact = 15; // ������ ������ +2 �������
    widthContact  = 20; // ������ 3 �������� +2 �������
    HeightWind = 600;
    widthWind = 450;
  begin
  countColodka := LObject.Count;
  countContact := 0;
  i := 0;
  while i <= countColodka - 1 do
      begin
        countContact := countContact + TColodka (LS.Items[i]).Contacts.Count;
        Inc(i);
      end;
  Result := Round(((HeightWind - heightContact * countContact)/(countColodka +1)));
  end;

//********************************* ��������� *************************************************
 procedure TfrmMain.buildingColodka(const diffCol : Integer;LOject : TObjectList);
 var
  yIndexBeginColodka, yIndexEndColodka : Integer;
  countColodka : Integer;
  yIndex : Integer;
  differnceHeight : Integer;
  i, j, k : Integer;

 const
   XBeginIndexContactLS = 100;  // ��������� ���������� ��������
   XEndIndexContactLS = 125;    // ��������  ���������� ��������
   heightContact = 15; // ������ ������ +2 �������
   widthContact  = 25; // ������ 3 �������� +2 �������
   HeightWind = 600;
   widthWind = 450;
 begin
   differnceHeight := diffCol;
   with pb1.Canvas do
     begin
       Pen.Color := clBlack;
       Pen.Style := psSolid;
     end;
   countColodka := LS.Count;
   i := 0;
   yIndex := differnceHeight;
   while i <= countColodka -1 do
     begin
       k := TColodka (LS.Items[i]).Contacts.Count -1;
       yIndexBeginColodka := yIndex;
       for j := 0 to k do
         begin
           pb1.Canvas.Rectangle(XBeginIndexContactLS, yIndex, XEndIndexContactLS, yIndex + heightContact);
           pb1.Canvas.TextOut(XBeginIndexContactLS + 5, yIndex +1, TContact( TColodka(LS.Items[i]).Contacts.Items[j]).Contact);
           yIndex := yIndex + heightContact;
         end;
      yIndexEndColodka := yIndex;
      pb1.Canvas.Rectangle(XEndIndexContactLS, yIndexBeginColodka, XEndIndexContactLS +90, yIndexEndColodka);
      pb1.Canvas.TextOut(XEndIndexContactLS + 5, yIndexBeginColodka + 3, TColodka(LS.Items[i]).Name);
      yIndex := yIndexEndColodka + differnceHeight;
      Inc(i);
     end;

 end;
end.
