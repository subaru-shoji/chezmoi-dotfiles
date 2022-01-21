-- https://github.com/aerospike/aerospike-lua-core/blob/master/src/as.lua
return {
    merge = function(m1, m2, f)
        local mm = {}
        for k, v in map.pairs(m1) do mm[k] = v end
        for k, v in map.pairs(m2) do
            mm[k] =
                (mm[k] and f and type(f) == 'function' and f(m1[k], m2[k])) or v
        end
        return map(mm, map.size(m1) + map.size(m2))
    end
}
