unit dev_ksl_otis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  dev_base_form, ext_global;

type
  TfrmKSL = class(TfrmBase)
    cbbError: TComboBox;
    chkNoLift: TCheckBox;
    seNumber: TSpinEdit;
    seFloor: TSpinEdit;
    lbl8: TLabel;
    lbl17: TLabel;
    lbl1: TLabel;
    procedure chkNoLiftClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 TKSLOTis = class (TBaseDevice)
   function OnDataReceive (pd : PByte; PacketSize : Integer; MaxSize : Integer;  var AnswerSize : Integer) : HRESULT; override; stdcall;
  end;

const
  gKSLOtis : TGUID =  '{61542E8A-1835-4D17-8509-980C5A7E56E4}';  // √лобальный идентификатор, генерируютс€ по Ctrl+Shift+G

implementation
Uses System.DateUtils;

{$R *.dfm}

{ TKSLOTis }

function TKSLOTis.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer;
  var AnswerSize: Integer): HRESULT;
var
  FMyForm : TfrmKSL;
  TR, TA: TArray<Byte>;
  FTime: TDateTime;
  Y, MM, D, H, M, S, MS: Word;
begin
  Result := inherited;


  FMyForm := TfrmKSL(MyForm);

  // преобразование указател€ к типу массив байт
  TR := TArray<Byte>(pd);

  // провер€ю CRC пакета
  if GET_CRC(TR, PacketSize) <> TR[PacketSize - 1] then
    Exit;
  // провер€ю адрес устройства в первом байте
  if TR[0] <> $D0 + FMyForm.seNumber.Value then
    Exit;

  case TR[1] of
    PCKT_TYPE:
      begin
        TA := TArray<Byte>.Create ($D0,$81,$03,$07,$01,$02,$A0);
      end;
    PCKT_READ_TIME:
      begin
     //„тение времени устройства
        FTime := (Now - FCompTime) + FDevTime;
        DecodeDate(FTime, Y, MM, D);
        DecodeTime(FTime, H, M, S, MS);
        TA := TArray<Byte>.Create($D8, $83, $06, S, M, H, D, MM, (Y - 2000), $00);
      end;
    PCKT_WRITE_TIME:
      begin
     //«апись времени устройства
        FDevTimeSync := True;
        FDevTime := EncodeDateTime(TR[8] + 2000, TR[7], TR[6], TR[5], TR[4], TR[3], 0);
        FCompTime := Now;
        DecodeDate(FDevTime, Y, MM, D);
        DecodeTime(FDevTime, H, M, S, MS);
        TA := TArray<Byte>.Create($D8, $82, $06, S, M, H, D, MM, (Y - 2000), $00);
      end;
    PCKT_VERSION:
      begin
        TA := TArray<Byte>.Create ($D0,$8D,$02,$01,$10,$00);
      end;
    PCKT_OPER:
      begin
         if FMyForm.chkNoLift.Checked
           then
              TA := TArray<Byte>.Create ($D0,$89,$01,$08,$00)
           else
           begin
             case FMyForm.cbbError.ItemIndex of
              0: TA := TArray<Byte>.Create ($D0,$89,$05,$08,FMyForm.seFloor.Value,$6F,$2B,$05,$00);   // OTIS
              1: TA := TArray<Byte>.Create ($D0,$89,$07,$08,FMyForm.seFloor.Value,$6F,$2B,$05,$6D,$B6,$00);
              2: TA := TArray<Byte>.Create ($D0,$89,$07,$08,FMyForm.seFloor.Value,$6F,$2B,$05,$DC,$2C,$00);
             end;
           end;
      end;
     else
       Exit;
  end;

  // устанавливаю правильный адрес устройства в первый байт
  TA[0] := $D0 + FMyForm.seNumber.Value;

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

procedure TfrmKSL.chkNoLiftClick(Sender: TObject);
begin
  cbbError.Enabled := not chkNoLift.Checked;
  seFloor.Enabled    := not chkNoLift.Checked;
  lbl8.Enabled       := not chkNoLift.Checked;
end;

end.
