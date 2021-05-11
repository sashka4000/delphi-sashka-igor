unit extdev_driver;

interface
Uses Windows;

type
  // 0 - не менять состояние,  > 0 нажать кнопку или замкнуть дискретник
  // нумерация входов с 1
  TPGUSensorCallBack = procedure (PushPGU, PushSensor : Integer); stdcall;

  ISerialDriver = interface;
  IRSDevice     = interface;

  IImitator = interface
    function RegisterDriver(PDS : ISerialDriver) : HRESULT; stdcall;
    function RegisterType(guidClass : TGUID; ClassName : PCHAR) : HRESULT; stdcall;
  end;

  ISerialDriver = interface
   function CreateDevice  (guidClass : TGUID; guidID : TGUID; var RS : IRSDevice)  : HResult; stdcall;
  end;

  IRSDevice  = interface
   function RegisterCallback (CBF : TPGUSensorCallBack) : HResult; stdcall;
   function CreateDeviceWindow (parentHWND: HWND; var createHWND : HWND) : Hresult; stdcall;
   function DestroyDevice : HRESULT; stdcall;
   // MaxSize - размер буфера
   // AnswerSize - размер ответа или 0, если пакет устройством не обрабатывается
   // ответный пакет должен быть записан в тот же буфер pd
   // Входной пакет по интерфейсу последовательно будет передан каждому активному драйверу
   // до первого кто выставит значение AnswerSize > 0
   function OnDataReceive (pd : PByte; PacketSize : Integer; MaxSize : Integer;  var AnswerSize : Integer) : HRESULT; stdcall;
   function Serialize (LoadSave : Integer; P : PChar; var PSize : DWORD) : HRESULT; stdcall;
  end;


implementation

end.
