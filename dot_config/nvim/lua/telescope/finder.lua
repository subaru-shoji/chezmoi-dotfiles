local actions = require("telescope.actions")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")

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

return M
