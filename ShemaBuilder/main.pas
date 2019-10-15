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
  LS.Add(C);

  C := TColodka.Create('����� ��������� ���');
  C.Contacts.Add(TContact.Create('�1',''));
  C.Contacts.Add(TContact.Create('�2','�������'));
  C.Contacts.Add(TContact.Create('�3','�������2'));
  C.Contacts.Add(TContact.Create('�4',''));
  LS.Add(C);


  RS := TObjectList.Create (true);
  C := TColodka.Create('����');
  C.Contacts.Add(TContact.Create('1','����'));
  RS.Add(C);

  // �������� ����������� �����

  pb1.Repaint;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  DeviceName := '������ ��� ���� �������';
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
  // ����� ����� ���������������� ��������� �������� ����� � ���� ������
  // ������ ����������� ������ ��� ������ ������
  if DeviceName <> '' then
  begin
     w := pb1.Canvas.TextWidth(DeviceName);
     X := pb1.Width div 2 - W div 2;
     pb1.Canvas.TextOut(X,5,DeviceName);
  end;

  if (LS = nil)  and (RS = nil) then
  begin
    // �����
    pb1.Canvas.MoveTo(0,0);
    pb1.Canvas.LineTo(50,50);
    // ������������
    pb1.Canvas.Rectangle(150,150,450,450);
    // �����
    pb1.Canvas.TextOut(50,50,'��� ��� ������ �������');
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
