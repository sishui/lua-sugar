
local table        = table
local setmetatable = setmetatable
local getmetatable = getmetatable

function table.clone(object)
	local lookup_table = {}
	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end
		local new_table = {}
		lookup_table[object] = new_table
		for key, value in pairs(object) do
			new_table[_copy(key)] = _copy(value)
		end
		return setmetatable(new_table, getmetatable(object))
	end
	return _copy(object)
end

local function __tostring(self, table_list, level)
	local result = ""
	level = level or 1
	table_list = table_list or {[self] = "__root"}
	local indent = string.rep("\t", level)

	for k, v in pairs(self) do
		local quo = type(k) == "string" and "\"" or ""
		local key_string = tostring(k)
		local value_string = tostring(v)
		local value_type = type(v)
		result = result .. indent .. "[" .. quo .. key_string .. quo .. "] = "
 
		if value_type == "table" then
			local mt = getmetatable(v)
			local name = table_list[v]
			if name then
				result = result .. value_string .. " ===> [\"" .. name .. "\"]\n"
			else
				table_list[v] = key_string
				result = result .. "{\n" .. __tostring(v, table_list, level+1) .. indent .. "}\n"
			end
		elseif value_type == "string" then
			result = result .. "\"" .. value_string .. "\"\n"
		else
			result = result .. value_string .. "\n"
		end
	end
 
	local mt = getmetatable(self)
	if mt then
		result = result .. "\n"
		local name = table_list[mt]
		if name then
			result = result .. tostring(mt) .. " ===> [\"" .. name .. "\"]\n"
		else
			result = result .. indent .. "__metatable = {\n" .. __tostring(mt, table_list, level+1) .. indent .. "}\n"
		end
		 
	end
	return result
end

function table.tostring(self)
	return tostring(self) .. " = {\n" .. __tostring(self) .. "}"
end
