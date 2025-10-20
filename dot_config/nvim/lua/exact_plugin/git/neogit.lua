return {
	{
		"TimUntersberger/neogit",
		lazy = true,
		cmd = { "Neogit" },
		config = function()
			require("neogit").setup({ integrations = { diffview = true } })
		end,
	},
}
