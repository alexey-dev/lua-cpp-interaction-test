local Base = require("isortmethod")

local RetTable = {}
setmetatable(RetTable, { __index=Base })

function SortArray(Arr)
	local Length = #Arr
	local WasSwaps = false
	repeat 		
		WasSwaps = false	
		for i=2, Length do
			if Arr[i-1] < Arr[i] then
				WasSwaps = true	
				-- Swap elements
				tmp = Arr[i-1] 
				Arr[i-1] = Arr[i]
				Arr[i] = tmp				
			end 
		end		
	until WasSwaps == false
end

RetTable.Sort = SortArray
RetTable.MethodName = "Bubble"

return RetTable