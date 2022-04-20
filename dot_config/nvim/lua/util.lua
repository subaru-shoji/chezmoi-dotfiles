-- https://github.com/aerospike/aerospike-lua-core/blob/master/src/as.lua
Util = {
    merge = function(m1, m2)
        local mm = {}
        for k, v in pairs(m1) do mm[k] = v end
        for k, v in pairs(m2) do mm[k] = v end
        return mm
    end,
    contains = function(tab, val)
        for _, value in ipairs(tab) do
            if value == val then return true end
        end

        return false
    end
}

return Util
