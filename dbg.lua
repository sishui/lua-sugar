
local type     = type
local tostring = tostring
local debug    = debug
local string   = string
local table    = table

local function stack2string()
	start = start or 2
	max = max or 20 
	local texts = {}
	for i = start, max do
		local info = debug.getinfo( i, "nSlu") 
		if info == nil then break end
		texts[#texts+1] = string.format("[ line : %-4d]  %-10s [ nup: %-3d] :: %s", info.currentline, info.name or "", info.nups or 0, info.source or "" )
 
		local index = 1
		while true do
			local name, value = debug.getlocal(i, index)
			if name == nil then break end
			index = index + 1
			if type(value) == 'string' then
				texts[index] = string.format( "[%s] = %s", name, value )
			elseif type(value) == "number" then
				texts[index] = string.format( "[%s] = %.2f", name, value )
			else
				texts[index] = string.format( "[%s] = %s", name, tostring(value) )
			end
		end
	end
	return table.concat(texts, '\r\n')
end

local M = {}

function M.getinfo(start, max)
	return stack2string(start, max)
end

function M.dump(start, max)
	print(stack2string(start, max))
end

return M