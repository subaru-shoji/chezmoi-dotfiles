return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			local actions = require("telescope.actions")

			local open_with_trouble = require("trouble.sources.telescope").open

			local function smart_select_action(prompt_bufnr)
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")

				local selection = action_state.get_selected_entry()
				if not selection then
					return
				end

				actions.close(prompt_bufnr)

				-- 現在のバッファのファイルタイプを取得（判定は is_special で実施）

				-- 特殊バッファ（サイドバー/診断など）判定用リスト
				local special_filetypes = {
					Trouble = true,
					helptag = true,
					helps = true,
					qf = true,
				}
				local function is_special(buf)
					local ft = vim.api.nvim_buf_get_option(buf, "filetype")
					if special_filetypes[ft] then
						return true
					end
					local name = vim.api.nvim_buf_get_name(buf)
					return name:match("nvim%-tree")
						or name:match("Trouble")
						or name == ""
						or not vim.api.nvim_buf_get_option(buf, "buflisted")
				end

				-- nvimtreeやTroubleなど特殊バッファの場合、他のウィンドウを探す
				if is_special(0) then
					-- 通常のバッファを持つウィンドウを探す
					local target_win = nil
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						local buf = vim.api.nvim_win_get_buf(win)
						local buf_ft = vim.api.nvim_buf_get_option(buf, "filetype")
						local buf_name = vim.api.nvim_buf_get_name(buf)

						-- 通常のファイルバッファかチェック
						if not is_special(buf) then
							target_win = win
							break
						end
					end

					if target_win then
						vim.api.nvim_set_current_win(target_win)
						vim.cmd("edit " .. selection.path)
					else
						-- 適切なウィンドウが見つからない場合は垂直分割
						vim.cmd("vsplit " .. selection.path)
					end
				else
					-- 通常のバッファの場合はそのまま開く
					vim.cmd("edit " .. selection.path)
				end
			end

			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
							["<esc>"] = actions.close,
							["<C-u>"] = false,
							["<C-t>"] = open_with_trouble,
							-- ["<CR>"] = smart_select_action,
						},
						n = { ["<c-t>"] = open_with_trouble },
					},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
					oldfiles = {
						cwd_only = true,
					},
				},
			})
		end,
	},
	{
		"fdschmidt93/telescope-egrepify.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("egrepify")
		end,
	},
	{
		"jonarrien/telescope-cmdline.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("cmdline")
		end,
	},
}
