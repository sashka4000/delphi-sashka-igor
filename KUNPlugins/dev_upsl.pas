unit dev_upsl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls,
  Vcl.Samples.Spin, ext_global, dev_base_form, Vcl.CheckLst, Vcl.ExtCtrls, DateUtils;

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
    chkAmp1: TCheckBox;
    chkAmp2: TCheckBox;
    lbledtBat: TLabeledEdit;
    procedure cbbUPSLVyzovChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TUPSL = class(TBaseDevice)
    function OnDataReceive(pd: PByte; PacketSize: Integer; MaxSize: Integer; var AnswerSize: Integer): HRESULT; override; stdcall;
  end;

const
  gUPSLM: TGUID = '{24D56126-A92C-417A-AA7A-9BCB8551D775}';  // ���������� �������������, ������������ �� Ctrl+Shift+G

implementation

{$R *.dfm}

{ TUPSL }

function TUPSL.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer; var AnswerSize: Integer): HRESULT;
var
  TR, TA: TArray<Byte>;
  bSendAnswer: Boolean;
  upsl_b, upsl_ch: Byte;
  tmp: string;
  FMyForm: TfrmUPSL;
  bat: Double;
  batInt: Integer;
  i: Integer;
  FTime: TDateTime;
  Y, MM, D, H, M, S, MS: Word;
begin
  inherited;

  FMyForm := TfrmUPSL(MyForm);
  // �������������� ��������� � ���� ������ ����
  TR := TArray<Byte>(pd);

  // �������� CRC ������
  if GET_CRC(TR, PacketSize) <> TR[PacketSize - 1] then
    Exit;

  // �������� ����� ���������� � ������ �����
  if TR[0] <> $D8 + FMyForm.seNumber.Value then
    Exit;

  // �������� ����� �� ������

  case TR[1] of
    PCKT_TYPE:
      begin
  // ��������� ��������� ������� ���� ����������
        if not (FDevTimeSync) then
          TA := TArray<Byte>.Create($D8, $81, $03, $08, $03, $00, $00)
        else
          TA[5] := 1;
      end;
    PCKT_CURRENT:
      begin
        TA := TArray<Byte>.Create($D8, $85, $05, $00, upsl_ch, $BB, $0C, $08, $00);
       // ����������� ��(3)
        if FMyForm.chkNet.Checked then
          SetBit(TA[3], 7);

        if FMyForm.chkBat.Checked then
          SetBit(TA[3], 6);

        if FMyForm.chkAmp1.Checked then
          SetBit(TA[3], 5);

        if FMyForm.chkAmp2.Checked then
          SetBit(TA[3], 4);
      //  ����������� ��(5)

        bat := StrToFloatDef(FMyForm.lbledtBat.Text, 0);
        TA[5] := Round(bat * 1000 / 67);

        upsl_b := 0;
        upsl_ch := 0;
        if FMyForm.cbbUPSLVyzov.ItemIndex > 0 then
        begin
          upsl_b := 4;
          upsl_ch := FMyForm.cbbUPSLVyzov.ItemIndex - 1;
        end;

        TA[3] := TA[3] + upsl_b;
      end;
    PCKT_OPER:
      begin
        upsl_b := 0;
        upsl_ch := 0;
        if FMyForm.cbbUPSLVyzov.ItemIndex > 0 then
        begin
          upsl_b := 4;
          upsl_ch := FMyForm.cbbUPSLVyzov.ItemIndex - 1;
        end;
        TA := TArray<Byte>.Create($D8, $89, $02, $F0 + upsl_b, upsl_ch, $00);
      end;
    PCKT_VERSION:
      begin
        TA := TArray<Byte>.Create($D8, $8D, $02, $01, $23, $00);
      end;
    PCKT_READ_TIME:
      begin
     //������ ������� ����������
        FTime := (Now - FCompTime) + FDevTime;
        DecodeDate(FTime, Y, MM, D);
        DecodeTime(FTime, H, M, S, MS);
        TA := TArray<Byte>.Create($D8, $83, $06, S, M, H, D, MM, (Y - 2000), $00);
      end;
    PCKT_WRITE_TIME:
      begin
     //������ ������� ����������
        FDevTimeSync := True;
        FDevTime := EncodeDateTime(TR[8] + 2000, TR[7], TR[6], TR[5], TR[4], TR[3], 0);
        FCompTime := Now;
        DecodeDate(FDevTime, Y, MM, D);
        DecodeTime(FDevTime, H, M, S, MS);
        TA := TArray<Byte>.Create($D8, $82, $06, S, M, H, D, MM, (Y - 2000), $00);
      end
  else
    Exit;
  end;

  // ������������ ���������� ����� ���������� � ������ ����
  TA[0] := $D8 + FMyForm.seNumber.Value;

  AnswerSize := Length(TA);

  // �������� ��� ����� �� �������� ������ ������
  if AnswerSize > MaxSize then
  begin
    Result := 1;
    Exit;
  end;

  // ���������� �����
  CRC(TA, AnswerSize);

  // ��������� ����� ������ �� �������� �����
  move(TA[0], TR[0], AnswerSize);
end;

procedure TfrmUPSL.cbbUPSLVyzovChange(Sender: TObject);
begin
  if (seUPSL_KUN.Value > 0) and (cbbUPSLVyzov.ItemIndex > 0) then
    CallBack(seUPSL_KUN.Value, 0);
end;
end.

