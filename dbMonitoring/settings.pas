unit settings;

interface

uses
  Classes, SysUtils, IniFiles, Forms, Windows;

const
  csIniDBConnectionSection = 'DBConnection';
  csIniGlobalSection = 'Global';

  {Section: DBConnection}
  csIniDBConnectionDBIP = 'DBIP';
  csIniDBConnectionDBPath = 'DBPath';
  csIniDBConnectionVendorLib = 'VendorLib';

  {Section: Global}
  csIniGlobalStartInterval = 'StartInterval';

type
  TIniOptions = class(TObject)
  private
    {Section: DBConnection}
    FDBConnectionDBIP: string;
    FDBConnectionDBPath: string;
    FDBConnectionVendorLib: string;

    {Section: Global}
    FGlobalStartInterval: Integer;
  public
    procedure LoadSettings(Ini: TIniFile);
    procedure SaveSettings(Ini: TIniFile);
    
    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);

    {Section: DBConnection}
    property DBConnectionDBIP: string read FDBConnectionDBIP write FDBConnectionDBIP;
    property DBConnectionDBPath: string read FDBConnectionDBPath write FDBConnectionDBPath;
    property DBConnectionVendorLib: string read FDBConnectionVendorLib write FDBConnectionVendorLib;

    {Section: Global}
    property GlobalStartInterval: Integer read FGlobalStartInterval write FGlobalStartInterval;
  end;

var
  IniOptions: TIniOptions = nil;

implementation

procedure TIniOptions.LoadSettings(Ini: TIniFile);
begin
  if Ini <> nil then
  begin
    {Section: DBConnection}
    FDBConnectionDBIP := Ini.ReadString(csIniDBConnectionSection, csIniDBConnectionDBIP, '127.0.0.1');
    FDBConnectionDBPath := Ini.ReadString(csIniDBConnectionSection, csIniDBConnectionDBPath, 'C:\DB\SCADALOGGER.GDB');
    FDBConnectionVendorLib := Ini.ReadString(csIniDBConnectionSection, csIniDBConnectionVendorLib, 'C:\Program Files (x86)\Firebird\Firebird_2_5\bin\fbclient.dll');

    {Section: Global}
    FGlobalStartInterval := Ini.ReadInteger(csIniGlobalSection, csIniGlobalStartInterval, 60);
  end;
end;

procedure TIniOptions.SaveSettings(Ini: TIniFile);
begin
  if Ini <> nil then
  begin
    {Section: DBConnection}
    Ini.WriteString(csIniDBConnectionSection, csIniDBConnectionDBIP, FDBConnectionDBIP);
    Ini.WriteString(csIniDBConnectionSection, csIniDBConnectionDBPath, FDBConnectionDBPath);
    Ini.WriteString(csIniDBConnectionSection, csIniDBConnectionVendorLib, FDBConnectionVendorLib);

    {Section: Global}
    Ini.WriteInteger(csIniGlobalSection, csIniGlobalStartInterval, FGlobalStartInterval);
  end;
end;

procedure TIniOptions.LoadFromFile(const FileName: string);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(FileName);
  try
    LoadSettings(Ini);
  finally
    Ini.Free;
  end;
end;

procedure TIniOptions.SaveToFile(const FileName: string);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(FileName);
  try
    SaveSettings(Ini);
  finally
    Ini.Free;
  end;
end;

initialization
  IniOptions := TIniOptions.Create;

finalization
  IniOptions.Free;

end.

