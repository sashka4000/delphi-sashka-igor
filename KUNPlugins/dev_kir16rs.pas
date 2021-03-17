unit dev_kir16rs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  dev_base_form, Vcl.Grids, Vcl.ValEdit, Vcl.Buttons, Vcl.Samples.Spin,
  Vcl.StdCtrls, DateUtils, Vcl.Mask;

type
  TfrmKIR16RS = class(TfrmBase)
    lblVer: TLabel;
    medtVer: TMaskEdit;
    seNumber: TSpinEdit;
    lbl17: TLabel;
    btnSensor: TSpeedButton;
    lblSensor: TLabel;
    SG: TStringGrid;
    cbbPow: TComboBox;
    lblAKB: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TKIR16RS = class(TBaseDevice)
    function OnDataReceive(pd: PByte; PacketSize: Integer; MaxSize: Integer; var AnswerSize: Integer): HRESULT; override; stdcall;
  end;

const
  gKIR16RS: TGUID = '{C8B1EF56-D63C-4711-B44A-AE6E7024286A}';  // Глобальный идентификатор, генерируются по Ctrl+Shift+G

implementation

{$R *.dfm}
uses
  IdGlobal, ext_global;

{ TKIR16RS }

function TKIR16RS.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer; var AnswerSize: Integer): HRESULT;
var
  TR, TA: TArray<Byte>;
  ValueLoop : array of Cardinal;  // выделение памяти для хранения данных сумматоров входов
  bSendAnswer: Boolean;
//  tmp: string;
  FMyForm: TfrmKIR16RS;
//  bat: Double;
//  batInt: Integer;
  i: Integer;
  ver: string;
  FTime: TDateTime;
  Y, MM, D, H, M, S, MS: Word;
  FDevTimeDifference : Cardinal;
begin
  Result := inherited;
  FMyForm := TfrmKIR16RS(MyForm);
  // преобразование указателя к типу массив байт
  TR := TArray<Byte>(pd);

  // проверяю CRC пакета
  if GET_CRC(TR, PacketSize) <> TR[PacketSize - 1] then
    Exit;
  // проверяю адрес устройства в первом байте
  if TR[0] <> $80 + FMyForm.seNumber.Value then
    Exit;


  // формирую ответ на запрос

  case TR[1] of
    PCKT_TYPE:
      begin
  // Обработка состояния запроса типа устройства
        TA := TArray<Byte>.Create($80, $81, $03, $0A, $03, $01, $00);
        if FDevTimeSync then
          ResetBit(TA[5], 0);
        if FDevDataSend then
        begin
          SetBit(TA[5], 1);  // изменилось состояние дискретного входа или АКБ
          FDevDataSend := False;
        end;
      end;

    PCKT_WRITE_TIME:
      begin
     //Запись времени устройства
        FDevTimeSync := True;
        FDevTime := EncodeDateTime(TR[8] + 2000, TR[7], TR[6], TR[5], TR[4], TR[3], 0);
        FCompTime := Now;
        DecodeDate(FDevTime, Y, MM, D);
        DecodeTime(FDevTime, H, M, S, MS);
        TA := TArray<Byte>.Create($80, $82, $06, S, M, H, D, MM, (Y - 2000), $00);
      end;

    PCKT_READ_TIME:
      begin
     //Чтение времени устройства
        FTime := (Now - FCompTime) + FDevTime;
        DecodeDate(FTime, Y, MM, D);
        DecodeTime(FTime, H, M, S, MS);
        TA := TArray<Byte>.Create($80, $83, $06, S, M, H, D, MM, (Y - 2000), $00);
      end;

    PCKT_CURRENT:
      begin
        FDevBattery := FMyForm.cbbPow.ItemIndex;
        SetLength(ValueLoop, 16);
        SetLength(TA, 83);
        FTime := (Now - FCompTime) + FDevTime;
        DecodeDate(FDevTime, Y, MM, D);
        DecodeTime(FDevTime, H, M, S, MS);

        TA[0] := $80;
        TA[1] := $85;
        TA[2] := $4F;
        // время
        TA[3] := S;
        TA[4] := M;
        TA[5] := H;
        TA[6] := D;
        TA[7] := MM;
        TA[8] := (Y - 2000);
        //************************
        // состояние дискретного входа, аккумулятора и настроек
        if not(FMyForm.btnSensor.Down) then
        begin
           FDevDataSend := True;
           SetBit(TA[81],0);
        end;
        if FDevBattery <> 0 then
        begin
           FDevDataSend := True;
          case FDevBattery of
            1:
              begin
               SetBit(TA[81],5);
              end;
            2:
              begin
               SetBit(TA[81],4);
               SetBit(TA[81],5);
              end;
            3:
              begin
                SetBit(TA[81],6);
              end;
            4:
              begin
                SetBit(TA[81], 7);
              end;
          end;
        end;
       //****************************
       //Сумматоры
        for i := 0 to 15 do
        begin
          ValueLoop[i] := FMyForm.SG.Cells[1, i + 1].ToInt64;
          Move(ValueLoop[i], TA[9 + (4 * i)], 4);
        end;
        // наработка TA[73]
        FTime := Now - CreateDeviceTime;
        DecodeDate(FTime, Y, MM, D);
        DecodeTime(FTime, H, M, S, MS);
        FDevTimeDifference:=
      end;

    PCKT_OPER:
      begin


        TA := TArray<Byte>.Create($D8, $89, $02, $00 ,$00  , $00);

      end;

    PCKT_VERSION:
      begin
        TA := TArray<Byte>.Create($80, $8D, $02, $00, $00, $00);
        // Чтение версии устройства
        ver := FMyForm.medtVer.EditText;
        TA[3] := Fetch(ver, '.').ToInteger;
        TA[4] := ver.ToInteger;
      end;

    PCKT_WRITE_DATA:
      begin
     //Запись текущих данных устройства

        TA := TArray<Byte>.Create($D8, $84, $00, $00);
      end
  else
    Exit;
  end;

  // устанавливаю правильный адрес устройства в первый байт
  TA[0] := $80 + FMyForm.seNumber.Value;

  AnswerSize := Length(TA);

  // проверяю что ответ не превысил размер буфера
  if AnswerSize > MaxSize then
  begin
    Result := 1;
    Exit;
  end;

  // подписываю буфер
  CRC(TA, AnswerSize);

  // записываю буфер ответа во входящий буфер
  move(TA[0], TR[0], AnswerSize);

end;




// Формирование начальной формы и заполнение TStringGrid
procedure TfrmKIR16RS.FormCreate(Sender: TObject);
var
  i, j : Integer;
begin
  inherited;
  with SG do
  begin
    ColWidths[0] := 40;
    ColWidths[1] := 95;
    for i := 1 to 17 do
      Cells[0, i] := i.ToString;
    for I := 1 to 2 do
      begin
        for j := 1 to 16 do
          Cells[i, j] := '0';
      end;
    Cells[0, 0] := 'Вход';
    Cells[1, 0] := 'Число импульсов';
    Cells[2, 0] := 'Состояние шлейфа';
  end;

end;

end.

