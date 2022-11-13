return {
	{ "kevinhwang91/nvim-bqf" },
	{
		"mhinz/vim-grepper",
		config = function()
			vim.cmd([[
                augroup Grepper
                    autocmd!
                    autocmd User Grepper call setqflist([], 'r', {'context': {'bqf': {'pattern_hl': histget('/')}}}) | botright copen
                augroup END

            ]])

			vim.g.grepper = { open = 0, quickfix = 1, searchreg = 1, highlight = 1 }
		end,
	},
	{
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	},
}
