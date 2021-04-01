unit ext_global;

interface

const
  PCKT_TYPE = $01;
  PCKT_WRITE_TIME = $02;
  PCKT_READ_TIME = $03;
  PCKT_WRITE_DATA = $04;
  PCKT_CURRENT = $05;
  PCKT_STATE_ARCHIVE = $06;
  PCKT_GET_ARCHIVE = $07;
  PCKT_OPER = $09;
  PCKT_WRITE_BLOCK_DATA = $0B;
  PCKT_READ_BLOCK_DATA = $0C;
  PCKT_VERSION = $0D;
  PCKT_WRITE_ROM_Dev = $0E;
  PCKT_READ_ROM_Dev = $0F;

// рассчитать CRC для полного пакета
function GET_CRC (TA : TArray<Byte>; Len : Integer) : Byte;

// рассчитать CRC и записать в буфер
procedure CRC (TA : TArray<Byte>;Len : Integer);
// установка бита
procedure SetBit(var Src: Byte; bit: Integer);
// сброс бита
procedure ResetBit(var Src : Byte; bit: Integer);
// провека бита
function GetBit(Src : Byte; bit: Integer)  : Integer;
function IsBitSet(Src : Byte; bit: Integer)  : Boolean;

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

procedure ResetBit(var Src : Byte; bit: Integer);
begin
  Src := Src and not (1 shl Bit);
end;

function GetBit(Src : Byte; bit: Integer)  : Integer;
begin
   Result := (Src shr bit) and $01;
end;

function IsBitSet (Src : Byte; bit: Integer)  : Boolean;
begin
   IsBitSet  := False;
   if (Src shr bit) and $01 = 1 then
   IsBitSet  := True;
end;
end.

