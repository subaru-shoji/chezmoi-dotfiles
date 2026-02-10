local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = ","
require("lazy.view.config").keys.close = "C"
require("lazy.view.config").commands.check.key = "O"
require("lazy.view.config").commands.check.key_plugin = "o"
require("lazy").setup({
	spec = {
		{ import = "plugin.essential" },
		{ import = "plugin.buffer" },
		{ import = "plugin.completion" },
		{ import = "plugin.editing" },
		{ import = "plugin.editor_visual" },
		{ import = "plugin.explorer" },
		{ import = "plugin.filetype" },
		{ import = "plugin.format" },
		{ import = "plugin.git" },
		{ import = "plugin.jump" },
		{ import = "plugin.lint" },
		{ import = "plugin.lsp" },
		{ import = "plugin.register" },
		{ import = "plugin.test" },
		{ import = "plugin.ui" },
		{ import = "plugin.util" },
		{ import = "plugin.window" },
	}
})
