return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"RRethy/nvim-treesitter-endwise",
		lazy = true,
		ft = { "ruby", "lua", "vimscript", "bash", "elixir", "fish" },
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
		dependencies = { "nvim-telescope/telescope.nvim" },
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
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
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({})
		end,
	},
	{
		"gaoDean/autolist.nvim",
		ft = {
			"markdown",
			"text",
			"tex",
			"plaintex",
			"norg",
		},
		config = function()
			require("autolist").setup()

			vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
			vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
			vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
			vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
			vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
			vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
			vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>")

			-- cycle list types with dot-repeat
			-- vim.keymap.set("n", "<leader>cn", require("autolist").cycle_next_dr, { expr = true })
			-- vim.keymap.set("n", "<leader>cp", require("autolist").cycle_prev_dr, { expr = true })

			-- if you don't want dot-repeat
			-- vim.keymap.set("n", "<leader>cn", "<cmd>AutolistCycleNext<cr>")
			-- vim.keymap.set("n", "<leader>cp", "<cmd>AutolistCycleNext<cr>")

			-- functions to recalculate list on edit
			vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
			vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
			vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
			vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
		end,
	},
}
