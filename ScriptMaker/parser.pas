unit parser;

interface

type
 TObjectType = (otUnck, otString, otStringEx, otCombo, otComboEx);


 TSimpleObject = class
 private

   arguments : array of string;
   argumCount : Integer; // Количество элементов в массиве
   FName: string;
   FObjTyp : TObjectType;
   function ObjNameToString : String;
 public
  // создаем объект, распарсив входную строку
  constructor Create (const Input : String);
  // обратное преобразование объекта в строку
  function ToString : String;
  property Name : string read FName write FName;
 end;


implementation
Uses IdGlobal;

{ TSimpleObject }
const
 topc_string = 'topc_string';
 topc_string_min_max = 'topc_string_min_max';
 topc_combo = 'topc_combo';
 topc_combo_ex = 'topc_combo_ex';

constructor TSimpleObject.Create(const Input: String);
var
 tmp : String;
 tmpType : String;
 Starguments : string; // строка аргументов
 i, j : Integer;

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
      if tmpType = topc_combo then          // окно с выпадающим списком
        FObjTyp := otCombo
    else
      if tmpType = topc_combo_ex then       // расширенное окно с выпадающим списком
        FObjTyp := otComboEx;
 // Пробую распарсить в arguments
    Starguments := Fetch(tmp, ' )') + ' ,'; // удаляем скобку и  вставляем запятую
    if Starguments = '' then
      begin
        argumCount := 0;
        Exit;
      end
     else
       begin
         j := 1;
         argumCount := 0;
         for I := 0 to j do
           begin
             arguments[i] := Fetch(Starguments, ' ,'); //заполняем массив
             argumCount := j;                        // количество элементов в массиве
             Inc(j);
             if Starguments = '' then          // если пусто выходим из цикла
               Exit
             else
               Continue;                       // если нет продолжаем
           end;
      end;



end;

function TSimpleObject.ObjNameToString: String;
begin
 case FObjTyp of
   otString:  Result := topc_string;
   otStringEx:  Result := topc_string_min_max;
   otCombo: Result := topc_combo;
   otComboEx : Result := topc_combo_ex;
 end;
end;

//************************************************************
function TSimpleObject.ToString: String;
var
  I: Integer;
  Starguments : string; // переменая для формирования строки объекта
begin
  if FObjTyp = otUnck then
  begin
     // не знаю что это за тип был
     Result := '';
     Exit;
  end;
  Starguments := FName + ' = ' + ObjNameToString + ' (';
  for I := 0 to argumCount do
    Starguments := Starguments +  arguments[i] + ',';  // заполняем аргументы
// в конце появится лишняя запятая, удаляем ее
  Delete(Starguments, Length(Starguments),1);
// устанавливаем закрывающую скобку и возвращаем строку
  Result := Starguments + ')';
end;
//***********************************************************

end.
