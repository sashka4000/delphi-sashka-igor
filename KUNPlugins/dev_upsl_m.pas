unit dev_upsl_m;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls,
  Vcl.Samples.Spin, ext_global, dev_base_form, Vcl.CheckLst, Vcl.ExtCtrls, DateUtils, Vcl.Mask;

type
  TfrmUPSL_M = class(TfrmBase)
    chkAmp1: TCheckBox;
    medtVer: TMaskEdit;
    chkFire: TCheckBox;
    chkAmp2: TCheckBox;
    lbledtBat: TLabeledEdit;
    chkBat: TCheckBox;
    chkNet: TCheckBox;
    seNumber: TSpinEdit;
    cbbUPSLVyzov: TComboBox;
    seUPSL_KUN: TSpinEdit;
    lblVer: TLabel;
    lbl1: TLabel;
    lbl12: TLabel;
    lbl21: TLabel;
    lbl17: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TUPSL_M = class(TBaseDevice)
    function OnDataReceive(pd: PByte; PacketSize: Integer; MaxSize: Integer; var AnswerSize: Integer): HRESULT; override; stdcall;
  end;

const
  gUPSLM_2: TGUID = '{DD24BED3-1DE3-42FF-A30C-5176FC964CD3}';  // Глобальный идентификатор, генерируются по Ctrl+Shift+G


implementation

{$R *.dfm}
Uses IdGlobal;

{ TUPSL_M }

function TUPSL_M.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer; var AnswerSize: Integer): HRESULT;
var
  TR, TA: TArray<Byte>;
  bSendAnswer: Boolean;
  upsl_b, upsl_ch: Byte;
  tmp: string;
  FMyForm: TfrmUPSL_M;
  bat: Double;
  batInt: Integer;
  i: Integer;
  ver : string;
  FTime: TDateTime;
  Y, MM, D, H, M, S, MS: Word;
