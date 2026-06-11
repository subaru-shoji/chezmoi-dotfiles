return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		quickfile = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		words = { enabled = true },
		explorer = {},
		dashboard = {
			preset = {
				-- stylua: ignore
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.smart()" },
					{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
					{ icon = " ", key = "g", desc = "Grep", action = ":lua Snacks.picker.grep()" },
					{ icon = " ", key = "e", desc = "Explorer", action = ":lua Snacks.explorer()" },
					{ icon = "󰚩 ", key = "a", desc = "Claude", action = ":lua require('sidekick.cli').toggle({ name = 'claude', focus = true })" },
					{ icon = " ", key = "c", desc = "Config", action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
					{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},
		picker = {
			sources = {
				explorer = {
					-- keep aggregated git status on expanded directories
					git_status_open = true,
					win = {
						list = {
							keys = {
								-- toggle git add / restore --staged for file under cursor (or selection)
								["ga"] = "git_stage",
							},
						},
					},
				},
			},
			actions = {
				trouble_open = function(...)
					return require("trouble.sources.snacks").actions.trouble_open.action(...)
				end,
			},
			win = {
				input = {
					keys = {
						["<a-t>"] = { "trouble_open", mode = { "n", "i" } },
					},
				},
			},
		},
	},
	-- stylua: ignore
	keys = {
		-- main leader: frequent single-key actions
		{ "<leader><space>", function() Snacks.picker.smart() end, desc = "Find Files" },
		{ "<leader>e", function() Snacks.explorer() end, desc = "Explorer (sidebar tree)" },
		{ "<leader>g", function() Snacks.lazygit() end, desc = "Lazygit" },
		{ "<leader>s", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
		-- git category ( ,g )
		{ ",gg", function() Snacks.picker.git_status() end, desc = "Git Status" },
		{ ",gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "x" } },
		-- picker leader ( <tab> )
		{ "<tab><tab>", function() Snacks.picker.commands() end, desc = "Commands" },
		{ "<tab>a", function() Snacks.picker() end, desc = "All Pickers" },
		{ "<tab>b", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<tab>c", function() Snacks.picker.resume() end, desc = "Resume Last Picker" },
		{ "<tab>d", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
		{ "<tab>e", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		{ "<tab>f", function() Snacks.picker.files() end, desc = "Files" },
		{ "<tab>g", function() Snacks.picker.git_status() end, desc = "Git Status" },
		{ "<tab>h", function() Snacks.picker.help() end, desc = "Help" },
		{ "<tab>j", function() Snacks.picker.jumps() end, desc = "Jumps" },
		{ "<tab>k", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
		{ "<tab>n", function() Snacks.picker.notifications() end, desc = "Notifications" },
		{ "<tab>p", function() Snacks.picker.registers() end, desc = "Registers" },
		{ "<tab>r", function() Snacks.picker.recent() end, desc = "Recent Files" },
		{ "<tab>s", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<tab>u", function() Snacks.picker.undo() end, desc = "Undo History" },
		{ "<tab>w", function() Snacks.picker.grep_word() end, desc = "Grep Word/Selection", mode = { "n", "x" } },
	},
}
