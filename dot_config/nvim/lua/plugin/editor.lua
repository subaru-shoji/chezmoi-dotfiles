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
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup({
				exclude = {
					filetypes = { "dashboard", "help" },
				},
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
	{ "lambdalisue/suda.vim" },
	-- {
	-- 	"RRethy/vim-illuminate",
	-- 	config = function()
	-- 		-- default configuration
	-- 		require("illuminate").configure({
	-- 			-- providers: provider used to get references in the buffer, ordered by priority
	-- 			providers = {
	-- 				"lsp",
	-- 				"treesitter",
	-- 				"regex",
	-- 			},
	-- 			-- delay: delay in milliseconds
	-- 			delay = 100,
	-- 			-- filetype_overrides: filetype specific overrides.
	-- 			-- The keys are strings to represent the filetype while the values are tables that
	-- 			-- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
	-- 			filetype_overrides = {},
	-- 			-- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
	-- 			filetypes_denylist = {
	-- 				"dirbuf",
	-- 				"dirvish",
	-- 				"fugitive",
	-- 			},
	-- 			-- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
	-- 			-- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
	-- 			filetypes_allowlist = {},
	-- 			-- modes_denylist: modes to not illuminate, this overrides modes_allowlist
	-- 			-- See `:help mode()` for possible values
	-- 			modes_denylist = {},
	-- 			-- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
	-- 			-- See `:help mode()` for possible values
	-- 			modes_allowlist = {},
	-- 			-- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
	-- 			-- Only applies to the 'regex' provider
	-- 			-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
	-- 			providers_regex_syntax_denylist = {},
	-- 			-- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
	-- 			-- Only applies to the 'regex' provider
	-- 			-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
	-- 			providers_regex_syntax_allowlist = {},
	-- 			-- under_cursor: whether or not to illuminate under the cursor
	-- 			under_cursor = true,
	-- 			-- large_file_cutoff: number of lines at which to use large_file_config
	-- 			-- The `under_cursor` option is disabled when this cutoff is hit
	-- 			large_file_cutoff = nil,
	-- 			-- large_file_config: config to use for large files (based on large_file_cutoff).
	-- 			-- Supports the same keys passed to .configure
	-- 			-- If nil, vim-illuminate will be disabled for large files.
	-- 			large_file_overrides = nil,
	-- 			-- min_count_to_highlight: minimum number of matches required to perform highlighting
	-- 			min_count_to_highlight = 1,
	-- 			-- should_enable: a callback that overrides all other settings to
	-- 			-- enable/disable illumination. This will be called a lot so don't do
	-- 			-- anything expensive in it.
	-- 			should_enable = function(bufnr)
	-- 				return true
	-- 			end,
	-- 			-- case_insensitive_regex: sets regex case sensitivity
	-- 			case_insensitive_regex = false,
	-- 		})
	-- 	end,
	-- },
}
