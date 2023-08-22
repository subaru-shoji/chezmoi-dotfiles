return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSUpdateSync" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				ignore_install = { "phpdoc" },
				sync_install = true,
				highlight = { enable = true },
				indent = { enable = true, disable = { "dart" } },
			})
			vim.o.foldmethod = "expr"
			vim.o.foldexpr = "nvim_treesitter#foldexpr"
		end,
	},
}
