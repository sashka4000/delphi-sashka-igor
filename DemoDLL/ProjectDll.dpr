library ProjectDll;

uses
  System.SysUtils,
  System.Classes;

{$R *.res}

function fSQRT(i: Integer): Real; stdcall;
begin
  Result := Sqrt(i);
end;

function fCompare(i, j: Integer): Integer; stdcall;
begin
  if i = j then
    Result := 0
  else if i > j then
    Result := -1
  else
    Result := 1;
end;

function fRevers(fChar: PWideChar): PWideChar; stdcall;
var
  farray: array of string;
  fs: string;
  i: Integer;
begin
  fs := fChar;
  SetLength(farray, Length(fs));
  for i := 1 to Length(fs) do
    farray[i - 1] := fs[i];
  fs := '';
  for i := Length(farray) - 1 downto 0 do
    fs := fs + farray[i];
  Result := PWideChar(fs);
end;

exports
  fSQRT,
  fCompare,
  fRevers;

begin
end.

