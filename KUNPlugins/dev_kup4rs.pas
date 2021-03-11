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
  gKUP4RS  : TGUID =  '{FA28155C-2CF0-4A5A-A4F9-723656F33218}';  // √лобальный идентификатор, генерируютс€ по Ctrl+Shift+G

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
  inherited;

  FMyForm := TfrmKUP4RS(MyForm);
  // преобразование указател€ к типу массив байт
  TR := TArray<Byte>(pd);

  // провер€ю CRC пакета
  if GET_CRC(TR, PacketSize) <> TR[PacketSize - 1] then
    Exit;
  // провер€ю адрес устройства в первом байте
  if TR[0] <> $E0 + FMyForm.seNumber.Value then
    Exit;


  // формирую ответ на запрос

  case TR[1] of
    PCKT_TYPE:
      begin
  // ќбработка состо€ни€ запроса типа устройства
        TA := TArray<Byte>.Create($E0, $81, $03, $09, $00, $00, $00);

      end;

          PCKT_WRITE_DATA:
      begin
       TA := TArray<Byte>.Create($E0, $84, $06, $00, $00, $00, $00, $00, $00, $00);


      end;

    PCKT_VERSION:
      begin
        TA := TArray<Byte>.Create($E0, $8D, $02, $00, $00, $00);
        // „тение версии устройства
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

procedure TfrmKUP4RS.chkPowLineClick(Sender: TObject);
begin
//  inherited;
 if chkPowLine.Checked then
    chkPowLine.Caption := 'ѕитание от внешнего источника'
    else
     chkPowLine.Caption := 'ѕитание от сети'
end;

end.
