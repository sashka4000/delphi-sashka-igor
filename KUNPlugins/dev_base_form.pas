unit dev_base_form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  extdev_driver, ext_global;

  {
   Это класс базовой формы и базового объекта
   Формы должны быть Inherited  от  TfrmBase

  }

type
  TGetTime = function  : TDateTime of Object;

  TArcRecord = record
    InfoByte: Byte;
    RecTime: TDateTime;
    Rec_number: Byte;
  end;


  TfrmBase = class(TForm)
  private
    { Private declarations }
    FCallBack: TPGUSensorCallBack;
    FDeviceTime : TGetTime;
    function GetCurrentDeviceTime: TDateTime;
  public
    { Public declarations }
    property CallBack: TPGUSensorCallBack read FCallBack;
    property CurrentDeviceTime : TDateTime read GetCurrentDeviceTime;
  end;

  TFrmBaseClass = class of TfrmBase;

  TBaseDevice = class(TInterfacedObject, IRSDevice)
  private
    FCB: TPGUSensorCallBack;
    FormClass: TFrmBaseClass;
    FCreateDevCompTime: TDateTime;
    function GetCurrentDeviceTime: TDateTime;
  public
    MyForm: TfrmBase;
    FDevTime: TDateTime;
    FCompTime: TDateTime;
    FDevTimeSync: Boolean;    // флаг валидности установленного времени
    FS : TFormatSettings;
    FDeviceSettingsList : TStringList;
    arrEEPROM: array[1..16] of Integer;
    constructor Create(F: TFrmBaseClass);
    function RegisterCallback(CBF: TPGUSensorCallBack): HResult; stdcall;
    function CreateDeviceWindow(parentHWND: HWND; var createHWND: HWND): Hresult; stdcall;
    function DestroyDevice: HRESULT; stdcall;
    function OnDataReceive(pd: PByte; PacketSize: Integer; MaxSize: Integer; var AnswerSize: Integer): HRESULT; virtual; stdcall;
    function Serialize (LoadSave: Integer; P: PChar; var  PSize : DWORD): HRESULT; virtual; stdcall;
    property CallBack: TPGUSensorCallBack read FCB;
    // время создания устройсва по часам компьютера
    property CreateDeviceCompTime: TDateTime read FCreateDevCompTime;
    // текущее время устройство по "внутренним часам"
    property CurrentDeviceTime : TDateTime read GetCurrentDeviceTime;
  end;

implementation

{$R *.dfm}

{ TBaseDevice }

constructor TBaseDevice.Create(F: TFrmBaseClass);
var
i : Integer;
begin
  FormClass := F;
  FDevTime := EncodeDate(2001, 1, 1) + EncodeTime(0, 0, 0, 0);
  FCompTime := Now;
  FCreateDevCompTime := Now;
  FDevTimeSync := False;
  FS := TFormatSettings.Create;
  FDeviceSettingsList := TStringList.Create;
   for i := 1 to 16 do
    arrEEPROM[i] := 6;
end;

function TBaseDevice.CreateDeviceWindow(parentHWND: HWND;
  var createHWND: HWND): Hresult;
begin
  MyForm := FormClass.Create(nil);
  MyForm.ParentWindow := parentHWND;
  createHWND := MyForm.Handle;
  MyForm.Visible := True;
  MyForm.FCallBack := FCB;
  MyForm.FDeviceTime := GetCurrentDeviceTime;
  Result := 0;
end;

function TBaseDevice.DestroyDevice: HRESULT;
begin
  MyForm.Free;
  FDeviceSettingsList.Free;
  Result := 0;
end;

function TBaseDevice.GetCurrentDeviceTime: TDateTime;
begin
  Result := (Now - FCompTime) + FDevTime;
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

function TBaseDevice.Serialize(LoadSave: Integer; P: PChar; var PSize : DWORD): HRESULT;
begin
  if LoadSave = 0 then
  begin
    FDeviceSettingsList.CommaText := P;
  end else
  begin
    if Length (FDeviceSettingsList.CommaText) + 1 > PSize
    then
    begin
      PSize := Length (FDeviceSettingsList.CommaText) + 1;
      Exit (1);
    end
    else
     StrPCopy(P,FDeviceSettingsList.CommaText);
  end;
  Result := 0;
end;

{ TfrmBase }

function TfrmBase.GetCurrentDeviceTime: TDateTime;
begin
  Result := FDeviceTime;
end;

end.
