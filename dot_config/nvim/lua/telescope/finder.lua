local actions = require("telescope.actions")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local conf = require("telescope.config").values

local language_commands = require("command.language_commands")
local capitalize = require("util").capitalize

local M = {}

M.my_custom_search = function()
	-- シェルコマンドを実行し、結果を取得
	local shell_command = "gh pr diff --name-only"
	local handle = io.popen(shell_command)
	local result = handle:read("*a")
	handle:close()

	-- 結果を行ごとに分割
	local files = {}
	for file in string.gmatch(result, "[^\r\n]+") do
		table.insert(files, file)
	end

	-- Telescopeピッカーの設定
	pickers
		.new({}, {
			prompt_title = "Github Pull Request Diff Search Results",
			finder = finders.new_table({
				results = files,
			}),
			sorter = sorters.get_generic_fuzzy_sorter(),
			previewer = previewers.vim_buffer_cat.new({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local selection = require("telescope.actions.state").get_selected_entry()
					actions.close(prompt_bufnr)
					-- 選択されたファイルを開く
					vim.cmd("edit " .. selection[1])
				end)
				return true
			end,
		})
		:find()
end

local function load_language_command()
	local filetype = vim.bo.filetype

	local language_command = language_commands[filetype]

	if language_command ~= nil then
		return language_command
	else
		return {} -- 空のテーブルを返す
	end
end

M.language_command_picker = function()
	local language_command = load_language_command()
	local prompt_title = capitalize(vim.bo.filetype) .. " Commands"

	pickers
		.new({}, {
			prompt_title = prompt_title,
			finder = finders.new_table({
				results = language_command,
				entry_maker = function(entry)
					return {
						value = entry[2],
						display = entry[1],
						ordinal = entry[1],
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = actions.get_selected_entry()
					vim.cmd(selection.value)
				end)
				return true
			end,
		})
		:find()
end

return M
