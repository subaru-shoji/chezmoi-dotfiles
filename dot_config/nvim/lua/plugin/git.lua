return {
	{
		"TimUntersberger/neogit",
		lazy = true,
		cmd = { "Neogit" },
		config = function()
			require("neogit").setup({ integrations = { diffview = true } })
		end,
	},
	{ "tyru/open-browser-github.vim", dependencies = "tyru/open-browser.vim" },
	{ "iberianpig/tig-explorer.vim", dependencies = { "rbgrouleff/bclose.vim" } },
	{ "emmanueltouzery/agitator.nvim" },
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "petertriho/nvim-scrollbar" },
		config = function()
			require("gitsigns").setup()
			require("scrollbar.handlers.gitsigns").setup()
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		config = function()
			require("telescope").load_extension("lazygit")
		end,
	},
}
