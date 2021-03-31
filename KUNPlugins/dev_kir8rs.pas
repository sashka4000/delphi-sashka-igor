unit dev_kir8rs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  dev_base_form, Vcl.Buttons, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.Grids,
  DateUtils;

type
  TfrmKIR8RS = class(TfrmBase)
    lblName: TLabel;
    CBSG1: TComboBox;
    cbbPow: TComboBox;
    SG: TStringGrid;
    seNumber: TSpinEdit;
    lblAKB: TLabel;
    lblSensor: TLabel;
    btnSensor: TSpeedButton;
    lblVer: TLabel;
    lblRate1: TLabel;
    lblRate2: TLabel;
    lblRateOne: TLabel;
    lblRateTwo: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SGSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure CBSG1Exit(Sender: TObject);
    procedure btnSensorClick(Sender: TObject);
    procedure CBSG1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FDevDataSend: Boolean;
    FDev_Count_record: Integer;  // ���������� �������
  end;

  TArcRecord = record
    RecTime: TDateTime;
    Sensor: Boolean;
    AKB: Byte;
  end;

  TKIR8RS = class(TBaseDevice)
    function OnDataReceive(pd: PByte; PacketSize: Integer; MaxSize: Integer; var AnswerSize: Integer): HRESULT; override; stdcall;
  end;

const
  gKIR8RS: TGUID = '{45ECF46A-AEE7-4B22-9305-6A60E388E425}';

implementation

{$R *.dfm}

uses
  IdGlobal, ext_global;

var
  ArcArray: array of TArcRecord;

function TKIR8RS.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer; var AnswerSize: Integer): HRESULT;
var
  TR, TA: TArray<Byte>;
  ValueLoop: Cardinal;
  bSendAnswer: Boolean;
  FDevBattery: Byte;       // ���� ��������� ���
//  tmp: string;
  FMyForm: TfrmKIR8RS;
//  bat: Double;
//  batInt: Integer;
  i, j: Integer;
  ver: string;
  FTime: TDateTime;
  Y, MM, D, H, M, S, MS: Word;
  FDevTimeDifference: Cardinal;
begin
  Result := inherited;
  FMyForm := TfrmKIR8RS(MyForm);
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
        TA := TArray<Byte>.Create($80, $81, $03, $01, $07, $01, $00);
        if FDevTimeSync then
          ResetBit(TA[5], 0);
        if FMyForm.FDevDataSend then
        begin
          SetBit(TA[5], 1);  // ���������� ��������� ����������� ����� ��� ���
          FMyForm.FDevDataSend := False;
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
        FDevBattery := FMyForm.cbbPow.ItemIndex;
        SetLength(TA, 84);
        FTime := (Now - FCompTime) + FDevTime;
        DecodeDate(FDevTime, Y, MM, D);
        DecodeTime(FDevTime, H, M, S, MS);

        TA[0] := $80;
        TA[1] := $85;
        TA[2] := $50;
        // �����
        TA[67] := M;
        TA[68] := H;
        TA[69] := D;
        TA[70] := MM;
        TA[71] := (Y - 2000);

       //���������
        for i := 0 to 7 do
        begin
          ValueLoop := StrToIntDef(FMyForm.SG.Cells[1, i + 1], 0);
          Move(ValueLoop, TA[3 + ((4 * i) * 2)], 4);
          ValueLoop := StrToIntDef(FMyForm.SG.Cells[2, i + 1], 0);
          Move(ValueLoop, TA[7 + ((4 * i) * 2)], 4);
        end;
        // ��������� TA[72]
        FDevTimeDifference := MinutesBetween(Now, CreateDeviceTime);
        TA[73] := FDevTimeDifference mod 60;
        FDevTimeDifference := FDevTimeDifference div 60;
        Move(FDevTimeDifference, TA[72], 3);
        // ������ ��������� ������
       for I := 0 to 7 do
            if FMyForm.SG.Cells[3, i + 1] = '����� �������' then
                 SetBit(TA[75 + i], 0)
             else if FMyForm.SG.Cells[3, i + 1] = '����� �����' then
                 SetBit(TA[75 + i], 1);
      end;

    PCKT_OPER:
      begin
        FDevBattery := FMyForm.cbbPow.ItemIndex;
        TA := TArray<Byte>.Create($80, $89, $01, $00, $00);
      // ��������� ����������� �����, ������������ � ��������
        if not (FMyForm.btnSensor.Down) then
        begin
          SetBit(TA[3], 0);
        end;
        if FDevBattery <> 0 then
        begin
          case FDevBattery of
            1:
              begin
                SetBit(TA[3], 4);
              end;
            2:
              begin
                SetBit(TA[3], 4);
                SetBit(TA[3], 5);
              end;
            3:
              begin
                SetBit(TA[3], 6);
              end;
            4:
              begin
                SetBit(TA[3], 4);
                SetBit(TA[3], 5);
                SetBit(TA[3], 6);
              end;
          end;
        end;
      end;
    PCKT_WRITE_BLOCK_DATA:
      begin
        FMyForm.lblRateOne.Caption := TR[5].ToString;
        FMyForm.lblRateTwo.Caption := TR[6].ToString;
        TA := TArray<Byte>.Create($80, $8B, $00, $00);
      end;

    PCKT_READ_BLOCK_DATA:
      begin
        TA := TArray<Byte>.Create($80, $8C, $02, $00, $00, $00);
        TA[3] := StrToInt(FMyForm.lblRateOne.Caption);
        TA[4] := StrToInt(FMyForm.lblRateTwo.Caption);
      end

