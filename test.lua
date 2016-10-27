require "osex"
print(os.PLATFORM)

local Q = require "queue"

for k, v in pairs( Q ) do
	print( k, v )
end
local q = Q()
q:push(1)
q:push(2)
q:push(3)

local q2 = Q.new()

print(q == q2)

print(#q, #q2)
print(q.pop(q), q2:pop())
print(q.len(q), q2:len())
require ("stringex")
local dbg = require "dbg"
function test()
	local i = "1111"
	return function()
		i = i .. "2"
		dbg.dump()
		return i
	end
end
test()()

local test = require "pattern"
-- test.MATCH_FILE_NAME = 1
local unix = "User/a/b_b/ext.-d/player/TT.Player.h"
local windwos = "C:\\windwos\\te_st\\TT.Player.cpp"
print(string.match(unix, test.MATCH_FILE_NAME))
print(string.match(windwos, test.MATCH_FILE_NAME))
print(string.match(unix, test.MATCH_FILE_EXT))
print(string.match(windwos, test.MATCH_FILE_EXT))

local email = "@asdfk.saf@12sfsdf.3123.cn"
print(string.match(email, test.MATCH_EMAIL))

local ips = {
    "1128.1.0.1",        -- ipv4
    "223.255.254.254",  -- ipv4
    "999.12345.0.0001",     -- invalid ipv4
    "1050:0:0:0:5:600:300c:326b",               -- ipv6
    "1050:0000:0000:0000:0005:0600:300c:326b",  -- ipv6
    "1050:::600:5:1000::",  -- contracted ipv6
    "129.garbage.9.1",  -- string
    129.10              -- error
}

local chunks = {ips[4]:match("^" .. test.MATCH_IPv6 .."$" )}
for k, v in pairs( chunks ) do
	print( k, v )
end


local __root = {
	[1] = 1,
	[2] = 2,
	a = 3,
	b = 4
}

require "tablex"

local readonly = table.readonly(__root, "__root")

table.dump(readonly)


