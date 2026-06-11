return {
	-- buffer tabs with active-buffer highlight
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		-- stylua: ignore
		keys = {
			{ "K", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "J", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ ",bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle Pin" },
			{ ",bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Other Buffers" },
			{ ",bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
		},
		opts = {
			options = {
				-- stylua: ignore
				close_command = function(n) Snacks.bufdelete(n) end,
				-- stylua: ignore
				right_mouse_command = function(n) Snacks.bufdelete(n) end,
				diagnostics = "nvim_lsp",
				always_show_bufferline = true,
				offsets = {
					{ filetype = "snacks_layout_box" },
				},
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
			-- fix bufferline when restoring a session
			vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
				callback = function()
					vim.schedule(function()
						pcall(nvim_bufferline)
					end)
				end,
			})
		end,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				theme = "auto",
				globalstatus = true,
				disabled_filetypes = { statusline = { "snacks_dashboard" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {
					"diagnostics",
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					{ "filename", path = 1 },
				},
				lualine_x = {
					-- noice: pending command / macro recording status
					-- stylua: ignore
					{
						function() return require("noice").api.status.command.get() end,
						cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
						color = function() return { fg = Snacks.util.color("Statement") } end,
					},
					-- stylua: ignore
					{
						function() return require("noice").api.status.mode.get() end,
						cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
						color = function() return { fg = Snacks.util.color("Constant") } end,
					},
					-- sidekick: number of attached AI CLI sessions
					{
						function()
							local status = require("sidekick.status").cli()
							return " " .. (#status > 1 and #status or "")
						end,
						cond = function()
							return package.loaded["sidekick"] ~= nil and #require("sidekick.status").cli() > 0
						end,
						color = function()
							return { fg = Snacks.util.color("Special") }
						end,
					},
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = function()
							return { fg = Snacks.util.color("Special") }
						end,
					},
					{
						"diff",
						source = function()
							local gitsigns = vim.b.gitsigns_status_dict
							if gitsigns then
								return {
									added = gitsigns.added,
									modified = gitsigns.changed,
									removed = gitsigns.removed,
								}
							end
						end,
					},
				},
				lualine_y = {
					{ "progress", separator = " ", padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
				lualine_z = {},
			},
			extensions = { "lazy" },
		},
	},

	-- fancy cmdline / messages / LSP docs UI
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		},
		-- stylua: ignore
		keys = {
			{ "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = { "i", "n", "s" } },
			{ "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = { "i", "n", "s" } },
		},
		config = function(_, opts)
			-- noice shows messages from before it was enabled, which is noisy
			-- when lazy.nvim is installing plugins on startup
			if vim.o.filetype == "lazy" then
				vim.cmd([[messages clear]])
			end
			require("noice").setup(opts)
		end,
	},

	{ "MunifTanjim/nui.nvim", lazy = true },

	-- minimap (auto-opens for normal buffers; ,um to toggle)
	{
		"nvim-mini/mini.map",
		event = "VeryLazy",
		keys = {
			{
				",um",
				function()
					vim.g.minimap_auto = not vim.g.minimap_auto
					require("mini.map").toggle()
				end,
				desc = "Toggle Minimap",
			},
		},
		opts = function()
			local map = require("mini.map")
			return {
				integrations = {
					map.gen_integration.builtin_search(),
					map.gen_integration.gitsigns(),
					map.gen_integration.diagnostic(),
				},
				symbols = { encode = map.gen_encode_symbols.dot("4x2") },
				window = { width = 10, winblend = 25 },
			}
		end,
		config = function(_, opts)
			require("mini.map").setup(opts)
			vim.g.minimap_auto = true
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("my_minimap", { clear = true }),
				callback = function()
					if not vim.g.minimap_auto then
						return
					end
					if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
						pcall(require("mini.map").open)
					else
						pcall(require("mini.map").close)
					end
				end,
			})
		end,
	},

	-- icons (mocks nvim-web-devicons for plugins that ask for it)
	{
		"nvim-mini/mini.icons",
		lazy = true,
		opts = {},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
}
