if vim.fn.has("nvim-0.11.2") == 0 then
	vim.api.nvim_echo({
		{ "This config requires Neovim >= 0.11.2\n", "ErrorMsg" },
		{ "Press any key to exit", "MoreMsg" },
	}, true, {})
	vim.fn.getchar()
	vim.cmd([[quit]])
	return
end

vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("options")

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	defaults = { lazy = false, version = false },
	install = { colorscheme = { "tokyonight" } },
	checker = { enabled = true, notify = false },
	rocks = { enabled = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- C is taken by the global smart_close; rename Check to Fetch (F) instead
local lazy_view_config = require("lazy.view.config")
lazy_view_config.commands.fetch = vim.tbl_extend("force", {}, lazy_view_config.commands.check, { key = "F" })
lazy_view_config.commands.check = nil
require("lazy.view.commands").commands.fetch = function(opts)
	require("lazy.manage").check(vim.tbl_extend("keep", opts or {}, { mode = "fetch" }))
end

require("keymaps")
require("autocmds")
