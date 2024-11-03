return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = {
			'nvimtools/hydra.nvim',
		},
		opts = {},
		cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
		keys = {
			{
				mode = { 'v', 'n' },
				'<Leader>m',
				'<cmd>MCstart<cr>',
				desc = 'Create a selection for selected text or word under the cursor',
			},
		},
	},
	{
		"RRethy/nvim-treesitter-endwise",
		lazy = true,
		ft = { "ruby", "lua", "vimscript", "bash", "elixir", "fish" },
		config = function()
			require("nvim-treesitter.configs").setup({ endwise = { enable = true } })
		end,
	},
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
		'nmac427/guess-indent.nvim',
		config = function()
			require('guess-indent').setup {}
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{ 'echasnovski/mini.cursorword', version = '*' },
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
		"kazhala/close-buffers.nvim",
		config = function()
			require('close_buffers').setup({
				filetype_ignore = {},                      -- Filetype to ignore when running deletions
				file_glob_ignore = {},                     -- File name glob pattern to ignore when running deletions (e.g. '*.md')
				file_regex_ignore = {},                    -- File name regex pattern to ignore when running deletions (e.g. '.*[.]md')
				preserve_window_layout = { 'this', 'nameless' }, -- Types of deletion that should preserve the window layout
				next_buffer_cmd = nil,                     -- Custom function to retrieve the next buffer when preserving window layout
			})
		end
	},
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
	{
		"sontungexpt/url-open",
		event = "VeryLazy",
		cmd = "URLOpenUnderCursor",
		config = function()
			local status_ok, url_open = pcall(require, "url-open")
			if not status_ok then
				return
			end
			url_open.setup({})
		end,
	},
	{
		'gen740/SmoothCursor.nvim',
		config = function()
			require('smoothcursor').setup()

			local autocmd = vim.api.nvim_create_autocmd

			autocmd({ 'ModeChanged' }, {
				callback = function()
					local current_mode = vim.fn.mode()
					if current_mode == 'n' then
						vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#8aa872' })
						vim.fn.sign_define('smoothcursor', { text = '' })
					elseif current_mode == 'v' then
						vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
						vim.fn.sign_define('smoothcursor', { text = '' })
					elseif current_mode == 'V' then
						vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
						vim.fn.sign_define('smoothcursor', { text = '' })
					elseif current_mode == '�' then
						vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
						vim.fn.sign_define('smoothcursor', { text = '' })
					elseif current_mode == 'i' then
						vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#668aab' })
						vim.fn.sign_define('smoothcursor', { text = '' })
					end
				end,
			})
		end
	}
}
