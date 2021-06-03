unit dev_kup2rs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, ext_global,
  dev_base_form, Vcl.Buttons;

type
  TfrmKUP2RS = class(TfrmBase)
    chkPowLine: TCheckBox;
    seNumber: TSpinEdit;
    lbl17: TLabel;
    btnSw2: TSpeedButton;
    btnSw1: TSpeedButton;
    btnIn6: TSpeedButton;
    btnIn5: TSpeedButton;
    btnIn2: TSpeedButton;
    btnIn1: TSpeedButton;
    lblSw: TLabel;
    lblIn: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

    TKUP2RS = class(TBaseDevice)
    function Serialize (LoadSave: Integer; P: PChar; var PSize : DWORD): HRESULT; override; stdcall;
    function OnDataReceive(pd: PByte; PacketSize: Integer; MaxSize: Integer; var AnswerSize: Integer): HRESULT; override; stdcall;
  end;

const
  gKUP2RS: TGUID = '{F9F3C848-4713-45BC-9FB5-C21F73D348D6}';  // √лобальный идентификатор, генерируютс€ по Ctrl+Shift+G

implementation

{$R *.dfm}

function TKUP2RS.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer; var AnswerSize: Integer): HRESULT;
var
  TR, TA: TArray<Byte>;
  bSendAnswer: Boolean;
  upsl_b, upsl_ch: Byte;
  FMyForm: TfrmKUP2RS;
//  i: Integer;
//  FTime: TDateTime;
//  Y, MM, D, H, M, S, MS: Word;
begin
  Result := inherited;

  FMyForm := TfrmKUP2RS(MyForm);
  // преобразование указател€ к типу массив байт
  TR := TArray<Byte>(pd);

  // провер€ю CRC пакета
  if GET_CRC(TR, PacketSize) <> TR[PacketSize - 1] then
    Exit;
  // провер€ю адрес устройства в первом байте
  if TR[0] <> $08 + FMyForm.seNumber.Value then
    Exit;


  // формирую ответ на запрос

  case TR[1] of
    PCKT_TYPE:
      begin
  // ќбработка состо€ни€ запроса типа устройства
        TA := TArray<Byte>.Create($08, $04, $00, $00, $00, $00, $00);

      end

  else
    Exit;
  end;

  // устанавливаю правильный адрес устройства в первый байт
  TA[0] := $08 + FMyForm.seNumber.Value;

  AnswerSize := Length(TA);

  // провер€ю что ответ не превысил размер буфера
  if AnswerSize > MaxSize then
  begin
    Result := 1;
    Exit;
  end;

  // подписываю буфер
  CRC(TA, AnswerSize);

  // записываю буфер ответа во вход€щий буфер
  move(TA[0], TR[0], AnswerSize);
end;


function TKUP2RS.Serialize(LoadSave: Integer; P: PChar;
  var PSize: DWORD): HRESULT;
var
  FMyForm: TfrmKUP2RS;
begin
 FMyForm := TfrmKUP2RS(MyForm);
 if LoadSave = 0 then
 begin
   Result := inherited;
   FMyForm.seNumber.Text := FDeviceSettingsList.Values ['Address'];
//   FMyForm.cbbVersion.ItemIndex := FDeviceSettingsList.Values ['Version'].ToInteger;
 end else
 begin
   FDeviceSettingsList.Clear;
   FDeviceSettingsList.AddPair ('Address', FMyForm.seNumber.Text);
//   FDeviceSettingsList.AddPair ('Version', FMyForm.cbbVersion.ItemIndex.ToString);
   Result := inherited;
 end;
end;
end.
