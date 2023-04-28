return {
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"RRethy/nvim-treesitter-endwise",
		config = function()
			require("nvim-treesitter.configs").setup({ endwise = { enable = true } })
		end,
	},
	{ "mg979/vim-visual-multi" },
	{ "machakann/vim-sandwich" },
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.g.indent_blankline_filetype_exclude = { "dashboard", "help" }
			vim.opt.list = true
			vim.opt.listchars:append("eol:↴")
			require("indent_blankline").setup({
				show_end_of_line = true,
				space_char_blankline = " ",
			})
		end,
	},
	{
		"luukvbaal/stabilize.nvim",
		config = function()
			require("stabilize").setup()
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{ "xiyaowong/nvim-cursorword" },
	{
		"mvllow/modes.nvim",
		config = function()
			vim.opt.cursorline = true
			require("modes").setup({ line_opacity = 0.2 })
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		config = function()
			local colors = require("tokyonight.colors").setup()

			require("scrollbar").setup({
				handle = { color = colors.bg_highlight },
				marks = {
					Search = { color = colors.orange },
					Error = { color = colors.error },
					Warn = { color = colors.warning },
					Info = { color = colors.info },
					Hint = { color = colors.hint },
					Misc = { color = colors.purple },
				},
			})
		end,
	},
	{ "famiu/bufdelete.nvim" },
	{
		"AckslD/nvim-neoclip.lua",
		requires = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("neoclip").setup({
				keys = {
					telescope = {
						i = {
							select = "<cr>",
							paste = "<c-v>",
							paste_behind = "<c-k>",
						},
					},
				},
			})
			require("telescope").load_extension("neoclip")
		end,
	},
	{
		"p00f/nvim-ts-rainbow",
		config = function()
			require("nvim-treesitter.configs").setup({})
		end,
	},
}
