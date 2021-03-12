unit dev_kup4rs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, ext_global, dev_base_form, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Samples.Spin, Vcl.Mask;

type
  TfrmKUP4RS = class(TfrmBase)
    lblIn: TLabel;
    lblSw: TLabel;
    btnIn1: TSpeedButton;
    btnIn2: TSpeedButton;
    btnIn3: TSpeedButton;
    btnIn4: TSpeedButton;
    btnIn5: TSpeedButton;
    btnIn6: TSpeedButton;
    btnIn7: TSpeedButton;
    btnIn8: TSpeedButton;
    btnSw1: TSpeedButton;
    btnSw2: TSpeedButton;
    btnSw3: TSpeedButton;
    btnSw4: TSpeedButton;
    lbl17: TLabel;
    seNumber: TSpinEdit;
    lblVer: TLabel;
    medtVer: TMaskEdit;
    chkPowLine: TCheckBox;
    procedure chkPowLineClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 TKUP4RS = class (TBaseDevice)
   function OnDataReceive (pd : PByte; PacketSize : Integer; MaxSize : Integer;  var AnswerSize : Integer) : HRESULT; override; stdcall;
  end;

const
  gKUP4RS  : TGUID =  '{FA28155C-2CF0-4A5A-A4F9-723656F33218}';  // Глобальный идентификатор, генерируются по Ctrl+Shift+G

implementation

{$R *.dfm}
Uses IdGlobal;
{ TKUP4RS }

function TKUP4RS.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer;
  var AnswerSize: Integer): HRESULT;
  var
  TR, TA: TArray<Byte>;
  bSendAnswer: Boolean;
  upsl_b, upsl_ch: Byte;
  tmp: string;
  FMyForm: TfrmKUP4RS;
  bat: Double;
  batInt: Integer;
  i: Integer;
  ver : string;
  FTime: TDateTime;
  Y, MM, D, H, M, S, MS: Word;
begin
  Result := inherited;

  FMyForm := TfrmKUP4RS(MyForm);
  // преобразование указателя к типу массив байт
  TR := TArray<Byte>(pd);

  // проверяю CRC пакета
  if GET_CRC(TR, PacketSize) <> TR[PacketSize - 1] then
    Exit;
  // проверяю адрес устройства в первом байте
  if TR[0] <> $E0 + FMyForm.seNumber.Value then
    Exit;


  // формирую ответ на запрос

  case TR[1] of
    PCKT_TYPE:
      begin
  // Обработка состояния запроса типа устройства
        TA := TArray<Byte>.Create($E0, $81, $03, $09, $00, $00, $00);

      end;

    PCKT_WRITE_DATA:
      begin
        TA := TArray<Byte>.Create($E0, $84, $06, TR[3], TR[4], $44, $44, $D4, $01, $00);

        if FMyForm.chkPowLine.Checked then
          TA[7] := TA[7] or $01
          else
          TA[7] := TA[7] and $FE;

        // Читаем состояние кнопок оптопар
        if FMyForm.btnIn5.Down then
          TA[5] := TA[5] and $BF;

        if FMyForm.btnIn6.Down then
          TA[5] := TA[5] and $FB;

        if FMyForm.btnIn7.Down then
          TA[6] := TA[6] and $BF;

        if FMyForm.btnIn8.Down then
          TA[6] := TA[6] and $FB;
       // Читаем состояние кнопок реле
        if FMyForm.btnSw1.Down then
          TA[5] := TA[5] + $10;

        if FMyForm.btnSw2.Down then
          TA[5] := TA[5] + $1;

        if FMyForm.btnSw3.Down then
          TA[6] := TA[6] + $10;

        if FMyForm.btnSw4.Down then
          TA[6] := TA[6] + $1;
        // Записываем состояние концентратора
        if FMyForm.btnIn1.Down then
          TA[7] := TA[7] and $FB;

        if FMyForm.btnIn2.Down then
          TA[7] := TA[7] and $EF;

        if FMyForm.btnIn3.Down then
          TA[7] := TA[7] and $BF;

        if FMyForm.btnIn4.Down then
          TA[7] := TA[7] and $7F;

       // Читаем команды во входном пакете
        for i := 0 to 1 do
        begin
          case TR[3 + i] of
            $01:
              begin
                TA[5 + i] := TA[5 + i] or $01;
              end;
            $02:
              begin
                TA[5 + i] := TA[5 + i] and $FE;
              end;
            $03:
              begin
                TA[5 + i] := TA[5 + i] or $01;
              end;

            $10:
              begin
                TA[5 + i] := TA[5 + i] or $10;
              end;
            $11:
              begin
                TA[5 + i] := TA[5 + i] or $11;
              end;
            $12:
              begin
                 TA[5 + i] := TA[5 + i] and $FE or $08;
              end;
            $13:
              begin
                TA[5 + i] := TA[5 + i] or $11;
              end;

            $20:
              begin
                TA[5 + i] := TA[5 + i] and $EF;
              end;
            $21:
              begin
                TA[5 + i] := TA[5 + i] or $01 and $EF;
              end;
            $22:
              begin
                TA[5 + i] := TA[5 + i] and $EE;
              end;
            $23:
              begin
                TA[5 + i] := TA[5 + i] or $01 and $EF;
              end;

            $30:
              begin
                TA[5 + i] := TA[5 + i] or $30;
              end;
            $31:
              begin
                TA[5 + i] := TA[5 + i] or $11;
              end;
            $32:
              begin
                TA[5 + i] := TA[5 + i] or $10 and $FE;
              end;
            $33:
              begin
                TA[5 + i] := TA[5 + i] or $11;
              end;
          end;
        end;

      end;

    PCKT_VERSION:
      begin
        TA := TArray<Byte>.Create($E0, $8D, $02, $00, $00, $00);
        // Чтение версии устройства
        ver := FMyForm.medtVer.EditText;
        TA[3] := Fetch(ver,'.').ToInteger;
        TA[4] := ver.ToInteger;
      end

  else
    Exit;
  end;

  // устанавливаю правильный адрес устройства в первый байт
  TA[0] := $E0 + FMyForm.seNumber.Value;

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

procedure TfrmKUP4RS.chkPowLineClick(Sender: TObject);
begin
//  inherited;
 if chkPowLine.Checked then
    chkPowLine.Caption := 'Питание от внешнего источника'
    else
     chkPowLine.Caption := 'Питание от сети'
end;

end.
