return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"windwp/nvim-autopairs",
		},
		config = function()
			vim.g.completeopt = { "menu", "menuone", "noselect" }

			local cmp = require("cmp")

			cmp.setup({
				completion = { autocomplete = false },
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					end,
				},
				mapping = {
					["<c-n>"] = function()
						if cmp.visible() then
							cmp.select_next_item()
						else
							cmp.complete()
						end
					end,
					["<cr>"] = cmp.mapping.confirm({ select = true }),
					["<bs>"] = cmp.mapping.close(),
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
				}),
			})
			-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
			-- cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
}
