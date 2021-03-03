unit dev_upsl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.Samples.Spin,
  ext_global, dev_base_form, Vcl.CheckLst, Math;

type

  TfrmUPSL = class(TfrmBase)
    seUPSL_KUN: TSpinEdit;
    cbbUPSLVyzov: TComboBox;
    lbl17: TLabel;
    lbl21: TLabel;
    lbl12: TLabel;
    seNumber: TSpinEdit;
    lbl1: TLabel;
    chklstType: TCheckListBox;
    procedure cbbUPSLVyzovChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


 TUPSL = class (TBaseDevice)
   function OnDataReceive (pd : PByte; PacketSize : Integer; MaxSize : Integer;  var AnswerSize : Integer) : HRESULT; override; stdcall;
  end;

const
  gUPSLM : TGUID =  '{24D56126-A92C-417A-AA7A-9BCB8551D775}';  // √лобальный идентификатор, генерируютс€ по Ctrl+Shift+G


implementation

{$R *.dfm}

{ TUPSL }

function TUPSL.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer;
  var AnswerSize: Integer): HRESULT;
var
 TR, TA : TArray<Byte>;
 bSendAnswer : Boolean;
 upsl_b, upsl_ch : Byte;
 tmp : string;
 i,s : Integer;
 FMyForm :  TfrmUPSL;
begin
  inherited;

  FMyForm := TfrmUPSL (MyForm);
  // преобразование указател€ к типу массив байт
  TR := TArray<Byte>(pd);

  // провер€ю CRC пакета
  if GET_CRC(TR, PacketSize) <> TR[PacketSize - 1] then
      Exit;

  // провер€ю адрес устройства в первом байте
  if TR[0] <> $D8 + FMyForm.seNumber.Value then
    Exit;

  // формирую ответ на запрос

  case TR[1] of
    PCKT_TYPE :
    begin
//      TA := TArray<Byte>.Create ($D8,$81,$03,$08,TA[4],TA[5],$00);

  // ќбработка состо€ни€ запроса типа устройства
   TA := TArray<Byte>.Create ($D8,$81,$03,$08,$00,$00,$00);
   s := 0;
     for i := 0 to 3 do
     begin
       if FMyForm.chklstType.Checked[i] then
          s := s + Trunc(Power(2,i))
     end;
//     TA[4] :=;

  //
    end;
    PCKT_CURRENT :
    begin
       upsl_b := 0;  upsl_ch := 0;
       if FMyForm.cbbUPSLVyzov.ItemIndex > 0  then
       begin
         upsl_b := 4;
         upsl_ch := FMyForm.cbbUPSLVyzov.ItemIndex - 1;
       end;
       TA := TArray<Byte>.Create ($D8,$85,$05,$F0+upsl_b,upsl_ch,$BB,$0C,$08,$00);
    end;
    PCKT_OPER :
    begin
         upsl_b := 0;  upsl_ch := 0;
         if FMyForm.cbbUPSLVyzov.ItemIndex > 0  then
         begin
           upsl_b := 4;
           upsl_ch := FMyForm.cbbUPSLVyzov.ItemIndex - 1;
         end;
         TA := TArray<Byte>.Create ($D8,$89,$02,$F0+upsl_b,upsl_ch,$00);
    end;
    PCKT_VERSION :
    begin
      TA := TArray<Byte>.Create ($D8,$8D,$02,$01,$23,$00);
    end
    else
     Exit;
  end;

  // устанавливаю правильный адрес устройства в первый байт
  TA[0] := $D8 + FMyForm.seNumber.Value;

  AnswerSize := Length(TA);

  // провер€ю что ответ не превысил размер буфера
  if AnswerSize > MaxSize then
  begin
   Result := 1;
   Exit;
  end;

  // подписываю буфер
  CRC (TA,AnswerSize);

  // записываю буфер ответа во вход€щий буфер
  move (TA[0], TR[0], AnswerSize);
end;

procedure TfrmUPSL.cbbUPSLVyzovChange(Sender: TObject);
begin
 if (seUPSL_KUN.Value > 0) and (cbbUPSLVyzov.ItemIndex > 0) then
   CallBack (seUPSL_KUN.Value,0);
end;


end.
