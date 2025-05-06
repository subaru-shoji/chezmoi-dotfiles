return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
			"saghen/blink.cmp"
		},
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("neodev").setup({})

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"elmls",
					"fsautocomplete",
					"pyright",
					"rust_analyzer",
				},
			})
			local lspconfig = require("lspconfig")

			local function server_register(server_name)
				local opts = {}
				local success, req_opts = pcall(require, "plugins.lsp.servers." .. server_name)
				if success then
					opts = req_opts
				end
				opts.capabilities = require("blink.cmp").get_lsp_capabilities(opts.capabilities)
				lspconfig[server_name].setup(opts)
			end

			require("mason-lspconfig").setup_handlers({ server_register })
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
