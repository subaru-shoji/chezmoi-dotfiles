-- https://github.com/aerospike/aerospike-lua-core/blob/master/src/as.lua
Util = {
	mergeDic = function(m1, m2)
		local mm = {}
		for k, v in pairs(m1) do
			mm[k] = v
		end
		for k, v in pairs(m2) do
			mm[k] = v
		end
		return mm
	end,
	concatList = function(m1, m2)
		local mm = {}
		for _, v in ipairs(m1) do
			table.insert(mm, v)
		end
		for _, v in ipairs(m2) do
			table.insert(mm, v)
		end
		return mm
	end,
	contains = function(tab, val)
		for _, value in ipairs(tab) do
			if value == val then
				return true
			end
		end

		return false
	end,
	capitalize = function(str)
		return (str:gsub("^%l", string.upper))
	end,
}

return Util
