unit Emu;

interface
Uses Classes, SysUtils;

type

  EmulatorString = record
   Request : string;
   Answer  : String;
  end;

  TEmulatorDevice = class
   private
    Em  : TStringList;
    AnswerPos : Integer;
    ReqString : String;
    AnsString : String;
    AnsBuffer : array of Byte;
    procedure MakeEmulatorFromLogFile (sl : TStringList);
   public
    FCounter  : Integer;
    procedure ReadEmulator (const FilePath : String; ID : Integer); overload;
    procedure ReadEmulator (sl : TStringList); overload;
    procedure Request   ( PB : PByteArray; Count : Integer);
    function  GetAnswer (PB : PByteArray; MustRead : Integer; MaxBufferSize : Integer; var Readed : Integer) : Integer;
  end;

implementation
Uses IdGlobal;

{ TEmulatorDevice }

function TEmulatorDevice.GetAnswer(PB : PByteArray; MustRead : Integer; MaxBufferSize : Integer; var Readed : Integer) : Integer;
var
   i : Integer;
   max_l : Integer;
begin
//  if (AnsString = '') then
//    AnsString := em.Values [ReqString];
  Result := 0;
  Readed := 0;
  if (AnsString = '') then Exit;
  if (MustRead = 0) then
      MustRead := 1024;
  max_l := Length (AnsBuffer);

  if (MustRead + AnswerPos > max_l)
    then  MustRead := max_l - AnswerPos;

  if MustRead > MaxBufferSize then
  begin
     Result := 1;
     Exit;
  end;

  Readed := MustRead;
  move (AnsBuffer[AnswerPos],PB^,MustRead);
  AnswerPos := AnswerPos + MustRead;

end;

procedure TEmulatorDevice.MakeEmulatorFromLogFile(sl: TStringList);
type
   TRecType = (rUnck, rWrite, rRead);
const
   recWrite = '>>';
   recRead  = '<<';
   TimeOut  = 'TimeOut';
var
  i : Integer;
  cRec, lRec : TRecType;
  tmp : String;
  w,r : Integer;
  lWrite, lRead : string;
begin
  if (em = nil) then em := TStringList.Create;
  em.Clear;
  em.Sorted := False;
  cRec := rUnck;
  lRec := rUnck;
  lWrite := '';
  lRead := '';
  i := 1;
  while (i < sl.Count) do
  begin
    tmp := sl.Strings [i];
    w := pos (recWrite, tmp);
    r := pos (recRead, tmp);
    if (w <= 0) and (r <= 0) or (pos (TimeOut, tmp) > 0) then
    begin
       inc(i);
       Continue;
    end;
    Fetch (tmp, ': ');
    tmp := Trim(tmp);
    if w > 0 then
    begin
      if lRec = rRead then
      begin
         em.Add(lWrite + '=' + lRead);
         lWrite := '';
         lRead := '';
      end else
      begin
        if lWrite <> '' then
        begin
          em.Add(lWrite + '=');
          lWrite := '';
          lRead := '';
        end;
      end;
      cRec := rWrite;
      lWrite := tmp;
    end else
    begin
        cRec := rRead;
        if lRec = rRead
        then
           lRead := lRead + ' ' + tmp
        else
           lRead := tmp;
    end;
    lRec := cRec;
    inc (i);
  end;
  em.Add(lWrite + '=' + lRead);
end;

procedure TEmulatorDevice.ReadEmulator(const FilePath : String; ID: Integer);
var
 sl : TStringList;
 i  : INteger;
 fname : String;
 name, value : String;
begin
  FName := FilePath + 'Emulators\' + IntToStr (ID) + '.emu';
  if not FileExists (FName) then
   raise Exception.Create('Нет файла эмуляции: ' + FName);
  sl := TStringList.Create;
  sl.LoadFromFile(Fname);
  ReadEmulator(sl);
  sl.Free;
end;

procedure TEmulatorDevice.ReadEmulator(sl: TStringList);
var
 i  : Integer;
 name, value : String;
begin
  if pos ('# SP', sl.Strings[0]) > 0 then
  begin
    MakeEmulatorFromLogFile(sl);
    Exit;
  end;
  i := 0;
  while (I < sl.Count) do
  begin
     sl.Strings[i] := Trim (sl.Strings[i]);
     if (Length(sl.Strings[i]) > 0) and (Sl.Strings[i][1] = '#') then
      sl.Delete(i)
      else Inc (i);

  end;
  if (sl.Count mod 2) <> 0 then
   raise Exception.Create('Число строк не кратно двум');
  if (em = nil) then em := TStringList.Create;
  i := 0;
  while (i < sl.Count) do
  begin
    name := sl.Strings[i];
    value := sl.Strings[i+1];
    em.Add(name + '=' + value);
    inc (i,2);
  end;
end;

procedure TEmulatorDevice.Request (PB : PByteArray; Count : Integer);
var
   i : Integer;
   temp : string;
begin
 AnswerPos := 0;
 ReqString := '';
 for i := 0 to Count-1 do
 begin
    ReqString  := ReqString  + ' ' + IntToHex(pb[i],2);
 end;
 if (Length (ReqString) > 0) then
  delete (ReqString,1,1);
 AnsString := '';
 FCounter := 0;
 while (FCounter < em.Count) and (AnsString = '') do
 begin
   if em.Names[FCounter] = ReqString then
     AnsString := em.ValueFromIndex [FCounter];
   inc (FCounter);
 end;
 SetLength (AnsBuffer,2048);
 temp := AnsString;
 i := 0;
 while ( temp <> '') do
 begin
   AnsBuffer[i] := StrToInt('$' + Fetch (temp,' '));
   inc (i);
 end;
 SetLength(AnsBuffer,i);
end;

end.
