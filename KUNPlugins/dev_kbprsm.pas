unit dev_kbprsm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, dev_base_form, ext_global,
  Vcl.Buttons, DateUtils;

type
  TfrmKBPRSM = class(TfrmBase)
    lblName: TLabel;
    cbbKBPRSMVyzov: TComboBox;
    seNumber: TSpinEdit;
    lblkbprsm: TLabel;
    btnON1: TSpeedButton;
    btnON2: TSpeedButton;
    btnON3: TSpeedButton;
    btnON4: TSpeedButton;
    lblControl: TLabel;
    lblInDiscrete: TLabel;
    btnDS2: TSpeedButton;
    btnDS4: TSpeedButton;
    btnDS3: TSpeedButton;
    btnDS1: TSpeedButton;
    btnDS5: TSpeedButton;
    btnDS6: TSpeedButton;
    btnCTRL_220: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TKBPRSM = class(TBaseDevice)
    PRPGS: BOOLEAN;                     // флаг подключения проверки ПГС
    PGSON : Boolean;                    // флаг включения ПГС - диспетчером
    AlertDate: BOOLEAN;                 // флаг наличия срочных данных
    constructor Create(F: TFrmBaseClass);

    function OnDataReceive(pd: PByte; PacketSize: Integer; MaxSize: Integer; var AnswerSize: Integer): HRESULT; override; stdcall;
  end;

const
  gKBPRSM: TGUID = '{F5A76306-E115-4A9C-BF05-1244CDE385ED}';  // Глобальный идентификатор, генерируются по Ctrl+Shift+G


var
  frmKBPRSM: TfrmKBPRSM;

implementation


{$R *.dfm}

{ TKBPRSM }

constructor TKBPRSM.Create(F: TFrmBaseClass);
begin
  inherited;
  PRPGS := False;
  PGSON := False;
  AlertDate := False;
end;

function TKBPRSM.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer; var AnswerSize: Integer): HRESULT;
var
  TR, TA: TArray<Byte>;
  bSendAnswer: Boolean;
  FMyForm: TfrmKBPRSM;
  i: Integer;
  FTime: TDateTime;
  Y, MM, D, H, M, S, MS: Word;
