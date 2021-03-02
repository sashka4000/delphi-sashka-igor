unit extdev_driver;

interface
Uses Windows;

type
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
   function OnDataReceive (pd : PByte; PacketSize : Integer; MaxSize : Integer;  var AnswerSize : Integer) : HRESULT; stdcall;
  end;


implementation

end.
