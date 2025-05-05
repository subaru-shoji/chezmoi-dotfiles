return {
	'saghen/blink.cmp',
	-- optional: provides snippets for the snippet source
	dependencies = { 'rafamadriz/friendly-snippets' },

	-- use a release tag to download pre-built binaries
	version = '1.*',
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = { preset = 'default' },

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'mono'
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = { documentation = { auto_show = false } },

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" }
}

-- return {
-- 	{
-- 		"hrsh7th/nvim-cmp",
-- 		dependencies = {
-- 			"hrsh7th/cmp-nvim-lsp",
-- 			"hrsh7th/cmp-nvim-lsp-signature-help",
-- 			"hrsh7th/cmp-buffer",
-- 			"hrsh7th/cmp-path",
-- 			"hrsh7th/cmp-cmdline",
-- 			"hrsh7th/cmp-vsnip",
-- 			"hrsh7th/vim-vsnip",
-- 			"windwp/nvim-autopairs",
-- 			"zbirenbaum/copilot.lua",
-- 			"onsails/lspkind.nvim",
-- 		},
-- 		config = function()
-- 			vim.g.completeopt = { "menu", "menuone", "noselect" }
--
-- 			local cmp = require("cmp")
-- 			local lspkind = require("lspkind")
--
-- 			cmp.setup({
-- 				completion = { autocomplete = false },
-- 				snippet = {
-- 					expand = function(args)
-- 						vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
-- 					end,
-- 				},
-- 				window = {
-- 					completion = cmp.config.window.bordered(),
-- 					documentation = cmp.config.window.bordered(),
-- 				},
-- 				mapping = {
-- 					["<c-n>"] = function()
-- 						if cmp.visible() then
-- 							cmp.select_next_item()
-- 						else
-- 							cmp.complete()
-- 						end
-- 					end,
-- 					["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
-- 					-- ["<bs>"] = cmp.mapping.close(),
-- 					["<tab>"] = function(fallback)
-- 						if cmp.visible() then
-- 							cmp.select_next_item()
-- 							return
-- 						end
--
-- 						local cursor = vim.api.nvim_win_get_cursor(0)
-- 						local line = vim.api.nvim_get_current_line()
--
-- 						if cursor[2] == 0 then
-- 							fallback()
-- 							return
-- 						end
--
-- 						local beforeCursorCol = cursor[2] - 1
-- 						local oneLetterBefore = string.sub(line, beforeCursorCol, beforeCursorCol)
--
-- 						if string.match(oneLetterBefore, "[^%s]") then
-- 							cmp.complete()
-- 						else
-- 							fallback()
-- 						end
-- 					end,
-- 					["<s-tab>"] = function(fallback)
-- 						if cmp.visible() then
-- 							cmp.select_prev_item()
-- 						else
-- 							fallback()
-- 						end
-- 					end,
-- 				},
-- 				sources = cmp.config.sources({
-- 					{
-- 						name = "nvim_lsp",
-- 						max_item_count = 10,
-- 						trigger_characters = { "." },
-- 					},
-- 					{ name = "nvim_lsp_signature_help" },
-- 					{ name = "path" },
-- 					{ name = "vsnip" },
-- 					{ name = "buffer" },
-- 				}),
-- 				formatting = {
-- 					format = lspkind.cmp_format({
-- 						mode = "symbol", -- show only symbol annotations
-- 						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
-- 						-- can also be a function to dynamically calculate max width such as
-- 						-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
-- 						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
-- 						show_labelDetails = true, -- show labelDetails in menu. Disabled by default
--
-- 						-- The function below will be called before any actual modifications from lspkind
-- 						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
-- 						-- before = function(entry, vim_item)
-- 						-- 	return vim_item
-- 						-- end
-- 					}),
-- 				},
-- 			})
-- 			-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- 			-- cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})
--
-- 			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- 			cmp.setup.cmdline(":", {
-- 				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
-- 			})
--
-- 			cmp.event:on("menu_opened", function()
-- 				vim.b.copilot_suggestion_hidden = true
-- 			end)
--
-- 			cmp.event:on("menu_closed", function()
-- 				vim.b.copilot_suggestion_hidden = false
-- 			end)
--
-- 			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
-- 			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
-- 		end,
-- 	}
-- }
