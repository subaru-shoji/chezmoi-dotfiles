return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
		},
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("neodev").setup({})

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver", "clojure_lsp" },
			})
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason-lspconfig").setup_handlers({
				function(server_name) -- default handler (optional)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = { "*.lua", "*.dart", "*.clj" },
				callback = function()
					vim.lsp.buf.format()
				end,
			})

			-- vim.cmd([[autocmd BufWritePre ".lua,"*.rs,*.dart lua vim.lsp.buf.format(nil, 1000)]])
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
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
}
