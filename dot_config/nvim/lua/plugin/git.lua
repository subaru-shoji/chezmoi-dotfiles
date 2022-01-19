return {
	{
		"TimUntersberger/neogit",
		config = function()
			require("neogit").setup({ integrations = { diffview = true } })
		end,
	},
	{ "tyru/open-browser-github.vim", requires = "tyru/open-browser.vim" },
	{ "iberianpig/tig-explorer.vim", requires = { "rbgrouleff/bclose.vim" } },
	{ "emmanueltouzery/agitator.nvim" },
}
