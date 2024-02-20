return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"windwp/nvim-autopairs",
			"Olical/conjure",
			"PaterJason/cmp-conjure",
			"zbirenbaum/copilot.lua",
			"onsails/lspkind.nvim",
		},
		config = function()
			vim.g.completeopt = { "menu", "menuone", "noselect" }

			local cmp = require("cmp")
			local lspkind = require('lspkind')

			cmp.setup({
				completion = { autocomplete = false },
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = {
					["<c-n>"] = function()
						if cmp.visible() then
							cmp.select_next_item()
						else
							cmp.complete()
						end
					end,
					["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
					-- ["<bs>"] = cmp.mapping.close(),
					["<tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
							return
						end

						local cursor = vim.api.nvim_win_get_cursor(0)
						local line = vim.api.nvim_get_current_line()

						if cursor[2] == 0 then
							fallback()
							return
						end

						local beforeCursorCol = cursor[2] - 1
						local oneLetterBefore = string.sub(line, beforeCursorCol, beforeCursorCol)

						if string.match(oneLetterBefore, "[^%s]") then
							cmp.complete()
						else
							fallback()
						end
					end,
					["<s-tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end,
				},
				sources = cmp.config.sources({
					{
						name = "nvim_lsp",
						max_item_count = 10,
						trigger_characters = { "." },
					},
					{ name = "nvim_lsp_signature_help" },
					{ name = "conjure" },
					{ name = "vsnip" },
					{ name = "buffer" },
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = 'symbol', -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as
						-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
						ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						show_labelDetails = true, -- show labelDetails in menu. Disabled by default

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						-- before = function(entry, vim_item)
						-- 	return vim_item
						-- end
					})
				}
			})
			-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
			-- cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})

			cmp.event:on("menu_opened", function()
				vim.b.copilot_suggestion_hidden = true
			end)

			cmp.event:on("menu_closed", function()
				vim.b.copilot_suggestion_hidden = false
			end)

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom", -- | top | left | right
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = false,
					debounce = 75,
					keymap = {
						accept = "JJ",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 16.x
				server_opts_overrides = {},
			})
		end,
	},
}
