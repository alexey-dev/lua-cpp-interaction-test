local Base = require("isortmethod")

local RetTable = {}
setmetatable(RetTable, { __index=Base })

function SortArray ( Arr )
	local Length = #Arr
	local Key = 0
	local i = 1
	
	for j = 2, Length do
		i = j - 1
		Key = Arr[j]		
		
		while i>=1 and Arr[i] < Key do
			Arr[i+1] = Arr[i]
			i = i - 1
			Arr[i+1] = Key
		end
	end
end

RetTable.Sort = SortArray
RetTable.MethodName = "Insertion"

return RetTable