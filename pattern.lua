
local pairs        = pairs
local error        = error
local setmetatable = setmetatable

local P = {
	MATCH_FILE_NAME = "^.+[/|\\](.+)$",                                                                   -- or ^.+[/|\\](.+)%..+$
	MATCH_FILE_EXT  = "^.+%.(.+)$",                                                                       --
	MATCH_EMAIL     = "[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?",                            --
	MATCH_UTF8      = "[\0-\x7F\xC2-\xF4][\x80-\xBF]*",                                                   --
	MATCH_IPv4      = "(%d+)%.(%d+)%.(%d+)%.(%d+)",                                                       -- need check %d+ >=0 and %d+ <=255
	MATCH_IPv6      = "([%a%d]+):([%a%d]+):([%a%d]+):([%a%d]+):([%a%d]+):([%a%d]+):([%a%d]+):([%a%d]+)",  --

	GSUB_IPv6       = "[%a%d]+%:?",                                                                       -- _, count = string.gsub(s, GSUB_IPv6, ""), if count == 8 then return true end
	GSUB_COUNT      = "[^\x80-\xC1]",                                                                     -- _, count = string.gsub(s, GSUB_COUNT, ""),

	-- VERIFY_IPv4     = "^(%d+)%.(%d+)%.(%d+)%.(%d+)$",
	VERIFY_IPv6     = "^([%a%d]+):([%a%d]+):([%a%d]+):([%a%d]+):([%a%d]+):([%a%d]+):([%a%d]+):([%a%d]+)$",
}


local M = {
	__metatable = "read only table", 
	__index = P,
	__pairs = function() return pairs(P) end,
	__newindex = function (t,k,v)
		error("attempt to update a read-only table", 2)
	end,
}

return setmetatable({}, M)
