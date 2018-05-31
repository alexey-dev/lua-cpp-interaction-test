local Base = require("isortmethod")

local RetTable = {}
setmetatable(RetTable, { __index=Base })

function SortArray ( Arr )
	local Length = #Arr
	
	for i = 1, Length do
		BiggestInd = i
		for j = i, Length do
			if Arr[BiggestInd] < Arr[j] then
				BiggestInd = j
			end
		end
		
		if BiggestInd ~= i then
			tmp = Arr[BiggestInd]
			Arr[BiggestInd] = Arr[i]
			Arr[i] = tmp
		end
	end
end

RetTable.Sort = SortArray
RetTable.MethodName = "Selection"

return RetTable