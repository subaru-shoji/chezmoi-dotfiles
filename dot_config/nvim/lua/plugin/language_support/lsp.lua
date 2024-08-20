return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
		},
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("neodev").setup({})

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"tsserver",
					"elmls",
					"fsautocomplete",
					"pyright",
					"ruff_lsp",
					"rust_analyzer",
				},
			})
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason-lspconfig").setup_handlers({
				function(server_name) -- default handler (optional)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["ruff_lsp"] = function()
					local on_attach = function(client, bufnr)
						-- Disable hover in favor of Pyright
						client.server_capabilities.hoverProvider = false
					end
					lspconfig["ruff_lsp"].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						init_options = {
							settings = {
								-- Any extra CLI arguments for `ruff` go here.
								args = {},
								lint = {
									enable = true,
								},
							},
						},
					})
				end,
			})

			lspconfig.ruby_lsp.setup({
				capabilities = capabilities,
			})
			lspconfig.steep.setup({
				capabilities = capabilities,
			})
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
