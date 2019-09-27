unit parser;

interface
Uses System.Classes;

type
 TObjectType = (otUnck, otString, otStringEx, otCombo, otComboEx);

 TStringArray = array of String;

 TSimpleObject = class
 private
   slArguments : TStringArray;
   FName: string;
   FObjTyp : TObjectType;
 public
  // создаем объект, распарсив входную строку
  constructor Create;
  destructor  Destroy; override;
  procedure Parse (const Input : String);  virtual; // на вс€кий случай если кто-то захочет помен€ть
  function ObjTypeToString : String;
  function ToString : String;
  property Name : string read FName write FName;
  property ObjType : TObjectType read FObjTyp write FObjTyp;
  property Arguments : TStringArray read slArguments;
 end;

  TStringParser = class (TSimpleObject)
  private
  public
    constructor Create;
  end;


implementation
Uses IdGlobal;

const
 topc_string = 'topc_string';
 topc_string_min_max = 'topc_string_min_max';
 topc_combo = 'topc_combo';
 topc_combo_ex = 'topc_combo_ex';

{ TSimpleObject }

constructor TSimpleObject.Create;
begin
   FName := '';
   FObjTyp :=  otUnck;
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
   otCombo: Result := topc_combo;
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
    if tmpType =  topc_string then   // проста€ строка
      FObjTyp := otString
    else
      if tmpType = topc_string_min_max then  // строка с граничными значени€ми
        FObjTyp := otStringEx
    else
      if tmpType = topc_combo then          // окно с выпадающим списком
        FObjTyp := otCombo
    else
      if tmpType = topc_combo_ex then       // расширенное окно с выпадающим списком
        FObjTyp := otComboEx;
   // ѕробую распарсить в arguments

   Starguments := Fetch(tmp, ')'); // удал€ем скобку и  вставл€ем зап€тую
   i := 0;
   SetLength(slArguments,10);
   while (Starguments <> '') do
   begin
     slArguments [i] := Fetch (Starguments,',');
     inc (i);
     if i = Length (slArguments) then
        SetLength (slArguments, i+10);
   end;
   SetLength (slArguments, i);
end;

//************************************************************
function TSimpleObject.ToString: String;
var
  I: Integer;
begin
  if FObjTyp = otUnck then
  begin
     // не знаю что это за тип был
     Result := '';
     Exit;
  end;
  Result := FName + ' = ' + ObjTypeToString + ' (';
  for I := 0 to High(slArguments) do
    Result := Result +  slArguments[i] + ',';  // заполн€ем аргументы
// в конце по€витс€ лишн€€ зап€та€, удал€ем ее
  Delete(Result, Length(Result),1);
// устанавливаем закрывающую скобку и возвращаем строку
  Result := Result + ')';
end;
//***********************************************************

{ TStringParser }

constructor TStringParser.Create;
begin
 inherited;
 Name := 'tobject_str';
 ObjType := otString;
 SetLength(slArguments,1);
 slArguments[0] := ' омментарий';
end;

end.
