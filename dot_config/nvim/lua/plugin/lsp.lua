return {
	{
		"neovim/nvim-lspconfig",
		requires = {
			"hrsh7th/vim-vsnip",
			"hrsh7th/vim-vsnip-integ",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			capabilities.textDocument.completion.completionItem.documentationFormat = {}
			capabilities.textDocument.signatureHelp.signatureInformation.documentationFormat = {}

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
				vim.lsp.handlers.signature_help,
				{ silent = true, focusable = false }
			)

			require("lspconfig").rust_analyzer.setup({ capabilities = capabilities })
			require("lspconfig").clojure_lsp.setup({})
			require("lspconfig").elmls.setup({})

			vim.cmd([[autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)]])
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		config = function()
			vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
		end,
	},
	{
		"onsails/lspkind-nvim",
		config = function()
			require("lspkind").init()
		end,
	},
}
