local os     = os
local assert = assert

-- "Linux"   = "linux",
-- "Darwin"  = "macosx"
-- "FreeBSD" = "freebsd"
-- "SunOS"   = "sun"
-- "AIX"     = "aix"
-- "HP-UX"   = "hpux"
-- "QNX"     = "qnx"

if not os.PLATFORM then
	local ext = string.match(package.cpath, "%p[\\|/]?%.+(%a+)")
	if "dll" == ext then
		os.PLATFORM = "windows"
	elseif "so" == ext then
		local f = assert(io.popen("uname -s", 'r'))
		local s = assert(f:read('*a'))
		f:close()
		s = string.gsub(s, "[ \t\n\r]+", "")
		if "Darwin" == s then
			os.PLATFORM = "macosx"
		elseif "Linux" == s then
			os.PLATFORM = "linux"
		elseif "FreeBSD" == s then
			os.PLATFORM = "freebsd"
		end
	end
	os.PLATFORM = os.PLATFORM or "unknown"
end
