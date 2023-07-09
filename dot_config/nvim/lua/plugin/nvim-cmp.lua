return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
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
						cmp.complete()
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
					},
					{ name = "vsnip" },
					{
						{ name = "buffer" },
					},
				}),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
}
