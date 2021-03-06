unit dev_kir16rs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  dev_base_form, Vcl.Grids, Vcl.ValEdit, Vcl.Buttons, Vcl.Samples.Spin,
  Vcl.StdCtrls, DateUtils, Vcl.Mask, Vcl.ComCtrls, WinTypes;

type
  TfrmKIR16RS = class(TfrmBase)
    lblVer: TLabel;
    seNumber: TSpinEdit;
    lbl17: TLabel;
    btnSensor: TSpeedButton;
    lblSensor: TLabel;
    SG: TStringGrid;
    cbbPow: TComboBox;
    lblAKB: TLabel;
    CBSG1: TComboBox;
    lblTypeProtocol: TLabel;
    lbl1: TLabel;
    cbbVersion: TComboBox;
    CBSG2: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure SGSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure CBSG1Exit(Sender: TObject);
    procedure btnSensorClick(Sender: TObject);
    procedure cbbPowChange(Sender: TObject);
    procedure CBSG1Change(Sender: TObject);
    procedure CBSG2Change(Sender: TObject);
    procedure CBSG2Exit(Sender: TObject);
    procedure cbbVersionChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FDevDataSend: Boolean;
  end;
  TKIR16RS = class(TBaseDevice)
    function Serialize(LoadSave: Integer; P: PChar; var PSize: DWORD): HRESULT; override; stdcall;
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
  ValueLoop: Cardinal;
  bSendAnswer: Boolean;
  FDevBattery: Byte;       // ���� ��������� ���
  FMyForm: TfrmKIR16RS;
  i, j: Integer;
  ver: string;
  FTime: TDateTime;
  Y, MM, D, H, M, S, MS: Word;
  FDevTimeDifference: Cardinal;
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

      PCKT_WRITE_DATA:
      begin
        // ������ ������� ������ ����������
        // ������ ��� ������ �������� ������������� >= 21.1
        if FMyForm.cbbVersion.ItemIndex = 0 then
          Exit;
        TA := TArray<Byte>.Create($80, $84, $02, $00, $00, $00);
        if not (TR[3] in [1..16]) then
          Exit;
        TA[3] := TR[3];
        if (TR[4] in [1..10]) then
          FMyForm.SG.Cells[3, TR[3]] :=  TR[4].ToString;
        TA[4] := FMyForm.SG.Cells[3, TR[3]].ToInteger;
      end;

    PCKT_CURRENT:
      begin
        FDevBattery := FMyForm.cbbPow.ItemIndex;
        SetLength(TA, 83);
        FTime := (Now - FCompTime) + FDevTime;
        DecodeDate(FDevTime, Y, MM, D);
        DecodeTime(FDevTime, H, M, S, MS);

        TA[0] := $80;
        TA[1] := $85;
        TA[2] := $4F;
        // �����
        TA[3] := S;
        TA[4] := M;
        TA[5] := H;
        TA[6] := D;
        TA[7] := MM;
        TA[8] := (Y - 2000);
        // ��������� ����������� �����, ������������ � ��������
        if not (FMyForm.btnSensor.Down) then
        begin
          SetBit(TA[81], 0);
        end;
        if FDevBattery <> 0 then
        begin
          case FDevBattery of
            1:
              begin
                SetBit(TA[81], 5);
              end;
            2:
              begin
                SetBit(TA[81], 4);
                SetBit(TA[81], 5);
              end;
            3:
              begin
                SetBit(TA[81], 6);
              end;
            4:
              begin
                SetBit(TA[81], 7);
              end;
          end;
        end;
       //���������
        for i := 0 to 15 do
        begin
          ValueLoop := StrToIntDef(FMyForm.SG.Cells[1, i + 1], 0);
          Move(ValueLoop, TA[9 + (4 * i)], 4);
        end;
        // ��������� TA[73]
        FDevTimeDifference := MinutesBetween(Now, CreateDeviceCompTime);
        TA[73] := FDevTimeDifference mod 60;
        FDevTimeDifference := FDevTimeDifference div 60;
        Move(FDevTimeDifference, TA[74], 3);
        // ������ ��������� ������
        for i := 0 to 3 do
        begin
          for j := 1 to 4 do
            if FMyForm.SG.Cells[2, j + (4 * i)] = '����� �������' then
              SetBit(TA[77 + i], (0 + (2 * (j - 1))))
            else if FMyForm.SG.Cells[2, j + (4 * i)] = '����� �����' then
              SetBit(TA[77 + i], (1 + (2 * (j - 1))))
        end;

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
                SetBit(TA[3], 5);
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
                SetBit(TA[3], 7);
              end;
          end;
        end;
      end;

    PCKT_WRITE_BLOCK_DATA:
      begin
        TA := TArray<Byte>.Create($80, $8B, $00, $00);
        if (TR[3] and $01) = $01 then
          FMyForm.lblTypeProtocol.Caption := '��� ���������: 106 ���'
        else
          FMyForm.lblTypeProtocol.Caption := '��� ���������: 40 ���';

        if (TR[3] and $10) = $10 then
          for i := 1 to 16 do
            FMyForm.SG.Cells[1, i] := '0';
      end;

    PCKT_VERSION:
      begin
        TA := TArray<Byte>.Create($80, $8D, $02, $00, $00, $00);
        // ������ ������ ����������
        ver := FMyForm.cbbVersion.Text;
        TA[3] := Fetch(ver, '.').ToInteger;
        TA[4] := ver.ToInteger;
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

