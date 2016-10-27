
local string       = string
local assert       = assert
local table        = table
local getmetatable = getmetatable

local mt = getmetatable("")
local __string = mt.__index


function mt.__add(a, b) return a .. b end
function mt.__sub(a, b) return string.gsub(a, b, "") end
function mt.__mul(a, b) return string.rep(a, b) end
function mt.__div(a, b) return __string.split(a, b, true) end
function mt.__mod(a, b)
	if type(b) == "table" then
		return string.format(a, table.unpack(b))
	else
		return string.format(a, b)
	end
end

local function __index_for_utf8(self, i, j)
	i = i <= 0 and 1 or i
	j = j or i
	local index = 1
	local begin
	local _end
	local count = 1
	for u in string.gmatch(self,"[\0-\x7F\xC2-\xF4][\x80-\xBF]*") do
		if i == index then
			begin = count
		end
		count = count + #u
		if j == index then
			_end = count - 1
		end
		index = index + 1
		if begin and _end then
			return string.sub(self, begin, _end)
		end
	end
	return nil
end

function mt.__index(self, key)
	if type(key) == "number" then
		local len = #self
		if key > len or key < -len or key == 0 then return nil end
		return string.sub(self, key, key)
	else
		print("fucking")
		return __string[key]
	end
end

function mt.__call(self, i, j)
	local _type = type(i)
	if _type == "string" then
		return string.match(self, i, j)
	elseif _type == "number" then
		local len = #self
		if i > len or i < -len or i == 0 then return nil end
		return string.sub(self, i, j or i)
	else
		assert(false)
	end
end

function __string.split(self, pattern, plain)
	local fields = {}
	local pos1, pos2, size
	repeat
		pos1, pos2 = string.find(self, pattern, 1, plain or false)
		size = #fields
		if not pos1 or pos1 > pos2 then
			if size ~= 0 then
				fields[size+1] = self
			end
			break
		end
		fields[size+1] = string.sub(self, 1, pos1 - 1)
		self = string.sub(self, pos2 + 1)
	until pos1 == nil
	return fields
end

function __string.hex(self)
	return string.gsub(self, '.', function (c)
		return string.format('%02X ', string.byte(c))
	end)
end

function __string.trim(self)
	return string.gsub(self, "[ \t\n\r]+", "")
end

function __string.hash(self)
	local h = 0
	local len = string.len(self)
	local max = 2147483647
	local min = -2147483648
	local cycle = 4294967296
 
	for i=1, len do
		h = 31 * h + string.byte(string.sub(self, i, i))
		while h > max do
			h = h - cycle
		end
		while h < min do
			h = h + cycle
		end
	end
	return h
end

