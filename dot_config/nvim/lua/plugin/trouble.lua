return {
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		config = function()
			require("trouble").setup({
				focus = true,
				keys = {
					C = "close",
				},
			})

			vim.api.nvim_create_autocmd("QuickFixCmdPost", {
				callback = function()
					vim.cmd([[Trouble qflist open]])
				end,
			})
		end,
	},
}
