local plugins = {}

local concatList = require("util").concatList
plugins = concatList(plugins, require("plugin/filetype/flutter"))
plugins = concatList(plugins, require("plugin/filetype/lua"))
plugins = concatList(plugins, require("plugin/filetype/typescript"))

return plugins
