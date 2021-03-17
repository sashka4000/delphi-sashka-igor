unit dev_base_form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, extdev_driver, ext_global;

  {
   Это класс базовой формы и базового объекта
   Формы должны быть Inherited  от  TfrmBase

  }


type
  TfrmBase = class(TForm)
  private
    { Private declarations }
    FCallBack : TPGUSensorCallBack;
  public
    { Public declarations }
    property CallBack : TPGUSensorCallBack read FCallBack;
  end;

 TFrmBaseClass = class of TfrmBase;

 TBaseDevice = class (TInterfacedObject,IRSDevice)
   private
    FCB : TPGUSensorCallBack;
    FormClass : TFrmBaseClass;
    FCreateTime : TDateTime;
   public
   MyForm : TfrmBase;
   FDevTime : TDateTime;
   FCompTime : TDateTime;
   FDevTimeSync : Boolean;    // флаг валидности установленного времени
   FDevDataSend : Boolean;   // флаг готовности уст-ва передать оперативные данные
   FDevBattery : Byte;       // флаг состояния АКБ
   constructor Create (F : TFrmBaseClass);
   function RegisterCallback (CBF : TPGUSensorCallBack) : HResult; stdcall;
   function CreateDeviceWindow (parentHWND: HWND; var createHWND : HWND) : Hresult; stdcall;
   function DestroyDevice : HRESULT; stdcall;
   function OnDataReceive (pd : PByte; PacketSize : Integer; MaxSize : Integer;  var AnswerSize : Integer) : HRESULT; virtual; stdcall;
   property CallBack : TPGUSensorCallBack read FCB;
   property CreateDeviceTime : TDateTime read FCreateTime;
  end;

implementation

{$R *.dfm}

{ TBaseDevice }

constructor TBaseDevice.Create(F: TFrmBaseClass);
begin
  FormClass := F;
  FDevTime := EncodeDate(2001,1,1) + EncodeTime(0,0,0,0);
  FCompTime := Now;
  FCreateTime := Now;
  FDevTimeSync := False;
  FDevDataSend := False;
  FDevBattery := $00;
end;

function TBaseDevice.CreateDeviceWindow(parentHWND: HWND;
  var createHWND: HWND): Hresult;
begin
  MyForm := FormClass.Create(nil);
  MyForm.ParentWindow := parentHWND;
  createHWND := MyForm.Handle;
  MyForm.Visible := True;
  MyForm.FCallBack := FCB;
  Result := 0;
end;

function TBaseDevice.DestroyDevice: HRESULT;
begin
  MyForm.Free;
  Result := 0;
end;

function TBaseDevice.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer;
  var AnswerSize: Integer): HRESULT;
begin
  AnswerSize := 0;
  Result := 0;
end;

function TBaseDevice.RegisterCallback(CBF: TPGUSensorCallBack): HResult;
begin
  FCB := CBF;
  Result := 0;
end;

end.
