unit parser;

interface

type
 TObjectType = (otUnck, otString, otStringEx, otCombo, otComboEx);


 TSimpleObject = class
 private

   arguments : array of string;
   argumCount : Integer; // ���������� ��������� � �������
   FName: string;
   FObjTyp : TObjectType;
   function ObjNameToString : String;
 public
  // ������� ������, ��������� ������� ������
  constructor Create (const Input : String);
  // �������� �������������� ������� � ������
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
 Starguments : string; // ������ ����������
 i, j : Integer;

begin
  tmp := Input;
  Name := Fetch (tmp , ' = ');
  tmpType := Fetch (tmp , ' (');
  FObjTyp := otUnck;
    if tmpType =  topc_string then   // ������� ������
      FObjTyp := otString
    else
      if tmpType = topc_string_min_max then  // ������ � ���������� ����������
        FObjTyp := otStringEx
    else
      if tmpType = topc_combo then          // ���� � ���������� �������
        FObjTyp := otCombo
    else
      if tmpType = topc_combo_ex then       // ����������� ���� � ���������� �������
        FObjTyp := otComboEx;
 // ������ ���������� � arguments
    Starguments := Fetch(tmp, ' )') + ' ,'; // ������� ������ �  ��������� �������
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
             arguments[i] := Fetch(Starguments, ' ,'); //��������� ������
             argumCount := j;                        // ���������� ��������� � �������
             Inc(j);
             if Starguments = '' then          // ���� ����� ������� �� �����
               Exit
             else
               Continue;                       // ���� ��� ����������
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
  Starguments : string; // ��������� ��� ������������ ������ �������
begin
  if FObjTyp = otUnck then
  begin
     // �� ���� ��� ��� �� ��� ���
     Result := '';
     Exit;
  end;
  Starguments := FName + ' = ' + ObjNameToString + ' (';
  for I := 0 to argumCount do
    Starguments := Starguments +  arguments[i] + ',';  // ��������� ���������
// � ����� �������� ������ �������, ������� ��
  Delete(Starguments, Length(Starguments),1);
// ������������� ����������� ������ � ���������� ������
  Result := Starguments + ')';
end;
//***********************************************************

end.
