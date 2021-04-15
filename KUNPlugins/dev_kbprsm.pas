unit dev_kbprsm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, dev_base_form, ext_global;

type
  TfrmKBPRSM = class(TfrmBase)
    lblName: TLabel;
    seUPSL_KUN: TSpinEdit;
    cbbKBPRSMVyzov: TComboBox;
    seNumber: TSpinEdit;
    chkNet: TCheckBox;
    chkAmp1: TCheckBox;
    lblkbprsm: TLabel;
    lbl12: TLabel;
    lbl1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

   TKBPRSM = class(TBaseDevice)

    function OnDataReceive(pd: PByte; PacketSize: Integer; MaxSize: Integer; var AnswerSize: Integer): HRESULT; override; stdcall;
  end;

const
  gKBPRSM: TGUID = '{F5A76306-E115-4A9C-BF05-1244CDE385ED}';  // Глобальный идентификатор, генерируются по Ctrl+Shift+G


var
  frmKBPRSM: TfrmKBPRSM;

implementation


{$R *.dfm}

function TKBPRSM.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer; var AnswerSize: Integer): HRESULT;
var
  TR, TA: TArray<Byte>;
  cb: TCheckBox;
  bSendAnswer: Boolean;
  tmp: string;
  FMyForm: TfrmKBPRSM;
  bat: Double;
  batInt: Integer;
  i: Integer;
  ver: string;
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
  if TR[0] <> $D8 + FMyForm.seNumber.Value then
    Exit;


  // формирую ответ на запрос

