function U_Val (val, qual)
	if qual ~= opc.da.tekon.ItemData.QUALITY_GOOD then
		return "---"
	end
    return 	math_round (val.Number,1) .. " �"
end

local a;
a = 1;
a = U_Val  (1,0);

function I_Val (val, qual)
	if qual ~= opc.da.tekon.ItemData.QUALITY_GOOD then
		return "---"
	end
    return 	math_round (val.Number,1) .. " A"
end

local combo1 = 
{
 [1] = 'Hello';
}


function Status (val, qual)
	if qual ~= opc.da.tekon.ItemData.QUALITY_GOOD then
		return "---"
	end
        if (val.Integer == 0) then
          return "����������" 
        end
        if (val.Integer == 1) then
          return "�� ���" 
        end
        if (val.Integer == 2) then
          return "�� �������" 
        end
        return "����������.."..val.Integer 
end

function StatusHi (val, qual)
	if qual ~= opc.da.tekon.ItemData.QUALITY_GOOD then
		return "---"
	end
        if (val.Integer == 3) then
          return "����������" 
        end
        if (val.Integer == 5) then
          return "�� ���" 
        end
        if (val.Integer == 4) then
          return "�� �������" 
        end
        return "����������.."..val.Integer 
end