begin
  Result := inherited;

  FMyForm := TfrmKBPRSM(MyForm);
  // преобразование указателя к типу массив байт
  TR := TArray<Byte>(pd);

  // проверяю CRC пакета
  if GET_CRC(TR, PacketSize) <> TR[PacketSize - 1] then
    Exit;
  // проверяю адрес устройства в первом байте
  if TR[0] <> $C8 + FMyForm.seNumber.Value then
    Exit;


  // формирую ответ на запрос

  case TR[1] of

    PCKT_TYPE:
      begin
        // Обработка состояния запроса типа устройства
        TA := TArray<Byte>.Create($C8, $81, $03, $06, $03, $00, $00);
        if FDevTimeSync then
          SetBit(TA[5], 0);  // часы и календарь валидны
        if AlertDate then
        begin
          AlertDate := False;
          SetBit(TA[5], 1);  // появились срочные данные
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
        TA := TArray<Byte>.Create($C8, $82, $06, S, M, H, D, MM, (Y - 2000), $00);
      end;

    PCKT_READ_TIME:
      begin
        //Чтение времени устройства
        FTime := (Now - FCompTime) + FDevTime;
        DecodeDate(FTime, Y, MM, D);
        DecodeTime(FTime, H, M, S, MS);
        TA := TArray<Byte>.Create($C8, $83, $06, S, M, H, D, MM, (Y - 2000), $00);
      end;

    PCKT_WRITE_DATA:
      begin
        //Запись текущих данных устройства
        TA := TArray<Byte>.Create($C8, $84, $02, $FF, $00, $00);
        PRPGS := IsBitSet(TR[3], 7);
        if PRPGS then
          SetBit(TA[4], 7);

      // каналы ПГС
        FMyForm.cbbKBPRSMVyzov.ItemIndex := 0;
        if IsBitSet(TR[3], 6) then
        begin
          FMyForm.cbbKBPRSMVyzov.ItemIndex := 3;
          SetBit(TA[4], 6);
          PGSON := True;
        end;
        if IsBitSet(TR[3], 5) then
        begin
          FMyForm.cbbKBPRSMVyzov.ItemIndex := 2;
          SetBit(TA[4], 5);
          PGSON := True;
        end;
        if IsBitSet(TR[3], 4) then
        begin
          FMyForm.cbbKBPRSMVyzov.ItemIndex := 1;
          SetBit(TA[4], 4);
          PGSON := True;
        end;

        // Блокируем возможность изменения до сброса ПГС
        FMyForm.cbbKBPRSMVyzov.Enabled :=  not PGSON;

      // управление
        FMyForm.btnON4.Down :=  IsBitSet(TR[3], 3);
        if  FMyForm.btnON4.Down then
          SetBit(TA[4], 3);
        FMyForm.btnON3.Down :=  IsBitSet(TR[3], 2);
        if  FMyForm.btnON3.Down then
          SetBit(TA[4], 2);
        FMyForm.btnON2.Down :=  IsBitSet(TR[3], 1);
        if  FMyForm.btnON2.Down then
          SetBit(TA[4], 1);
        FMyForm.btnON1.Down :=  IsBitSet(TR[3], 0);
        if  FMyForm.btnON1.Down then
          SetBit(TA[4], 0);
      end;
    PCKT_CURRENT:
      begin
       // Чтение текущих данных устройства
        TA := TArray<Byte>.Create($C8, $85, $03, $00, $00, $00, $00);
        if FMyForm.btnDS6.Down then
          SetBit(TA[3], 6);
        if FMyForm.btnDS5.Down then
          SetBit(TA[3], 5);
        if FMyForm.btnDS4.Down then
          SetBit(TA[3], 4);
        if FMyForm.btnDS3.Down then
          SetBit(TA[3], 3);
        if FMyForm.btnDS2.Down then
          SetBit(TA[3], 2);
        if FMyForm.btnDS1.Down then
          SetBit(TA[3], 1);
        if FMyForm.btnCTRL_220.Down then
          SetBit(TA[3], 0);

        if not PGSON then
        begin
          // если сейчас не включена ПГС, то считаем что была нажата кнопка
          // вызов
          case FMyForm.cbbKBPRSMVyzov.ItemIndex of
            1:
              SetBit(TA[4], 0);
            2:
              SetBit(TA[4], 1);
            3:
              SetBit(TA[4], 2);
          end;
        end else
        begin
           // если сейчас включена ПГС, то указывем какой канал включен
          case FMyForm.cbbKBPRSMVyzov.ItemIndex of
            1:
              SetBit(TA[5], 4);
            2:
              SetBit(TA[5], 5);
            3:
              SetBit(TA[5], 6);
          end;
        end;

        if PRPGS then
          SetBit(TA[5], 7);

        if FMyForm.btnON4.Down then
          SetBit(TA[5], 3);
        if FMyForm.btnON3.Down then
          SetBit(TA[5], 2);
        if FMyForm.btnON2.Down then
          SetBit(TA[5], 1);
        if FMyForm.btnON1.Down then
          SetBit(TA[5], 0);

      end;
    PCKT_OPER:
      begin
        // чтение срочных данных устройства
        TA := TArray<Byte>.Create($C8, $89, $02, $00, $00, $00);

        if FMyForm.btnON2.Down then
          SetBit(TA[3], 1);
        if FMyForm.btnON1.Down then
          SetBit(TA[3], 0);

        if FMyForm.btnDS6.Down then
          SetBit(TA[4], 6);
        if FMyForm.btnDS5.Down then
          SetBit(TA[4], 5);
        if FMyForm.btnDS4.Down then
          SetBit(TA[4], 4);
        if FMyForm.btnDS3.Down then
          SetBit(TA[4], 3);
        if FMyForm.btnDS2.Down then
          SetBit(TA[4], 2);
        if FMyForm.btnDS1.Down then
          SetBit(TA[4], 1);
        if FMyForm.btnCTRL_220.Down then
          SetBit(TA[4], 0);
        // флаг появились срочные данные
        if ((TA[3] and $73) or (TA[4] and $7F)) > 0 then
          AlertDate := True;

      end

  else
    Exit;
  end;

  // устанавливаю правильный адрес устройства в первый байт
  TA[0] := $C8 + FMyForm.seNumber.Value;

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

end.
