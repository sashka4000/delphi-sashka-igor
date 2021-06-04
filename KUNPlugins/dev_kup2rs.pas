unit dev_kup2rs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Samples.Spin, ext_global, dev_base_form, Vcl.Buttons;

type
  TfrmKUP2RS = class(TfrmBase)
    chkPowLine: TCheckBox;
    seNumber: TSpinEdit;
    lbl17: TLabel;
    btnSw2: TSpeedButton;
    btnSw1: TSpeedButton;
    btnIn6: TSpeedButton;
    btnIn5: TSpeedButton;
    btnIn1: TSpeedButton;
    lblSw: TLabel;
    lblIn: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure TimerMessage(var T: TMessage); message WM_USER + 1;
  end;

  TKUP2RS = class(TBaseDevice)
    function Serialize(LoadSave: Integer; P: PChar; var PSize: DWORD): HRESULT; override; stdcall;
    function OnDataReceive(pd: PByte; PacketSize: Integer; MaxSize: Integer; var AnswerSize: Integer): HRESULT; override; stdcall;
  end;

const
  gKUP2RS: TGUID = '{F9F3C848-4713-45BC-9FB5-C21F73D348D6}';  // √лобальный идентификатор, генерируютс€ по Ctrl+Shift+G

implementation

{$R *.dfm}

{ TWaitTime }

type
  TWaitTime = class(TThread)
    FBtn: TSpeedButton;
    FHWND: HWND;
    constructor Create(btn: TSpeedButton; w: hwnd);
    procedure Execute; override;
  end;


{ TKUP2RS }

function TKUP2RS.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer; var AnswerSize: Integer): HRESULT;
var
  TR, TA: TArray<Byte>;
  FMyForm: TfrmKUP2RS;
  b1, b2 : TSpeedButton;
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
        // состо€ни€ запроса типа устройства
        TA := TArray<Byte>.Create($08, $04, TR[2], $44 , $00, TR[2], $00);

        // питание концентратора
        if FMyForm.chkPowLine.Checked then
          SetBit(TA[4], 0);

        // состо€ние  ”ѕ
        if FMyForm.btnIn1.Down then
          ResetBit(TA[4], 4);

        // „итаем состо€ние кнопок оптопар
        if FMyForm.btnIn5.Down then
          ResetBit(TA[3], 6);

        if FMyForm.btnIn6.Down then
          ResetBit(TA[3], 2);

        // подача напр€жени€ на реле
        if FMyForm.btnSw1.Down then
          SetBit(TA[3], 4);

        if FMyForm.btnSw2.Down then
          SetBit(TA[3], 0);

        // „итаем команды во входном пакете
        b1 := FMyForm.btnSw1;
        b2 := FMyForm.btnSw2;

        if (TR[2] and $0D) = $01 then
        begin
          SetBit(TA[3], 0);
          b2.Down := True;
          if (TR[2] and $03) = $03 then
            TWaitTime.Create(b2, FMyForm.Handle);
        end;

        if (TR[2] and $0F) = $02 then
        begin
          ResetBit(TA[3], 0);
          b2.Down := False;
        end;

        if (TR[2] and $D0) = $10 then
        begin
          SetBit(TA[3], 0);
          b1.Down := True;
          if (TR[2] and $30) = $30 then
            TWaitTime.Create(b1, FMyForm.Handle);
        end;

        if (TR[2] and $F0) = $20 then
        begin
          ResetBit(TA[3], 0);
          b1.Down := False;
        end;
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

function TKUP2RS.Serialize(LoadSave: Integer; P: PChar; var PSize: DWORD): HRESULT;
var
  FMyForm: TfrmKUP2RS;
begin
  FMyForm := TfrmKUP2RS(MyForm);
  if LoadSave = 0 then
  begin
    Result := inherited;
    FMyForm.seNumber.Text := FDeviceSettingsList.Values['Address'];
  end
  else
  begin
    FDeviceSettingsList.Clear;
    FDeviceSettingsList.AddPair('Address', FMyForm.seNumber.Text);
    Result := inherited;
  end;
end;


{Delay}

procedure TfrmKUP2RS.TimerMessage(var T: TMessage);
begin
  TSpeedButton(T.WParam).Down := False;
end;



{ TWaitTime }
constructor TWaitTime.Create(btn: TSpeedButton; w: hwnd);
begin
  FBtn := btn;
  FHWND := w;
  inherited Create;
end;

procedure TWaitTime.Execute;
begin
  // освободитьс€ после завершени€ потока
  FreeOnTerminate := True;
  // поспать 3 секунды
  sleep(3000);
  // послать сообщение на отжатие кнопки
  PostMessage(FHWND, WM_USER + 1, Integer(FBTN), 0);
end;

end.

