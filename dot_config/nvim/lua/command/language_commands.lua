local language_commands = {}

local language_command_dir = vim.fn.stdpath("config") .. "/lua/command/filetype"

for _, file in ipairs(vim.fn.globpath(language_command_dir, "*.lua", false, true)) do
	local filetype = file:match("^.+/(.+).lua$")
	language_commands[filetype] = require("command/filetype/" .. filetype)
end

return language_commands
