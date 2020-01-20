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
  fs, fs2 : string;
  i: Integer;
begin
  fs := fChar;
  fs2 := '';
  for I := Length(fs) downto 1 do
    fs2 := fs2 + fs[i];
  fRevers := PWidechar(fs2);
end;

exports
  fSQRT,
  fCompare,
  fRevers;

begin
end.

