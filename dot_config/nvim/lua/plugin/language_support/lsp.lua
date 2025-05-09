return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.lsp.enable({ "lua_ls", "ts_ls", "biome" })
		end,
	},
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({})
		end,
	},
	{
		"VidocqH/lsp-lens.nvim",
		config = function()
			require("lsp-lens").setup({})
		end,
	},
}
