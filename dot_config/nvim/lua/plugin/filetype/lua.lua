return {
	{
		"tjdevries/nlua.nvim",
		config = function()
			require("nlua.lsp.nvim").setup(require("lspconfig"), {})
			vim.cmd([[autocmd BufWritePost *.lua silent! lua require'nlua'.format_file()]])
		end,
	},
	{ "euclidianAce/BetterLua.vim" },
}
