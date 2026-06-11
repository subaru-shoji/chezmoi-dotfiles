return {
	-- label-based jump & treesitter selection
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		-- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
			{ "<c-space>", mode = { "n", "o", "x" },
				function()
					require("flash").treesitter({
						actions = {
							["<c-space>"] = "next",
							["<BS>"] = "prev",
						},
					})
				end, desc = "Treesitter Incremental Selection" },
		},
	},

	-- keymap discovery
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts_extend = { "spec" },
		opts = {
			preset = "helix",
			spec = {
				{
					mode = { "n", "x" },
					{ ",a", group = "ai" },
					{ ",b", group = "buffer" },
					{ ",g", group = "git" },
					{ ",l", group = "lsp" },
					{ ",m", group = "multicursor" },
					{ ",u", group = "toggle" },
					{ "<tab>", group = "picker" },
					{ "<leader>q", group = "quit/close" },
					{ "[", group = "prev" },
					{ "]", group = "next" },
					{ "g", group = "goto" },
				},
			},
		},
		keys = {
			{
				"<leader>w",
				function()
					require("which-key").show({ keys = "<c-w>", loop = true })
				end,
				desc = "Window Mode",
			},
			{
				"<f1>",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Keymaps",
			},
		},
	},

	-- git hunks
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function bmap(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
				end

				-- stylua: ignore start
				bmap("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next Hunk")
				bmap("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev Hunk")
				bmap({ "n", "x" }, ",gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				bmap({ "n", "x" }, ",gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				bmap("n", ",gS", gs.stage_buffer, "Stage Buffer")
				bmap("n", ",gp", gs.preview_hunk_inline, "Preview Hunk Inline")
				bmap("n", ",gb", function() gs.blame_line({ full = true }) end, "Blame Line")
				bmap("n", ",gd", gs.diffthis, "Diff This")
				bmap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select Hunk")
				-- stylua: ignore end
			end,
		},
	},

	-- diagnostics list
	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },
		opts = {
			keys = {
				["<f1>"] = "help",
			},
			modes = {
				lsp = {
					win = { position = "right" },
				},
			},
		},
		keys = {
			{ ",ld", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ ",lD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ ",ls", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err --[[@as string]], vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err --[[@as string]], vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
	},

	-- TODO/FIXME comments
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble" },
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {},
		-- stylua: ignore
		keys = {
			{ "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
			{ "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
			{ "<tab>t", function() Snacks.picker.todo_comments() end, desc = "Todo Comments" },
		},
	},

	-- project-wide search & replace
	{
		"MagicDuck/grug-far.nvim",
		opts = {
			headerMaxWidth = 80,
			keymaps = {
				help = "<f1>",
			},
		},
		cmd = { "GrugFar", "GrugFarWithin" },
		keys = {
			{
				"<leader>r",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "x" },
				desc = "Search and Replace",
			},
		},
	},

	-- git diff review: sidebar file panel + diff, stage with `-`
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		opts = function()
			local actions = require("diffview.actions")
			return {
				keymaps = {
					view = { { "n", "<f1>", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } } },
					file_panel = { { "n", "<f1>", actions.help("file_panel"), { desc = "Open the help panel" } } },
					file_history_panel = {
						{ "n", "<f1>", actions.help("file_history_panel"), { desc = "Open the help panel" } },
					},
					option_panel = { { "n", "<f1>", actions.help("option_panel"), { desc = "Open the help panel" } } },
				},
			}
		end,
		keys = {
			{
				"<leader>d",
				function()
					if require("diffview.lib").get_current_view() then
						vim.cmd("DiffviewClose")
					else
						vim.cmd("DiffviewOpen")
					end
				end,
				desc = "Diffview (toggle)",
			},
			{ ",gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current)" },
			{ ",gH", "<cmd>DiffviewFileHistory<cr>", desc = "File History (repo)" },
		},
	},

	-- yazi TUI file manager
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		opts = {
			open_for_directories = true,
			keymaps = {
				show_help = "<f1>",
			},
		},
		keys = {
			{ "<leader>f", "<cmd>Yazi cwd<cr>", desc = "Yazi (cwd)" },
		},
	},

	-- :w with sudo
	{ "lambdalisue/suda.vim", cmd = { "SudaRead", "SudaWrite" } },
}