procedure TfrmKIR16RS.btnSensorClick(Sender: TObject);
begin
  FDevDataSend := True;
end;

procedure TfrmKIR16RS.cbbPowChange(Sender: TObject);
begin
  FDevDataSend := True;
end;


procedure TfrmKIR16RS.cbbVersionChange(Sender: TObject);
begin
  if cbbVersion.ItemIndex = 0
   then SG.ColWidths [3] := 1
   else SG.ColWidths [3] := 55;
end;

// ���������� ComboBox � StringGrid
procedure TfrmKIR16RS.CBSG1Change(Sender: TObject);
begin
  {���������� ��������� � �������� �� ComboBox � grid}
  SG.Cells[SG.Col, SG.Row] := CBSG1.Text;
  //CBSG1.Visible := False;
  //SG.SetFocus;
end;


procedure TfrmKIR16RS.CBSG1Exit(Sender: TObject);
begin
  inherited;
  {���������� ��������� � �������� �� ComboBox � grid}
  SG.Cells[SG.Col, SG.Row] := CBSG1.Text;
  CBSG1.Visible := False;
  SG.SetFocus;
end;


procedure TfrmKIR16RS.CBSG2Change(Sender: TObject);
begin
  SG.Cells[SG.Col, SG.Row] := CBSG2.Text;
end;


procedure TfrmKIR16RS.CBSG2Exit(Sender: TObject);
begin
  SG.Cells[SG.Col, SG.Row] := CBSG2.Text;
  CBSG2.Visible := False;
  SG.SetFocus;
end;


// ������������ ��������� ����� � ���������� TStringGrid
procedure TfrmKIR16RS.FormCreate(Sender: TObject);
var
  i, j: Integer;
begin
  inherited;
  FDevDataSend := False;
  with SG do
  begin
    ColWidths[0] := 40;
    ColWidths[1] := 95;
    ColWidths[2] := 120;
    ColWidths[3] := 55;
    for i := 1 to 16 do
      Cells[0, i] := i.ToString;
    for i := 1 to 16 do
    begin
      Cells[1, i] := '0';
      Cells[2, i] := '����� �����';
      Cells[3, i] := '6';
    end;

    Cells[0, 0] := '����';
    Cells[1, 0] := '����� ���������';
    Cells[2, 0] := '��������� ������';
    Cells[3, 0] := '�����';
  end;
  SG.DefaultRowHeight := CBSG1.Height;
  SG.DefaultRowHeight := CBSG2.Height;
  CBSG1.Visible := False;
  CBSG2.Visible := False;
end;

procedure TfrmKIR16RS.SGSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
  j: Integer;
begin
  inherited;
  if ((ACol = 2) and (ARow <> 0)) then
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
 // ��� ��������
    if ((ACol = 3) and (ARow <> 0)) then
  begin
    {������ � ��������� ComboBox ������ ��������������� ������ StringGrid}
    R := SG.CellRect(ACol, ARow);
    R.Left := R.Left + SG.Left;
    R.Right := R.Right + SG.Left;
    R.Top := R.Top + SG.Top;
    R.Bottom := R.Bottom + SG.Top;
    CBSG2.ItemIndex := CBSG2.Items.IndexOf(SG.Cells[ACol, ARow]);
    CBSG2.Left := R.Left + 1;
    CBSG2.Top := R.Top + 1;
    CBSG2.Width := (R.Right + 1) - R.Left;
    CBSG2.Height := (R.Bottom + 1) - R.Top; {������� combobox}
    CBSG2.Visible := True;
    CBSG2.SetFocus;
  end;

  CanSelect := True;
end;

function TKIR16RS.Serialize(LoadSave: Integer; P: PChar; var PSize: DWORD): HRESULT;
var
  FMyForm: TfrmKIR16RS;
begin
  FMyForm := TfrmKIR16RS(MyForm);
  if LoadSave = 0 then
  begin
    Result := inherited;
    FMyForm.seNumber.Text := FDeviceSettingsList.Values['Address'];
    FMyForm.cbbVersion.ItemIndex := FDeviceSettingsList.Values['Version'].ToInteger;
    if FDeviceSettingsList.Values['Pause'] <> '' then
    begin
      FMyForm.SG.Cols[3].DelimitedText := FDeviceSettingsList.Values['Pause'];
    end;
    if FDeviceSettingsList.Values['Impulse'] <> '' then
    begin
      FMyForm.SG.Cols[1].DelimitedText := FDeviceSettingsList.Values['Impulse'];
    end;
    FMyForm.cbbPow.ItemIndex := StrToIntDef(FDeviceSettingsList.Values['UPS'],0);
    FMyForm.cbbVersionChange(nil);
  end
  else
  begin
    FDeviceSettingsList.Clear;
    FDeviceSettingsList.AddPair('Address', FMyForm.seNumber.Text);
    FDeviceSettingsList.AddPair('Version', FMyForm.cbbVersion.ItemIndex.ToString);
    FDeviceSettingsList.AddPair('UPS', FMyForm.cbbPow.ItemIndex.ToString);
    FDeviceSettingsList.AddPair('Impulse', FMyForm.SG.Cols[1].DelimitedText);
    FDeviceSettingsList.AddPair('Pause', FMyForm.SG.Cols[3].DelimitedText);
    Result := inherited;
  end;
end;

end.

