return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.lsp.enable({ "lua_ls", "ts_ls", "biome", "dartls", "pyright", "ruff_lsp" })
		end,
	},
}
