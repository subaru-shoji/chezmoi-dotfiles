return {
	{
		"yorickpeterse/nvim-window",
		config = function()
			-- firtst char is dummy for adjust.
			require("nvim-window").setup({
				chars = { "a", "s", "d", "f", "z", "x", "c", "v", "b", "n" },
			})
		end,
	},
	{
		"sindrets/winshift.nvim",
		config = function()
			require("winshift").setup({})
		end,
	},
}
