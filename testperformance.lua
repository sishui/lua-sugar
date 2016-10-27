local os             = os
local print          = print
local string         = string
local collectgarbage = collectgarbage

return function(f, title)
	collectgarbage()
	local sp = "-------------"
	print(string.format("%s%s        begin        %s", sp, title or "", sp))
	local begin = os.clock()
	f()
	print(string.format("%s%s end cost: %f %s", sp, title or "", os.clock() - begin, sp))
end