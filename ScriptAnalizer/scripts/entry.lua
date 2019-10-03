dofile2 ("demo1.lua")
dofile2 ("demo2.lua")


function NagrevStatus (val, qual)
	if qual ~= opc.da.tekon.ItemData.QUALITY_GOOD then
		return "---"
	end
	local text = val.Integer .. "%"
	if text ~= nil then 
      return text
	end
	return "0000000000"
end
str1 = topc_string (" [Комментарий]")


function main_custom()

end

function NagrevStatus2 (val, qual)
	if qual ~= opc.da.tekon.ItemData.QUALITY_GOOD then
		return "---"
	end
	local text = val.Integer .. "%"
	if text ~= nil then 
      return text
	end
	return "11111111111"
end