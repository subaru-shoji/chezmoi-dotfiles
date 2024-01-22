local plugins = {}

local concatList = require("util").concatList

local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugin/filetype"
for _, file in ipairs(vim.fn.globpath(plugin_dir, "*.lua", false, true)) do
	local plugin = file:match("^.+/(.+).lua$")
	plugins = concatList(plugins, require("plugin/filetype/" .. plugin))
end

return plugins
