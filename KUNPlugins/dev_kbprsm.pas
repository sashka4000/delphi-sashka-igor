unit dev_kbprsm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Samples.Spin, dev_base_form, ext_global, Vcl.Buttons,
  DateUtils;

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
    lbl12: TLabel;
    seKBP_KUN: TSpinEdit;
    lbl1: TLabel;
    chkPower220: TCheckBox;
    procedure cbbKBPRSMVyzovChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TKBPRSM = class(TBaseDevice)
    PRPGS: BOOLEAN;                     // ���� ����������� �������� ���
    PGSON: Boolean;                    // ���� ��������� ��� - �����������
    AlertDate: BOOLEAN;                 // ���� ������� ������� ������
    constructor Create(F: TFrmBaseClass);
    function Serialize (LoadSave: Integer; P: PChar; var PSize : DWORD): HRESULT; override; stdcall;
    function OnDataReceive(pd: PByte; PacketSize: Integer; MaxSize: Integer; var AnswerSize: Integer): HRESULT; override; stdcall;
  end;

const
  gKBPRSM: TGUID = '{F5A76306-E115-4A9C-BF05-1244CDE385ED}';  // ���������� �������������, ������������ �� Ctrl+Shift+G

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
  // �������������� ��������� � ���� ������ ����
  TR := TArray<Byte>(pd);

  // �������� CRC ������
  if GET_CRC(TR, PacketSize) <> TR[PacketSize - 1] then
    Exit;
  // �������� ����� ���������� � ������ �����
  if TR[0] <> $C8 + FMyForm.seNumber.Value then
    Exit;


  // �������� ����� �� ������

  case TR[1] of

    PCKT_TYPE:
      begin
        // ��������� ��������� ������� ���� ����������
        TA := TArray<Byte>.Create($C8, $81, $03, $06, $03, $00, $00);
        if FDevTimeSync then
          SetBit(TA[5], 0);  // ���� � ��������� �������
        if AlertDate then
        begin
          AlertDate := False;
          SetBit(TA[5], 1);  // ��������� ������� ������
        end;
      end;

    PCKT_WRITE_TIME:
      begin
        //������ ������� ����������
        FDevTimeSync := True;
        FDevTime := EncodeDateTime(TR[8] + 2000, TR[7], TR[6], TR[5], TR[4], TR[3], 0);
        FCompTime := Now;
        DecodeDate(FDevTime, Y, MM, D);
        DecodeTime(FDevTime, H, M, S, MS);
        TA := TArray<Byte>.Create($C8, $82, $06, S, M, H, D, MM, (Y - 2000), $00);
      end;

    PCKT_READ_TIME:
      begin
        //������ ������� ����������
        FTime := (Now - FCompTime) + FDevTime;
        DecodeDate(FTime, Y, MM, D);
        DecodeTime(FTime, H, M, S, MS);
        TA := TArray<Byte>.Create($C8, $83, $06, S, M, H, D, MM, (Y - 2000), $00);
      end;

    PCKT_WRITE_DATA:
      begin
        //������ ������� ������ ����������
        TA := TArray<Byte>.Create($C8, $84, $02, $FF, $00, $00);
        PRPGS := IsBitSet(TR[3], 7);
        // ���� ������ ������� �� ��������� ��� - ������ ��������� PG3...PG1
        // ���������� ���� �� ������������ cbbKBPRSMVyzov
        PGSON := False;
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

        if not PGSON then
         PRPGS := False;

        if PRPGS then
         SetBit(TA[4], 7);


        // ��������� ����������� ��������� �� ������ ���
        FMyForm.cbbKBPRSMVyzov.Enabled := not PGSON;

      // ����������
        FMyForm.btnON4.Down := IsBitSet(TR[3], 3);
        if FMyForm.btnON4.Down then
          SetBit(TA[4], 3);
        FMyForm.btnON3.Down := IsBitSet(TR[3], 2);
        if FMyForm.btnON3.Down then
          SetBit(TA[4], 2);
        FMyForm.btnON2.Down := IsBitSet(TR[3], 1);
        if FMyForm.btnON2.Down then
          SetBit(TA[4], 1);
        FMyForm.btnON1.Down := IsBitSet(TR[3], 0);
        if FMyForm.btnON1.Down then
          SetBit(TA[4], 0);
      end;
    PCKT_CURRENT:
      begin
       // ������ ������� ������ ����������
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
        if FMyForm.chkPower220.Checked then
          SetBit(TA[3], 0);

        if not PGSON then
        begin
          // ���� ������ �� �������� ���, �� ������� ��� ���� ������ ������
          // �����
          case FMyForm.cbbKBPRSMVyzov.ItemIndex of
            1:
              SetBit(TA[4], 0);
            2:
              SetBit(TA[4], 1);
            3:
              SetBit(TA[4], 2);
          end;
        end
        else
        begin

          case FMyForm.cbbKBPRSMVyzov.ItemIndex of
            1:
              SetBit(TA[5], 4);
            2:
              SetBit(TA[5], 5);
            3:
              SetBit(TA[5], 6);
          end;

          if PRPGS then
           SetBit(TA[5], 7);
        end;

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
        // ������ ������� ������ ����������
        TA := TArray<Byte>.Create($C8, $89, $02, $0C, $00, $00);

        // ��������� ������ �1...�3 ��� ��������� ���
        if not (PRPGS) then
        begin
          case FMyForm.cbbKBPRSMVyzov.ItemIndex of
            1:
              SetBit(TA[3], 4);
            2:
              SetBit(TA[3], 5);
            3:
              SetBit(TA[3], 6);
          end;
        end;

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
        if FMyForm.chkPower220.Checked then
          SetBit(TA[4], 0);
        // ���� ��������� ������� ������
        if ((TA[3] and $73) or (TA[4] and $7F)) > 0 then
          AlertDate := True;

      end

  else
    Exit;
  end;

  // ������������ ���������� ����� ���������� � ������ ����
  TA[0] := $C8 + FMyForm.seNumber.Value;

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

function TKBPRSM.Serialize(LoadSave: Integer; P: PChar;
  var PSize: DWORD): HRESULT;
var
  FMyForm: TfrmKBPRSM;
begin
 FMyForm := TfrmKBPRSM(MyForm);
 if LoadSave = 0 then
 begin
   Result := inherited;
   FMyForm.seNumber.Text := FDeviceSettingsList.Values ['Address'];
 end else
 begin
   FDeviceSettingsList.Clear;
   FDeviceSettingsList.AddPair ('Address', FMyForm.seNumber.Text);
   Result := inherited;
 end;
end;

procedure TfrmKBPRSM.cbbKBPRSMVyzovChange(Sender: TObject);
begin
  if (seKBP_KUN.Value > 0) and (cbbKBPRSMVyzov.ItemIndex > 0) then
    CallBack(seKBP_KUN.Value, 0);
end;

end.

