
local error        = error
local setmetatable = setmetatable

local M = {
	__len = function(self)
		return self._last - self._first + 1
	end,
	_first = 0,
	_last = -1,
}
M.__index = M

M.__call = function()
	return setmetatable({}, M)
end

function M.push(self, value)
	self._last  = self._last + 1
	self[self._last] = value
end

function M.pop(self)
	if self._first > self._last then
		return nil
	end
	local result = self[self._first]
	self[self._first] = nil
	if self._first == self._last then
		self._first = 0
		self._last = -1
	else
		self._first = self._first + 1
	end
	return result
end

function M.len(self)
	return #self
end

function M.clear(self)
	for i = self._first, self._last do
		self[i]=nil
	end
	self._first = 0
	self._last = -1
end

return setmetatable({
	new = function() return setmetatable({}, M) end,
	__index = M
}, M)