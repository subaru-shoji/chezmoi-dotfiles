return {
	{
		"mvllow/modes.nvim",
		config = function()
			vim.opt.cursorline = true
			require("modes").setup({ line_opacity = 0.2 })
		end,
	},
}
