unit dev_kup2rs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, ext_global,
  dev_base_form, Vcl.Buttons;

type
  TfrmKUP2RS = class(TfrmBase)
    chkPowLine: TCheckBox;
    seNumber: TSpinEdit;
    lbl17: TLabel;
    btnSw2: TSpeedButton;
    btnSw1: TSpeedButton;
    btnIn6: TSpeedButton;
    btnIn5: TSpeedButton;
    btnIn2: TSpeedButton;
    btnIn1: TSpeedButton;
    lblSw: TLabel;
    lblIn: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

    TKUP2RS = class(TBaseDevice)
    function Serialize (LoadSave: Integer; P: PChar; var PSize : DWORD): HRESULT; override; stdcall;
    function OnDataReceive(pd: PByte; PacketSize: Integer; MaxSize: Integer; var AnswerSize: Integer): HRESULT; override; stdcall;
  end;

const
  gKUP2RS: TGUID = '{F9F3C848-4713-45BC-9FB5-C21F73D348D6}';  // ���������� �������������, ������������ �� Ctrl+Shift+G

implementation

{$R *.dfm}

function TKUP2RS.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer; var AnswerSize: Integer): HRESULT;
var
  TR, TA: TArray<Byte>;
  bSendAnswer: Boolean;
  upsl_b, upsl_ch: Byte;
  tmp: string;
  FMyForm: TfrmKUP2RS;
  bat: Double;
  batInt: Integer;
  i: Integer;
  ver: string;
  FTime: TDateTime;
  Y, MM, D, H, M, S, MS: Word;
  b1, b2 : TSpeedButton;
begin
  Result := inherited;

  FMyForm := TfrmKUP2RS(MyForm);
  // �������������� ��������� � ���� ������ ����
  TR := TArray<Byte>(pd);

  // �������� CRC ������
  if GET_CRC(TR, PacketSize) <> TR[PacketSize - 1] then
    Exit;
  // �������� ����� ���������� � ������ �����
  if TR[0] <> $08 + FMyForm.seNumber.Value then
    Exit;


  // �������� ����� �� ������

  case TR[1] of
    PCKT_TYPE:
      begin
  // ��������� ��������� ������� ���� ����������
        TA := TArray<Byte>.Create($08, $81, $03, $09, $00, $00, $00);

      end;
    PCKT_WRITE_DATA:
      begin
        TA := TArray<Byte>.Create($08, $84, $06, TR[3], TR[4], $44, $44, $D4, $01, $00);

        if FMyForm.chkPowLine.Checked then
          SetBit(TA[7], 0);                //     0 -> 1
        // ������ ��������� ������ �������
        if FMyForm.btnIn5.Down then
          ResetBit(TA[5], 6);              //     6 -> 0

        if FMyForm.btnIn6.Down then
          ResetBit(TA[5], 2);              //     2 -> 0

       //     2 -> 0
       // ������ ��������� ������ ����
        if FMyForm.btnSw1.Down then
          SetBit(TA[5], 4);                //     4 -> 1

        if FMyForm.btnSw2.Down then
          SetBit(TA[5], 0);                //     0 -> 1

        // ���������� ��������� �������������
        if FMyForm.btnIn1.Down then
          ResetBit(TA[7], 2);              //     2 -> 0

        if FMyForm.btnIn2.Down then
          ResetBit(TA[7], 4);              //     4 -> 0

           //     7 -> 0
       // ������ ������� �� ������� ������

        for i := 0 to 1 do
        begin
          if i = 0 then
          begin
            b1 := FMyForm.btnSw1;
            b2 := FMyForm.btnSw2;
          end
          else
          begin
//            b1 := FMyForm.btnSw3;
//            b2 := FMyForm.btnSw4;
          end;

          if (TR[3 + i] and $0D) = $01 then          // ����� 00001101
          begin
            SetBit(TA[5 + i], 0);
            b2.Down := True;
            if (TR[3 + i] and $03) = $03 then
//              TWaitTime.Create(b2, FMyForm.Handle);
          end;

          if (TR[3 + i] and $0F) = $02 then          // ����� 00001111
          begin
            ResetBit(TA[5 + i], 0);
            b2.Down := False;
          end;

          if (TR[3 + i] and $D0) = $10 then          // ����� 11010000
          begin
            SetBit(TA[5 + i], 0);
            b1.Down := True;
            if (TR[3 + i] and $30) = $30 then
//              TWaitTime.Create(b1, FMyForm.Handle);
          end;

          if (TR[3 + i] and $F0) = $20 then         // ����� 11110000
          begin
            ResetBit(TA[5 + i], 0);
            b1.Down := False;
          end;


        end;
        end;



  else
    Exit;
  end;

  // ������������ ���������� ����� ���������� � ������ ����
  TA[0] := $08 + FMyForm.seNumber.Value;

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


function TKUP2RS.Serialize(LoadSave: Integer; P: PChar;
  var PSize: DWORD): HRESULT;
var
  FMyForm: TfrmKUP2RS;
begin
 FMyForm := TfrmKUP2RS(MyForm);
 if LoadSave = 0 then
 begin
   Result := inherited;
   FMyForm.seNumber.Text := FDeviceSettingsList.Values ['Address'];
//   FMyForm.cbbVersion.ItemIndex := FDeviceSettingsList.Values ['Version'].ToInteger;
 end else
 begin
   FDeviceSettingsList.Clear;
   FDeviceSettingsList.AddPair ('Address', FMyForm.seNumber.Text);
//   FDeviceSettingsList.AddPair ('Version', FMyForm.cbbVersion.ItemIndex.ToString);
   Result := inherited;
 end;
end;
end.