//     PCKT_VERSION:
//      begin
//        // �������� �� ��������� ����� �� ���� ������
//        // �� ���������� �������� �����-�� "�������"
//        TA := TArray<Byte>.Create($81, $81, $03, $01, $07, $00, $00);
//      end

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
//end;

procedure TfrmKIR8RS.btnSensorClick(Sender: TObject);
var
  i: Integer;
begin
  FDevDataSend := True;
  // �������� ������ �������� ������
  SetLength(ArcArray, 10);

  if FDev_Count_record < 10 then
  begin
    with ArcArray[9 - FDev_Count_record] do       // ��������� ������
    begin
      RecTime := Now;
      Sensor := btnSensor.Down;
      AKB := cbbPow.ItemIndex;
    end;
    Inc(FDev_Count_record);                 // ������� ���������� �������
  end
  else
  begin                                     // ���� ������ 10 �������� �� ���� ������� �����
    for i := 0 to 8 do
      ArcArray[9 - i] := ArcArray[8 - i];
    with ArcArray[0] do                    // ���������� � ������ ������� ��������� ������
    begin
      RecTime := Now;
      Sensor := btnSensor.Down;
      AKB := cbbPow.ItemIndex;
    end;
  end;

end;




// ���������� ComboBox � StringGrid
procedure TfrmKIR8RS.CBSG1Change(Sender: TObject);
begin
 {���������� ��������� � �������� �� ComboBox � grid}
  SG.Cells[SG.Col, SG.Row] := CBSG1.Items[CBSG1.ItemIndex];
  CBSG1.Visible := False;
  SG.SetFocus;
end;

procedure TfrmKIR8RS.CBSG1Exit(Sender: TObject);
begin
  {���������� ��������� � �������� �� ComboBox � grid}
  SG.Cells[SG.Col, SG.Row] := CBSG1.Items[CBSG1.ItemIndex];
  CBSG1.Visible := False;
  SG.SetFocus;
end;

// ������������ ��������� ����� � ���������� TStringGrid
procedure TfrmKIR8RS.FormCreate(Sender: TObject);
var
  i, j: Integer;
begin
  inherited;
  FDevDataSend := False;
  FDev_Count_record := 0;
  with SG do
  begin
    ColWidths[0] := 40;
    ColWidths[1] := 65;
    ColWidths[2] := 65;
    ColWidths[3] := 120;
    for i := 1 to 8 do
      Cells[0, i] := i.ToString;
    for i := 1 to 8 do
    begin
      Cells[1, i] := '0';
      Cells[2, i] := '0';
      Cells[3, i] := '����� �����';
    end;

    Cells[0, 0] := '����';
    Cells[1, 0] := '����� 1';
    Cells[2, 0] := '����� 2';
    Cells[3, 0] := '��������� ������';
  end;
  SG.DefaultRowHeight := CBSG1.Height;
  CBSG1.Visible := False;
end;

procedure TfrmKIR8RS.SGSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
begin
  inherited;
  if ((ACol = 3) and (ARow <> 0)) then
  begin
    {������ � ��������� ComboBox ������ ��������������� ������ StringGrid}
    R := SG.CellRect(ACol, ARow);
    R.Left := R.Left + SG.Left;
    R.Right := R.Right + SG.Left;
    R.Top := R.Top + SG.Top;
    R.Bottom := R.Bottom + SG.Top;
    CBSG1.ItemIndex := CBSG1.Items.IndexOf(SG.Cells[ACol, ARow]);
    CBSG1.Left := R.Left + 1;
    CBSG1.Top := R.Top + 1;
    CBSG1.Width := (R.Right + 1) - R.Left;
    CBSG1.Height := (R.Bottom + 1) - R.Top; {������� combobox}
    CBSG1.Visible := True;
    CBSG1.SetFocus;
  end;
  CanSelect := True;
end;

end.
//end.
