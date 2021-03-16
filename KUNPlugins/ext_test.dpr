library ext_test;

{$R *.dres}

uses
  Windows,
  System.SysUtils,
  System.Classes,
  Vcl.Themes,
  Vcl.Styles,
  extdev_driver in 'extdev_driver.pas',
  dev_upsl in 'dev_upsl.pas' {frmUPSL},
  ext_global in 'ext_global.pas',
  dev_ksl_otis in 'dev_ksl_otis.pas' {frmKSL},
  dev_base_form in 'dev_base_form.pas' {frmBase},
  dev_kup4rs in 'dev_kup4rs.pas' {frmKUP4RS},
  dev_mbus in 'dev_mbus.pas' {frmBase1},
  Emu in 'Emu.pas',
  dev_modbus in 'dev_modbus.pas' {frmModbus},
  CRCUnit in 'CRCUnit.pas',
  dev_kir16rs in 'dev_kir16rs.pas' {frmKIR16RS};

{$R *.res}
{$R style_res.res}


type
  TDriver = class (TInterfacedObject, ISerialDriver)
   function CreateDevice  (guidClass : TGUID; guidID : TGUID; var RS : IRSDevice)  : HResult; stdcall;
   destructor Destroy; override;
  end;


var
  Driver: TDriver = nil;

procedure GetSerialDriver(KUN: IImitator); stdcall;
begin
  if Driver = nil then
    Driver := TDriver.Create;
  KUN.RegisterDriver(Driver);
      // Здесь необходимо регистрировать создаваемые устройства
      // Для создания устройства приложение вызовет CreateDevice
  KUN.RegisterType(gUPSLM, 'УПСЛ');
  KUN.RegisterType(gKSLOtis, 'КСЛ-OTIS');
  KUN.RegisterType(gMBUS, 'M-Bus');
  KUN.RegisterType(gModbus, 'Modbus');
  KUN.RegisterType(gKUP4RS, 'КУП-4RS');
  // Устройства, находящиеся в разработке  будут создаваться
  // только в режиме DEBUG сборки
  {$IFDEF DEBUG}
     KUN.RegisterType(gKIR16RS, 'КИР-16RS');
  {$ENDIF}
end;

 exports
   GetSerialDriver;
{ TDriver }

function TDriver.CreateDevice(guidClass, guidID: TGUID;
  var RS: IRSDevice): HResult;
begin
  Result := 1;
  RS := nil;
  // *
  if IsEqualGUID(guidClass, gUPSLM) then
  begin
     RS := TUPSL.Create (TfrmUPSL);
     Result := 0;
  end;
  if IsEqualGUID(guidClass, gKSLOtis) then
  begin
     RS := TKSLOtis.Create (TfrmKSL);
     Result := 0;
  end;
  if IsEqualGUID(guidClass, gKUP4RS) then
  begin
     RS := TKUP4RS.Create (TfrmKUP4RS);
     Result := 0;
  end;
  if IsEqualGUID(guidClass, gMBUS) then
  begin
     RS := TMBUS.Create (TfrmMBus);
     Result := 0;
  end;
  if IsEqualGUID(guidClass, gModbus) then
  begin
     RS := TModbus.Create (TfrmModbus);
     Result := 0;
  end;
  if IsEqualGUID(guidClass, gKIR16RS) then
  begin
     RS := TKIR16RS.Create (TfrmKIR16RS);
     Result := 0;
  end;
end;

destructor TDriver.Destroy;
begin
  inherited;
end;

begin
   TStyleManager.TrySetStyle('Iceberg Classico');
end.
