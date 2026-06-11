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

require("keymaps")
require("autocmds")
