return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			vim.api.nvim_create_autocmd({ "User" }, {
				pattern = "TelescopeFindPre",
				callback = function()
					local buf = vim.api.nvim_win_get_buf(0)
					local normal_file_type = { "dashboard", "NvimTree" }

					if require("util").contains(normal_file_type, vim.bo.filetype) then
						return
					elseif vim.api.nvim_win_get_config(0).relative ~= "" then
						-- close if current window is floating window.
						vim.api.nvim_win_close(0, false)
					elseif vim.bo[buf].modifiable == false then
						require("nvim-window").pick()
					end
				end,
			})

			local actions = require("telescope.actions")

			local open_with_trouble = require("trouble.sources.telescope").open

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
						},
						n = { ["<c-t>"] = open_with_trouble },
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
		"nvim-telescope/telescope-frecency.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("frecency")
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
