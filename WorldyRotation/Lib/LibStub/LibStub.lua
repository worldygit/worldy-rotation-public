local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function KwctFoaIvUExWariPLqpAZwjFvjFhLolydfLZgtXaoq(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


-- $Id: LibStub.lua 103 2014-10-16 03:02:50Z mikk $
-- LibStub is a simple versioning stub meant for use in Libraries.  http://www.wowace.com/addons/libstub/ for more info
-- LibStub is hereby placed in the Public Domain
-- Credits: Kaelten, Cladhaire, ckknight, Mikk, Ammo, Nevcairiel, joshborke
local LIBSTUB_MAJOR, LIBSTUB_MINOR = KwctFoaIvUExWariPLqpAZwjFvjFhLolydfLZgtXaoq('NTnJdBbjrfsXbTIeEbTjUeHhzVnjEEuggBGwGRzkOZJdihUdtKyhsaMTGliU3R1Yg=='), 2  -- NEVER MAKE THIS AN SVN REVISION! IT NEEDS TO BE USABLE IN ALL REPOS!
local LibStub = _G[LIBSTUB_MAJOR]

-- Check to see is this version of the stub is obsolete
if not LibStub or LibStub.minor < LIBSTUB_MINOR then
	LibStub = LibStub or {libs = {}, minors = {} }
	_G[LIBSTUB_MAJOR] = LibStub
	LibStub.minor = LIBSTUB_MINOR
	
	-- LibStub:NewLibrary(major, minor)
	-- major (string) - the major version of the library
	-- minor (string or number ) - the minor version of the library
	-- 
	-- returns nil if a newer or same version of the lib is already present
	-- returns empty library object or old library object if upgrade is needed
	function LibStub:NewLibrary(major, minor)
		assert(type(major) == KwctFoaIvUExWariPLqpAZwjFvjFhLolydfLZgtXaoq('wOVrMexoYgsvYGpNfTmhjGylhWxcyNahgxmlAVRrCIcgUrqwVZEPoRdc3RyaW5n'), KwctFoaIvUExWariPLqpAZwjFvjFhLolydfLZgtXaoq('aGFmlofJsDUhaEvILXdawXmLOQxjPofwNJtvtYereOvaVzURyWxbRoKQmFkIGFyZ3VtZW50ICMyIHRvIGBOZXdMaWJyYXJ5') (string expected)KwctFoaIvUExWariPLqpAZwjFvjFhLolydfLZgtXaoq('FgMtfaGumqZqJpgLXQphnbjwKQIpWbgkYGcIYLeilatfZrspknCTumnKQ0KCQltaW5vciA9IGFzc2VydCh0b251bWJlcihzdHJtYXRjaChtaW5vciwg')%d+KwctFoaIvUExWariPLqpAZwjFvjFhLolydfLZgtXaoq('syCVfHfJlUzDaOlWzsiaMYhRiWockvzIJeEgkWZEPOqJPTFaTQRLqlYKSksIA==')Minor version must either be a number or contain a number.KwctFoaIvUExWariPLqpAZwjFvjFhLolydfLZgtXaoq('wziWEQtneDPlaZeUmjjIuGtPwmvXyaYEFkpfOngxJjLjsvueoxtZdRiKQ0KCQkNCgkJbG9jYWwgb2xkbWlub3IgPSBzZWxmLm1pbm9yc1ttYWpvcl0NCgkJaWYgb2xkbWlub3IgYW5kIG9sZG1pbm9yID49IG1pbm9yIHRoZW4gcmV0dXJuIG5pbCBlbmQNCgkJc2VsZi5taW5vcnNbbWFqb3JdLCBzZWxmLmxpYnNbbWFqb3JdID0gbWlub3IsIHNlbGYubGlic1ttYWpvcl0gb3Ige30NCgkJcmV0dXJuIHNlbGYubGlic1ttYWpvcl0sIG9sZG1pbm9yDQoJZW5kDQoJDQoJLS0gTGliU3R1YjpHZXRMaWJyYXJ5KG1ham9yLCBbc2lsZW50XSkNCgktLSBtYWpvciAoc3RyaW5nKSAtIHRoZSBtYWpvciB2ZXJzaW9uIG9mIHRoZSBsaWJyYXJ5DQoJLS0gc2lsZW50IChib29sZWFuKSAtIGlmIHRydWUsIGxpYnJhcnkgaXMgb3B0aW9uYWwsIHNpbGVudGx5IHJldHVybiBuaWwgaWYgaXRzIG5vdCBmb3VuZA0KCS0tDQoJLS0gdGhyb3dzIGFuIGVycm9yIGlmIHRoZSBsaWJyYXJ5IGNhbiBub3QgYmUgZm91bmQgKGV4Y2VwdCBzaWxlbnQgaXMgc2V0KQ0KCS0tIHJldHVybnMgdGhlIGxpYnJhcnkgb2JqZWN0IGlmIGZvdW5kDQoJZnVuY3Rpb24gTGliU3R1YjpHZXRMaWJyYXJ5KG1ham9yLCBzaWxlbnQpDQoJCWlmIG5vdCBzZWxmLmxpYnNbbWFqb3JdIGFuZCBub3Qgc2lsZW50IHRoZW4NCgkJCWVycm9yKCg=')Cannot find a library instance of %q.'):format(tostring(major)), 2)
		end
		return self.libs[major], self.minors[major]
	end
	
	-- LibStub:IterateLibraries()
	-- 
	-- Returns an iterator for the currently registered libraries
	function LibStub:IterateLibraries() 
		return pairs(self.libs) 
	end
	
	setmetatable(LibStub, { __call = LibStub.GetLibrary })
end
    