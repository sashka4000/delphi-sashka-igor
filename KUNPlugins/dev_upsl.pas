unit dev_upsl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls,
  Vcl.Samples.Spin, ext_global, dev_base_form, Vcl.CheckLst, Vcl.ExtCtrls, DateUtils, Vcl.Mask;

type
  TfrmUPSL = class(TfrmBase)
    seUPSL_KUN: TSpinEdit;
    cbbUPSLVyzov: TComboBox;
    lbl17: TLabel;
    lbl21: TLabel;
    lbl12: TLabel;
    seNumber: TSpinEdit;
    lbl1: TLabel;
    chkNet: TCheckBox;
    chkBat: TCheckBox;
    lbledtBat: TLabeledEdit;
    chkAmp1: TCheckBox;
    chkAmp2: TCheckBox;
    chkFire: TCheckBox;
    lblVer: TLabel;
    cbbVersion: TComboBox;
    procedure cbbUPSLVyzovChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TUPSL = class(TBaseDevice)
    DISP : BOOLEAN;
    constructor Create(F: TFrmBaseClass);
    function OnDataReceive(pd: PByte; PacketSize: Integer; MaxSize: Integer; var AnswerSize: Integer): HRESULT; override; stdcall;
  end;

const
  gUPSL: TGUID = '{24D56126-A92C-417A-AA7A-9BCB8551D775}';  // Глобальный идентификатор, генерируются по Ctrl+Shift+G

implementation

{$R *.dfm}
Uses IdGlobal;
{ TUPSL }

constructor TUPSL.Create(F: TFrmBaseClass);
begin
  inherited;
  DISP := FALSE;
end;

function TUPSL.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer; var AnswerSize: Integer): HRESULT;
var
  TR, TA: TArray<Byte>;
  bSendAnswer: Boolean;
  tmp: string;
  FMyForm: TfrmUPSL;
  bat: Double;
  batInt: Integer;
  i: Integer;
  ver : string;
  FTime: TDateTime;
  Y, MM, D, H, M, S, MS: Word;
begin
  Result := inherited;

  FMyForm := TfrmUPSL(MyForm);
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
          TA[5] := 1;
        if not (FMyForm.chkNet.Checked and FMyForm.chkBat.Checked
         and FMyForm.chkAmp1.Checked and FMyForm.chkAmp2.Checked and FMyForm.chkFire.Checked) then
          TA[5] := TA[5] + 2;
      end;
    PCKT_CURRENT:
      begin
        TA := TArray<Byte>.Create($D8, $85, $05, $00, $00, $BB, $0C, $08, $00);
        if FMyForm.cbbUPSLVyzov.ItemIndex > 0 then
        begin
           if DISP
          then SetBit(TA[3], 1)      // PGS = 1
          else SetBit(TA[3], 2);     // CALL = 1
          TA[4] := FMyForm.cbbUPSLVyzov.ItemIndex - 1;
        end;


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

        //  заполняется ТА(5)
        bat := StrToFloatDef(StringReplace(FMyForm.lbledtBat.Text, '.', FS.DecimalSeparator, [rfReplaceAll]), 0);
        TA[5] := Round(bat * 1000 / 67);

      end;
    PCKT_OPER:
      begin
        TA := TArray<Byte>.Create($D8, $89, $02, $00, $00, $00);

        if FMyForm.cbbUPSLVyzov.ItemIndex > 0 then
        begin
          if DISP
          then SetBit(TA[3], 1)      // PGS = 1
          else SetBit(TA[3], 2);     // CALL = 1
          TA[4] := FMyForm.cbbUPSLVyzov.ItemIndex - 1;
        end;

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
        ver := FMyForm.cbbVersion.Text;
        TA[3] := Fetch(ver,'.').ToInteger;
        TA[4] := ver.ToInteger;
      end;
    PCKT_READ_TIME:
      begin
     //Чтение времени устройства
        FTime := (Now - FCompTime) + FDevTime;
        DecodeDate(FTime, Y, MM, D);
        DecodeTime(FTime, H, M, S, MS);
        TA := TArray<Byte>.Create($D8, $83, $06, S, M, H, D, MM, (Y - 2000), $00);
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
    PCKT_WRITE_DATA:
      begin
     //Запись текущих данных устройства
        DISP := GetBit (TR[3],4) = 1;
        case TR[3] and $0F of
          0:
            begin
             FMyForm.cbbUPSLVyzov.ItemIndex := 0 ;
            end;
          1:
            begin
             FMyForm.cbbUPSLVyzov.ItemIndex := 1 ;
            end;
          2:
            begin
              FMyForm.cbbUPSLVyzov.ItemIndex := 2 ;
            end;
          4:
            begin
              FMyForm.cbbUPSLVyzov.ItemIndex := 3 ;
            end;
          8:
            begin
              FMyForm.cbbUPSLVyzov.ItemIndex := 4 ;
            end
        else
          Exit;
        end;
        TA := TArray<Byte>.Create($D8, $84, $00, $00);
      end
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

procedure TfrmUPSL.cbbUPSLVyzovChange(Sender: TObject);
begin
  if (seUPSL_KUN.Value > 0) and (cbbUPSLVyzov.ItemIndex > 0) then
    CallBack(seUPSL_KUN.Value, 0);
end;
end.

