function GetScriptPath()
	local Info = debug.getinfo(1,'S');
	local ScriptPath = Info.source:match[[^@?(.*[\/])[^\/]-$]]
	return ScriptPath
end

local ScriptPath = GetScriptPath()

package.path = package.path .. "/?.lua;" .. ScriptPath .. "utils/?.lua;" .. ScriptPath .. "sorts/?.lua"

local Inspect = require("inspect")
print ( "----Lua starts---- " )
local Sorts = {
	Bubble = require("bubble"),
	Selection = require("selection"),
	Insertion = require("insertion")
}

print ( "ArrFromC is ",Inspect(ArrFromC))

function DoArraySort(Arr, SortMethod)
	print ( "Sort method is "..SortMethod.MethodName)
	print ( "Array before sort:", Inspect(Arr) )

	SortMethod.Sort(Arr)

	print ( "Array after sort:", Inspect(Arr) )
end

local ArrToSort = ArrFromC

DoArraySort(ArrToSort, Sorts.Insertion)

print ( "----Lua ends---- " )

return ArrToSort
