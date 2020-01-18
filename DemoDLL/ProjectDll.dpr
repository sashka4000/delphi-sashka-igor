library ProjectDll;

uses
  System.SysUtils,
  System.Classes;

{$R *.res}

function fSQRT(i : Integer): Real; stdcall;
begin

end;

function fCompare(i, j : Integer): Integer; stdcall;
begin

end;

function fRevers(fChar : PChar): PChar; stdcall;
begin

end;

exports
 fSQRT,
 fCompare,
 fRevers;
begin
end.
