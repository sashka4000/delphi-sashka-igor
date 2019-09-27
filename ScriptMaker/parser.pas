unit parser;

interface
Uses System.Classes;

type
 TObjectType = (otUnck, otString, otStringEx, otComboEx);

 TStringArray = array of String;

 TSimpleObject = class
 private
   slArguments : TStringArray;
   FName: string;
   FObjTyp : TObjectType;
    procedure SetArguments(const Value: TStringArray);
 public
  // создаем объект, распарсив входную строку
  constructor Create (const Name : String);
  destructor  Destroy; override;
  procedure Parse (const Input : String);  virtual; // на всякий случай если кто-то захочет поменять
  function ObjTypeToString : String;
  function ToString : String;
  property Name : string read FName write FName;
  property ObjType : TObjectType read FObjTyp write FObjTyp;
  property Arguments : TStringArray read slArguments write SetArguments;
 end;

  TStringParser = class (TSimpleObject)
  private
  public
    constructor Create (const Name : String);
  end;

  TComboParser = class (TSimpleObject)
  private
  public
    constructor Create (const Name : String);
  end;


implementation
Uses IdGlobal, System.SysUtils;

const
 topc_string = 'topc_string';
 topc_string_min_max = 'topc_string_min_max';
 topc_combo_ex = 'topc_combo_ex';

{ TSimpleObject }

constructor TSimpleObject.Create (const Name : String);
begin
   FName := name;
   FObjTyp :=  otUnck;
   SetLength(slArguments,1);
   Arguments [0] := '[Комментарий]';
end;

destructor TSimpleObject.Destroy;
begin
  inherited;
end;

function TSimpleObject.ObjTypeToString: String;
begin
 case FObjTyp of
   otString:  Result := topc_string;
   otStringEx:  Result := topc_string_min_max;
   otComboEx : Result := topc_combo_ex;
 end;
end;

procedure TSimpleObject.Parse(const Input: String);
var
 tmp : String;
 tmpType : String;
 Starguments : string; // строка аргументов
 i : Integer;
 sl : TStringList;
begin
  tmp := Input;
  Name := Fetch (tmp , ' = ');
  tmpType := Fetch (tmp , ' (');
  FObjTyp := otUnck;
    if tmpType =  topc_string then   // простая строка
      FObjTyp := otString
    else
      if tmpType = topc_string_min_max then  // строка с граничными значениями
        FObjTyp := otStringEx
    else
      if tmpType = topc_combo_ex then       // расширенное окно с выпадающим списком
        FObjTyp := otComboEx;
   // Пробую распарсить в arguments

   Starguments := Fetch(tmp, ')'); // удаляем скобку

   i := 0;
   SetLength(slArguments,10);
   while (Starguments <> '') do
   begin
     slArguments [i] := Fetch (Starguments,',');
     if i = 0
     then
      slArguments [i] := StringsReplace(slArguments [i],['"'],[''])
     else
      slArguments [i] := StringsReplace(slArguments [i],['"','{','}','[',']'],['','','','','']);    // удаляем все спец символы
     inc (i);
     if i = Length (slArguments) then
        SetLength (slArguments, i+10);
   end;
   SetLength (slArguments, i);
end;

procedure TSimpleObject.SetArguments(const Value: TStringArray);
var
  I: Integer;
begin
  SetLength(slArguments,Length(Value) + 1 );  // 1 это комментарий
  for I := 0 to High(Value) do
    slArguments [i + 1] := Value[i];
end;

//************************************************************
function TSimpleObject.ToString: String;
var
  I: Integer;
  tmp : String;
begin
  if FObjTyp = otUnck then
  begin
     // не знаю что это за тип был
     Result := '';
     Exit;
  end;
  Result := FName + ' = ' + ObjTypeToString + ' (';
  for I := 0 to High(slArguments) do
  begin
    if i = 0 then
    begin
      Result := Result + '"';
      if Length(slArguments[i]) > 0 then
       Result := Result + ' ';
      Result := Result +  slArguments[i] + '",';
    end else
    begin
      if (ObjType = otComboEx) then
      begin
       if (i = 1) then
        Result := Result + '{';
       tmp :=  slArguments[i];
       Result := Result + Format('[%s]="%s",',[Fetch(tmp,'='),tmp]);
       if (i = High(slArguments)) then
       begin
        Result[Length(Result)] := '}';
        Result := Result + ',';
       end;
      end else
       Result := Result +  slArguments[i] + ',';
    end;
  end;
// в конце появится лишняя запятая, удаляем ее
  Delete(Result, Length(Result),1);
// устанавливаем закрывающую скобку и возвращаем строку
  Result := Result + ')';
end;
//***********************************************************

{ TStringParser }

constructor TStringParser.Create (const Name : String);
begin
 inherited;
 ObjType := otString;
end;

{ TComboParser }

constructor TComboParser.Create (const Name : String);
begin
 inherited;
 ObjType := otComboEx;
 SetLength(slArguments,3);
 slArguments[1] := '0=Выключить';
 slArguments[2] := '1=Включить';
end;

end.
