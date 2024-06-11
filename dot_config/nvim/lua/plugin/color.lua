return {
	{
		"folke/tokyonight.nvim",
		init = function()
			vim.o.termguicolors = true
		end,
		config = function()
			vim.g.tokyonight_style = "storm"
			vim.g.tokyonight_italic_functions = true
			vim.g.tokyonight_sidebars = {}
			vim.g.tokyonight_hide_inactive_statusline = true
			vim.cmd([[ colorscheme tokyonight ]])
		end,
	},
	{
		"folke/styler.nvim",
		config = function()
			require("styler").setup({
				themes = {
					-- markdown = { colorscheme = "gruvbox" },
					-- help = { colorscheme = "catppuccin-mocha", background = "dark" },
				},
			})

			-- DEFAULT_COLORSCHEME = "tokyonight-storm"
			INACTIVE_COLORSCHEME = "tokyonight-night"

			-- カラースキームの適用
			-- vim.cmd("colorscheme " .. DEFAULT_COLORSCHEME)
			-- 非アクティブウィンドウ向けの関数
			local function inactivate(win)
				-- skip for certain situations
				if not vim.api.nvim_win_is_valid(win) then
					return
				end
				if vim.api.nvim_win_get_config(win).relative ~= "" then
					return
				end

				-- apply colorscheme if not yet
				if (vim.w[win].theme or {}).colorscheme ~= INACTIVE_COLORSCHEME then
					require("styler").set_theme(win, { colorscheme = INACTIVE_COLORSCHEME })
				end
			end

			-- autocmdの発行
			vim.api.nvim_create_autocmd({ "WinLeave", "WinNew" }, {
				group = vim.api.nvim_create_augroup("styler-nvim-custom", {}),
				callback = function(_)
					local win_event = vim.api.nvim_get_current_win()
					vim.schedule(function()
						local win_pre = vim.fn.win_getid(vim.fn.winnr("#"))
						local win_cursor = vim.api.nvim_get_current_win()

						-- カーソル位置のウィンドウでstyler.nvimを無効化する
						if (vim.w[win_cursor].theme or {}).colorscheme then
							require("styler").clear(win_cursor)
						end

						-- 直前のウィンドウにカーソルがなければinactivate
						if win_pre ~= 0 and win_pre ~= win_cursor then
							inactivate(win_pre)
						end

						-- イベントを発行したウィンドウにカーソルがなければinactivate
						if win_event ~= win_cursor then
							inactivate(win_event)
						end
					end)
				end,
			})
		end,
	},
}
