unit ext_global;

interface

const

 PCKT_TYPE = $01;
 PCKT_VERSION = $0D;
 PCKT_CURRENT = $05;
 PCKT_OPER = $09;

// ���������� CRC ��� ������� ������
function GET_CRC (TA : TArray<Byte>; Len : Integer) : Byte;

// ���������� CRC � �������� � �����
procedure CRC (TA : TArray<Byte>;Len : Integer);
// ��������� ����
procedure SetBit(var Src: Byte; bit: Integer);

implementation

function GET_CRC (TA : TArray<Byte>;Len : Integer) : Byte;
var
 B : Byte;
 I : Integer;
begin
 B := 0;
 for i := 0 to Len - 2 do
  B := B + TA[i];
 Result := $100-B;
end;

procedure CRC (TA : TArray<Byte>;Len : Integer);
begin
 TA[Len-1] := GET_CRC(TA,Len);
end;

procedure SetBit(var Src : Byte; bit: Integer);
begin
  Src := Src or (1 shl bit);
end;

end.

