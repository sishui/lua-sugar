
local os           = os
local table        = table
local setmetatable = setmetatable

local mt = {
	now = os.time,
}
mt.__index = mt

function mt.timezone()
	if not mt._timezone then
		local now = os.time()
		mt._timezone =  os.difftime(now, os.time(os.date("!*t", now))) / 3600
	end
	return mt._timezone
end

function mt.days(year, month)
	return os.date("%d",os.time({year= year or os.date("%Y"), month = (month or os.date("%m") + 1), day = 0}))
end

return setmetatable({}, mt)