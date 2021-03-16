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
  gKIR16RS: TGUID = '{C8B1EF56-D63C-4711-B44A-AE6E7024286A}';  // ���������� �������������, ������������ �� Ctrl+Shift+G

implementation

{$R *.dfm}
uses
  IdGlobal, ext_global;

{ TKIR16RS }

function TKIR16RS.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer; var AnswerSize: Integer): HRESULT;
var
  TR, TA: TArray<Byte>;
  bSendAnswer: Boolean;
  tmp: string;
  FMyForm: TfrmKIR16RS;
  bat: Double;
  batInt: Integer;
  i: Integer;
  ver: string;
  FTime: TDateTime;
  Y, MM, D, H, M, S, MS: Word;
begin
  Result := inherited;
  FMyForm := TfrmKIR16RS(MyForm);
  // �������������� ��������� � ���� ������ ����
  TR := TArray<Byte>(pd);

  // �������� CRC ������
  if GET_CRC(TR, PacketSize) <> TR[PacketSize - 1] then
    Exit;
  // �������� ����� ���������� � ������ �����
  if TR[0] <> $80 + FMyForm.seNumber.Value then
    Exit;


  // �������� ����� �� ������

  case TR[1] of
    PCKT_TYPE:
      begin
  // ��������� ��������� ������� ���� ����������
        TA := TArray<Byte>.Create($80, $81, $03, $0A, $03, $01, $00);
         if FDevTimeSync then
          ResetBit(TA[5],0);
      // SetBit(TA[5],1); ���� ���������� ��������� ����������� ����� ��� ���
      end;

    PCKT_WRITE_TIME:
      begin
     //������ ������� ����������
        FDevTimeSync := True;
        FDevTime := EncodeDateTime(TR[8] + 2000, TR[7], TR[6], TR[5], TR[4], TR[3], 0);
        FCompTime := Now;
        DecodeDate(FDevTime, Y, MM, D);
        DecodeTime(FDevTime, H, M, S, MS);
        TA := TArray<Byte>.Create($80, $82, $06, S, M, H, D, MM, (Y - 2000), $00);
      end;

    PCKT_READ_TIME:
      begin
     //������ ������� ����������
        FTime := (Now - FCompTime) + FDevTime;
        DecodeDate(FTime, Y, MM, D);
        DecodeTime(FTime, H, M, S, MS);
        TA := TArray<Byte>.Create($80, $83, $06, S, M, H, D, MM, (Y - 2000), $00);
      end;

    PCKT_CURRENT:
      begin
        SetLength(TA, 83);
        TA[0] := $80;
        TA[1] := $85;
        TA[2] := $4F;

      end;

    PCKT_OPER:
      begin


        TA := TArray<Byte>.Create($D8, $89, $02, $00 ,$00  , $00);

      end;

    PCKT_VERSION:
      begin
        TA := TArray<Byte>.Create($80, $8D, $02, $00, $00, $00);
        // ������ ������ ����������
        ver := FMyForm.medtVer.EditText;
        TA[3] := Fetch(ver, '.').ToInteger;
        TA[4] := ver.ToInteger;
      end;

    PCKT_WRITE_DATA:
      begin
     //������ ������� ������ ����������

        TA := TArray<Byte>.Create($D8, $84, $00, $00);
      end
  else
    Exit;
  end;

  // ������������ ���������� ����� ���������� � ������ ����
  TA[0] := $80 + FMyForm.seNumber.Value;

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




// ������������ ��������� ����� � ���������� TStringGrid
procedure TfrmKIR16RS.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  with SG do
  begin
    ColWidths[0] := 40;
    ColWidths[1] := 95;
    for i := 1 to 17 do
    begin
      Cells[0, i] := i.ToString;

    end;
    Cells[0, 0] := '����';
    Cells[1, 0] := '����� ���������';
    Cells[2, 0] := '��������� ������';
  end;

end;

end.

