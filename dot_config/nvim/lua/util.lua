-- https://github.com/aerospike/aerospike-lua-core/blob/master/src/as.lua
return {
    merge = function(m1, m2, f)
        local mm = {}
        for k, v in pairs(m1) do mm[k] = v end
        for k, v in pairs(m2) do mm[k] = v end
        return mm
    end
}
