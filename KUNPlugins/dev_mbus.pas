unit dev_mbus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dev_base_form, Vcl.StdCtrls, Emu,
  Vcl.Grids, Vcl.ValEdit;

type
  TfrmMBus = class(TfrmBase)
    lbl1: TLabel;
    lbl2: TLabel;
    edtName: TEdit;
    lbl3: TLabel;
    lst1: TValueListEditor;
    lbl4: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TMBUS = class(TBaseDevice)
    Dev : TEmulatorDevice;
    constructor Create (F : TFrmBaseClass);
    destructor  Destroy; override;
    function OnDataReceive(pd: PByte; PacketSize: Integer; MaxSize: Integer; var AnswerSize: Integer): HRESULT; override; stdcall;
  end;

const
  gMBUS: TGUID = '{41304BA4-F867-4E31-97D3-42BFFBE091D2}';  // Глобальный идентификатор, генерируются по Ctrl+Shift+G


implementation
Uses System.Generics.Collections;

{$R *.dfm}

{ TMBUS }

constructor TMBUS.Create(F: TFrmBaseClass);
var
 R : TResourceStream;
 sl : TStringList;
begin
 inherited;
 sl := TStringList.Create;
 R := TResourceStream.Create(HInstance,'mbus1',RT_RCDATA);
  sl.LoadFromStream(R);
 R.Free;
 Dev := TEmulatorDevice.Create;
 Dev.FCounter := 0;
 try
  Dev.ReadEmulator(sl);
 except on E : Exception do
   MessageBox(0, PChar(Format('Ошибка: %s', [E.Message])),
     PChar('MBUS'), MB_OK + MB_ICONSTOP + MB_TOPMOST);
 end;
 sl.Free;
end;

destructor TMBUS.Destroy;
begin
  Dev.Free;
  inherited;
end;

function TMBUS.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer;
  var AnswerSize: Integer): HRESULT;
begin
 Result := inherited;
 Dev.Request (PByteArray(pd),PacketSize);
 Result := Dev.GetAnswer (PByteArray(pd),0,MaxSize,AnswerSize);
end;

end.