begin
  Result := inherited;

  FMyForm := TfrmUPSL_M(MyForm);
  // преобразование указателя к типу массив байт
  TR := TArray<Byte>(pd);

  // проверяю CRC пакета
  if GET_CRC(TR, PacketSize) <> TR[PacketSize - 1] then
    Exit;
  // проверяю адрес устройства в первом байте
  if TR[0] <> $D8 + FMyForm.seNumber.Value then
    Exit;


  // формирую ответ на запрос

  case TR[1] of

    PCKT_TYPE:
      begin
  // Обработка состояния запроса типа устройства
        TA := TArray<Byte>.Create($D8, $81, $03, $08, $03, $00, $00);
        if FDevTimeSync then
          SetBit(TA[5], 0);  // часы и календарь валидны
        if not (FMyForm.chkNet.Checked and FMyForm.chkBat.Checked and FMyForm.chkAmp1.Checked and FMyForm.chkAmp2.Checked and FMyForm.chkFire.Checked) then
          SetBit(TA[5], 1);  // появились срочные данные
      end;

    PCKT_WRITE_TIME:
      begin
     //Запись времени устройства
        FDevTimeSync := True;
        FDevTime := EncodeDateTime(TR[8] + 2000, TR[7], TR[6], TR[5], TR[4], TR[3], 0);
        FCompTime := Now;
        DecodeDate(FDevTime, Y, MM, D);
        DecodeTime(FDevTime, H, M, S, MS);
        TA := TArray<Byte>.Create($D8, $82, $06, S, M, H, D, MM, (Y - 2000), $00);
      end;

    PCKT_READ_TIME:
      begin
     //Чтение времени устройства
        FTime := (Now - FCompTime) + FDevTime;
        DecodeDate(FTime, Y, MM, D);
        DecodeTime(FTime, H, M, S, MS);
        TA := TArray<Byte>.Create($D8, $83, $06, S, M, H, D, MM, (Y - 2000), $00);
      end;

    PCKT_WRITE_DATA:
      begin
     //Запись текущих данных устройства
        case TR[3] of
          $00:
            begin
              FMyForm.cbbUPSLVyzov.ItemIndex := 0;
            end;
          $01:
            begin
              FMyForm.cbbUPSLVyzov.ItemIndex := 1;
            end;
          $02:
            begin
              FMyForm.cbbUPSLVyzov.ItemIndex := 2;
            end;
          $04:
            begin
              FMyForm.cbbUPSLVyzov.ItemIndex := 3;
            end;
          $08:
            begin
              FMyForm.cbbUPSLVyzov.ItemIndex := 4;
            end;
          $10:
            begin
              FMyForm.cbbUPSLVyzov.ItemIndex := 5;
            end;
          $40:
            begin
              FMyForm.cbbUPSLVyzov.ItemIndex := 6;
            end
        else
          Exit;
        end;

        TA := TArray<Byte>.Create($D8, $84, $00, $00);
      end;

    PCKT_CURRENT:
      begin
      // Чтение текущих данных устройства
        upsl_b := 0;
        upsl_ch := 0;
        if FMyForm.cbbUPSLVyzov.ItemIndex > 0 then
        begin
          upsl_b := 4; // вызов переговорной связи - CALL
          upsl_ch := FMyForm.cbbUPSLVyzov.ItemIndex - 1;
        end;

        TA := TArray<Byte>.Create($D8, $85, $07, $00 + upsl_b, upsl_ch, $BB, $0C, $08, $00, $00, $00);
       // заполняется ТА(3)
        if FMyForm.chkNet.Checked then
          SetBit(TA[3], 7);

        if FMyForm.chkBat.Checked then
          SetBit(TA[3], 6);

        if FMyForm.chkAmp1.Checked then
          SetBit(TA[3], 5);

        if FMyForm.chkAmp2.Checked then
          SetBit(TA[3], 4);

        if FMyForm.chkFire.Checked then
          SetBit(TA[3], 3);

        // обработка PGS & DISP
        if FMyForm.cbbUPSLVyzov.ItemIndex = 5 then
        begin
          SetBit(TA[3], 1);    // PGS
          SetBit(TA[6], 4);    // DISP
          TA[4] and $C0;       // сброс CHANNEL
          TA[6] and $10;       // сброс ECAB, EROOF, EPIT, EMEL
        end;

        //  заполняется ТА(7)
        bat := StrToFloatDef(FMyForm.lbledtBat.Text, 0);
        TA[7] := Round(bat * 10000 / 176);

      end;
    PCKT_OPER:
      begin
      // чтение срочных данных устройства
        upsl_b := 0;
        upsl_ch := 0;

        if FMyForm.cbbUPSLVyzov.ItemIndex > 0 then
        begin
          upsl_b := 4;
          upsl_ch := FMyForm.cbbUPSLVyzov.ItemIndex - 1;
        end;
        TA := TArray<Byte>.Create($D8, $89, $03, $00 + upsl_b, upsl_ch, $00, $00);

        if FMyForm.chkNet.Checked then
          SetBit(TA[3], 7);

        if FMyForm.chkBat.Checked then
          SetBit(TA[3], 6);

        if FMyForm.chkAmp1.Checked then
          SetBit(TA[3], 5);

        if FMyForm.chkAmp2.Checked then
          SetBit(TA[3], 4);

        if FMyForm.chkFire.Checked then
          SetBit(TA[3], 3);
      end;
    PCKT_VERSION:
      begin
        TA := TArray<Byte>.Create($D8, $8D, $02, $00, $00, $00);
        // Чтение версии устройства
        ver := FMyForm.medtVer.EditText;
        TA[3] := Fetch(ver,'.').ToInteger;
        TA[4] := ver.ToInteger;
      end;

  else
    Exit;
  end;


  // устанавливаю правильный адрес устройства в первый байт
  TA[0] := $D8 + FMyForm.seNumber.Value;

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

