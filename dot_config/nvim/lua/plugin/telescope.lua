return {
	{
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "kdheepak/lazygit.nvim" },
		},
		config = function()
			vim.api.nvim_create_autocmd({ "User" }, {
				pattern = "TelescopeFindPre",
				callback = function()
					local buf = vim.api.nvim_win_get_buf(0)
					local normal_file_type = { "dashboard" }

					if require("util").contains(normal_file_type, vim.bo.filetype) then
						return
					elseif vim.bo[buf].modifiable == false then
						require("nvim-window").pick()
					end
				end,
			})

			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
							["<esc>"] = actions.close,
						},
					},
				},
			})
			require("telescope").load_extension("lazygit")
		end,
	},
}
