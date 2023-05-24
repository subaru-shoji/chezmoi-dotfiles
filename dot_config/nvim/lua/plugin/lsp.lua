return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
		},
		config = function()
			require("neodev").setup({})

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
			})
			local lspconfig = require("lspconfig")

			require("mason-lspconfig").setup_handlers({
				function(server_name) -- default handler (optional)
					lspconfig[server_name].setup({})
				end,
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					})
				end,
			})

			lspconfig.dartls.setup({})

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = { "*.lua" },
				callback = function()
					vim.lsp.buf.format()
				end,
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { "stylua", "jq" },
				automatic_installation = false,
				handlers = {},
			})
			require("null-ls").setup({})
		end,
	},
	{
		"onsails/lspkind-nvim",
		config = function()
			require("lspkind").init()
		end,
	},
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({})
		end,
	},
}
