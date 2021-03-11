library ext_test;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }



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
  dev_mbus in 'dev_mbus.pas' {frmBase1};

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
      // ����� ���������� �������������� ����������� ����������
      // ��� �������� ���������� ���������� ������� CreateDevice
  KUN.RegisterType(gUPSLM, '����');
  KUN.RegisterType(gKSLOtis, '���-OTIS');
  KUN.RegisterType(gKUP4RS, '���-4RS');

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
end;

destructor TDriver.Destroy;
begin
  inherited;
end;

begin
   TStyleManager.TrySetStyle('Iceberg Classico');
end.
