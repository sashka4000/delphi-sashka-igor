unit dev_kir16rs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  dev_base_form, Vcl.Grids, Vcl.ValEdit, Vcl.Buttons, Vcl.Samples.Spin,
  Vcl.StdCtrls, DateUtils, Vcl.Mask, Vcl.ComCtrls,  WinTypes;

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
    CBSG1: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure SGSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure CBSG1CloseUp(Sender: TObject);
    procedure CBSG1Exit(Sender: TObject);
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
  ValueLoop : Cardinal;
  bSendAnswer: Boolean;
  FDevBattery : Byte;       // ���� ��������� ���
//  tmp: string;
  FMyForm: TfrmKIR16RS;
//  bat: Double;
//  batInt: Integer;
  i, j : Integer;
  ver: string;
  FTime: TDateTime;
  Y, MM, D, H, M, S, MS: Word;
  FDevTimeDifference : Cardinal;
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

//     FDevBattery := $00;
  // �������� ����� �� ������

  case TR[1] of
    PCKT_TYPE:
      begin
  // ��������� ��������� ������� ���� ����������
        TA := TArray<Byte>.Create($80, $81, $03, $0A, $03, $01, $00);
        if FDevTimeSync then
          ResetBit(TA[5], 0);
        if FDevDataSend then
        begin
          SetBit(TA[5], 1);  // ���������� ��������� ����������� ����� ��� ���
          FDevDataSend := False;
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
        //************************
        // ��������� ����������� �����, ������������ � ��������
        if not(FMyForm.btnSensor.Down) then
        begin
           FDevDataSend := True;
           SetBit(TA[81],0);
        end;
        if FDevBattery <> 0 then
        begin
           FDevDataSend := True;
          case FDevBattery of
            1:
              begin
               SetBit(TA[81],5);
              end;
            2:
              begin
               SetBit(TA[81],4);
               SetBit(TA[81],5);
              end;
            3:
              begin
                SetBit(TA[81],6);
              end;
            4:
              begin
                SetBit(TA[81], 7);
              end;
          end;
        end;
       //****************************
       //���������
        for i := 0 to 15 do
        begin
          ValueLoop := StrToIntDef(FMyForm.SG.Cells[1, i + 1],0);
          Move(ValueLoop, TA[9 + (4 * i)], 4);
        end;
        // ��������� TA[73]
        FDevTimeDifference := MinutesBetween(Now, CreateDeviceTime);
        TA[73] := FDevTimeDifference mod 60;
        FDevTimeDifference := FDevTimeDifference div 60;
        Move(FDevTimeDifference, TA[74], 3);
        //**************************
        // ������ ��������� ������
//             FMyForm.CBSG1.ItemIndex;
          for i := 0 to 3 do
            begin
              for j := 1 to 4 do
                if FMyForm.SG.Cells[2, j + ( 4 * i )] = '����� �������' then
                 SetBit(TA[77 + i],(0 + (2 * (j -1))))
                 else if FMyForm.SG.Cells[2, j + ( 4 * i )] = '����� �����' then
                  begin
                    SetBit(TA[77 + i],(0 + (2 * (j -1))));
                    SetBit(TA[77 + i],(1 + (2 * (j -1))))
                  end;
            end;
        //

      end;
    PCKT_OPER:
      begin
        FDevBattery := FMyForm.cbbPow.ItemIndex;
        TA := TArray<Byte>.Create($80, $89, $01, $00, $00);
      // ��������� ����������� �����, ������������ � ��������
        if not (FMyForm.btnSensor.Down) then
        begin
           FDevDataSend := True;
           SetBit(TA[3],0);
        end;
        if FDevBattery <> 0 then
        begin
           FDevDataSend := True;
          case FDevBattery of
            1:
              begin
               SetBit(TA[3],5);
              end;
            2:
              begin
               SetBit(TA[3],4);
               SetBit(TA[3],5);
              end;
            3:
              begin
                SetBit(TA[3],6);
              end;
            4:
              begin
                SetBit(TA[3], 7);
              end;
          end;
        end;
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


// ���������� ComboBox � StringGrid
procedure TfrmKIR16RS.CBSG1CloseUp(Sender: TObject);
begin
  inherited;
      {���������� ��������� � �������� �� ComboBox � grid}
  SG.Cells[SG.Col, SG.Row] := CBSG1.Items[CBSG1.ItemIndex];
  CBSG1.Visible := False;
  SG.SetFocus;
end;

procedure TfrmKIR16RS.CBSG1Exit(Sender: TObject);
begin
  inherited;
        {���������� ��������� � �������� �� ComboBox � grid}
  SG.Cells[SG.Col, SG.Row] := CBSG1.Items[CBSG1.ItemIndex];
  CBSG1.Visible := False;
  SG.SetFocus;
end;




// ������������ ��������� ����� � ���������� TStringGrid
procedure TfrmKIR16RS.FormCreate(Sender: TObject);
var
  i, j : Integer;
begin
  inherited;
  with SG do
  begin
    ColWidths[0] := 40;
    ColWidths[1] := 95;
    ColWidths[2] := 120;
    for i := 1 to 16 do
      Cells[0, i] := i.ToString;
        for i := 1 to 16 do
        begin
          Cells[1, i] := '0';
          Cells[2, i] := '����� �����';
        end;

    Cells[0, 0] := '����';
    Cells[1, 0] := '����� ���������';
    Cells[2, 0] := '��������� ������';
  end;
 SG.DefaultRowHeight := CBSG1.Height;
 CBSG1.Visible := False;
end;

procedure TfrmKIR16RS.SGSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
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