//  case TR[1] of
//
//    PCKT_TYPE:
//      begin
//        // Обработка состояния запроса типа устройства
//        TA := TArray<Byte>.Create($D8, $81, $03, $08, $03, $00, $00);
//        if FDevTimeSync then
//          SetBit(TA[5], 0);  // часы и календарь валидны
//        if not (FMyForm.chkNet.Checked and FMyForm.chkBat.Checked
//         and FMyForm.chkAmp1.Checked and FMyForm.chkAmp2.Checked
//         and FMyForm.chkFire.Checked) then
//          SetBit(TA[5], 1);  // появились срочные данные
//      end;
//
//    PCKT_WRITE_TIME:
//      begin
//        //Запись времени устройства
//        FDevTimeSync := True;
//        FDevTime := EncodeDateTime(TR[8] + 2000, TR[7], TR[6], TR[5], TR[4], TR[3], 0);
//        FCompTime := Now;
//        DecodeDate(FDevTime, Y, MM, D);
//        DecodeTime(FDevTime, H, M, S, MS);
//        TA := TArray<Byte>.Create($D8, $82, $06, S, M, H, D, MM, (Y - 2000), $00);
//      end;
//
//    PCKT_READ_TIME:
//      begin
//        //Чтение времени устройства
//        FTime := (Now - FCompTime) + FDevTime;
//        DecodeDate(FTime, Y, MM, D);
//        DecodeTime(FTime, H, M, S, MS);
//        TA := TArray<Byte>.Create($D8, $83, $06, S, M, H, D, MM, (Y - 2000), $00);
//      end;
//
//    PCKT_WRITE_DATA:
//      begin
//        DISP := IsBitSet(TR[3], 4);
//
//        //Запись текущих данных устройства
//        case (TR[3] and $2F) of
//          $00:
//            begin
//              FMyForm.cbbUPSLVyzov.ItemIndex := 0;
//            end;
//          $01:
//            begin
//             if DISP then
//               FMyForm.cbbUPSLVyzov.ItemIndex := 1;
//            end;
//          $02:
//            begin
//             if DISP then
//              FMyForm.cbbUPSLVyzov.ItemIndex := 2;
//            end;
//          $04:
//            begin
//             if DISP then
//              FMyForm.cbbUPSLVyzov.ItemIndex := 3;
//            end;
//          $08:
//            begin
//             if DISP then
//              FMyForm.cbbUPSLVyzov.ItemIndex := 4;
//            end;
//          $20:
//            begin
//             if DISP then
//              FMyForm.cbbUPSLVyzov.ItemIndex := 5;
//            end;
//        end;
//
//        if not DISP then
//           FMyForm.cbbUPSLVyzov.ItemIndex := 0;
//
//        if IsBitSet(TR[3], 6) then
//          FMyForm.chkTST_OK.Checked := True;
//
//        ManualTESTGGS := DISP and IsBitSet(TR[3], 7);
//
//        TA := TArray<Byte>.Create($D8, $84, $00, $00);
//      end;
//
//    PCKT_CURRENT:
//      begin
//       // Чтение текущих данных устройства
//        TA := TArray<Byte>.Create($D8, $85, $08, $00, $00, $00, $00, $00, $18, $00, $00, $00);
//
//       // заполняется ТА(3) & TA[4]-CHANEL
//        if FMyForm.cbbUPSLVyzov.ItemIndex > 0 then
//        begin
//          begin
//            if DISP then
//              SetBit(TA[3], 1)      // PGS = 1
//            else
//              SetBit(TA[3], 2);     // CALL = 1
//            TA[4] := FMyForm.cbbUPSLVyzov.ItemIndex - 1;
//          end;
//        end;
//
//        if FMyForm.chkNet.Checked then
//          SetBit(TA[3], 7);
//
//        if FMyForm.chkBat.Checked then
//          SetBit(TA[3], 6);
//
//        if FMyForm.chkAmp1.Checked then
//          SetBit(TA[3], 5);
//
//        if FMyForm.chkAmp2.Checked then
//          SetBit(TA[3], 4);
//
//        if FMyForm.chkFire.Checked then
//          SetBit(TA[3], 3);
//
//        // связь с индикатором IND инверсия
//        if not FMyForm.chkInd.Checked then
//          SetBit(TA[3], 0);
//
//        //  обрабатываем АКБ TA[5]
//        bat := StrToFloatDef(StringReplace (FMyForm.lbledtBat.Text,'.',FS.DecimalSeparator,[rfReplaceAll]), 0);
//        TA[5] := Round(bat * 10000 / 176);
//
//        // заполняем  ТА(7) если DISP- поступил в команде $04
//        if DISP then
//        begin
//          SetBit(TA[7], 4);
//          case FMyForm.cbbUPSLVyzov.ItemIndex - 1 of
//            $00:
//              begin
//                SetBit(TA[7], 0);
//              end;
//            $01:
//              begin
//                SetBit(TA[7], 1);
//              end;
//            $02:
//              begin
//                SetBit(TA[7], 2);
//              end;
//            $03:
//              begin
//                SetBit(TA[7], 3);
//              end;
//            $04:
//              begin
//                SetBit(TA[7], 5);
//              end;
//          end;
//
//        end;
//
//        // установлен бит TST
//          if FMyForm.chkTST_OK.Checked then
//            SetBit(TA[7], 6);
//
//        // результаты автоматической проверки
//        if FMyForm.chkA2_K2.Checked then
//          SetBit(TA[8], 7);
//
//        if FMyForm.chkA1_K2.Checked then
//          SetBit(TA[8], 6);
//
//        if FMyForm.chkA2_G2.Checked then
//          SetBit(TA[9], 7);
//
//        if FMyForm.chkA1_G2.Checked then
//          SetBit(TA[9], 3);
//
//        if FMyForm.chkA2_M2.Checked then
//          SetBit(TA[9], 6);
//
//        if FMyForm.chkA1_M2.Checked then
//          SetBit(TA[9], 2);
//
//        if FMyForm.chkA2_G1.Checked then
//          SetBit(TA[9], 5);
//
//        if FMyForm.chkA1_G1.Checked then
//          SetBit(TA[9], 1);
//
//        if FMyForm.chkA2_M1.Checked then
//          SetBit(TA[9], 4);
//
//        if FMyForm.chkA1_M1.Checked then
//          SetBit(TA[9], 0);
//
//        case FMyForm.cbbUPSLVyzov.ItemIndex of
//         0 :
//         begin
//           TA[10] := 0;
//         end;
//         1 :
//         begin
//           if DISP
//            then  TA[10] := 11
//            else  TA[10] := 13;
//         end;
//         2 :
//         begin
//           if DISP
//            then  TA[10] :=  8
//            else  TA[10] :=  10;
//         end;
//         3 :
//         begin
//           if DISP
//            then  TA[10] :=  5
//            else  TA[10] :=  7;
//         end;
//         4 :
//         begin
//           if DISP
//            then  TA[10] :=  2
//            else  TA[10] :=  4;
//         end;
//         5 :
//         begin
//           if DISP
//            then  TA[10] := 17
//            else  TA[10] := 18;
//         end;
//        end;
//
//        if ManualTESTGGS then
//          TA[10] := 19;
//
//        if FMyForm.chkFire.Checked then
//          TA[10] := 15;
//
//
//
//      end;
//    PCKT_OPER:
//      begin
//        // чтение срочных данных устройства
//        TA := TArray<Byte>.Create($D8, $89, $03, $00, $00, $00, $00);
//
//        // состояние бита  TA[3] & TA[4]-CHANEL
//        if FMyForm.cbbUPSLVyzov.ItemIndex > 0 then
//        begin
//          begin
//            if DISP then
//              SetBit(TA[3], 1)      // PGS = 1
//            else
//              SetBit(TA[3], 2);     // CALL = 1
//            TA[4] := FMyForm.cbbUPSLVyzov.ItemIndex - 1;
//          end;
//        end;
//
//        if FMyForm.chkNet.Checked then
//          SetBit(TA[3], 7);
//
//        if FMyForm.chkBat.Checked then
//          SetBit(TA[3], 6);
//
//        if FMyForm.chkAmp1.Checked then
//          SetBit(TA[3], 5);
//
//        if FMyForm.chkAmp2.Checked then
//          SetBit(TA[3], 4);
//
//        if FMyForm.chkFire.Checked then
//          SetBit(TA[3], 3);
//
//        // автоматическая проверка
//        if FMyForm.chkROMAutoPGS.Checked then
//          SetBit(TA[4], 4);
//
//        // связь с индикатором
//        if not FMyForm.chkInd.Checked then
//          SetBit(TA[3], 0);
//
//      // результаты автоматической проверки
//        if FMyForm.chkA2_K2.Checked then
//          SetBit(TA[4], 7);
//
//        if FMyForm.chkA1_K2.Checked then
//          SetBit(TA[4], 6);
//
//        if FMyForm.chkA2_G2.Checked then
//          SetBit(TA[5], 7);
//
//        if FMyForm.chkA1_G2.Checked then
//          SetBit(TA[5], 3);
//
//        if FMyForm.chkA2_M2.Checked then
//          SetBit(TA[5], 6);
//
//        if FMyForm.chkA1_M2.Checked then
//          SetBit(TA[5], 2);
//
//        if FMyForm.chkA2_G1.Checked then
//          SetBit(TA[5], 5);
//
//        if FMyForm.chkA1_G1.Checked then
//          SetBit(TA[5], 1);
//
//        if FMyForm.chkA2_M1.Checked then
//          SetBit(TA[5], 4);
//
//        if FMyForm.chkA1_M1.Checked then
//          SetBit(TA[5], 0);
//
//        // автоматическая проверка выполнена,результаты корректны
//        if FMyForm.chkTST_OK.Checked then
//          SetBit(TA[4], 5);
//      end;
//
//    PCKT_VERSION:
//      begin
//        TA := TArray<Byte>.Create($D8, $8D, $02, $00, $00, $00);
//        // Чтение версии устройства
//        ver := FMyForm.cbbVersion.Text;
//        TA[3] := Fetch(ver, '.').ToInteger;
//        TA[4] := ver.ToInteger;
//      end;
//
//    PCKT_WRITE_ROM_Dev:
//      begin
//        // запись ПЗУ настроек устройства
//        TA := TArray<Byte>.Create($D8, $8E, $00, $00);
//
//        if (TR[3] and $02) <> $02 then
//          FMyForm.chkROMAutoPGS.Checked := False
//        else
//          FMyForm.chkROMAutoPGS.Checked := True;
//
//        FMyForm.edtROMTimer.Text := (TR[4] and $1F).ToString;
//      end;
//
//    PCKT_READ_ROM_Dev:
//      begin
//        // чтение ПЗУ настроек устройства
//        TA := TArray<Byte>.Create($D8, $8F, $02, $0F, $00, $00);
//
//        if not FMyForm.chkROMAutoPGS.Checked then
//          ResetBit(TA[3], 1);
//
//        TA[4] := StrToIntDef(FMyForm.edtROMTimer.Text, 0) and $1F;
//      end
//
//  else
//    Exit;
//  end;
//

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
