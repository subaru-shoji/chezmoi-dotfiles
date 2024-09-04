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
		{ import = "plugin" },
		{ import = "plugin.ai" },
		{ import = "plugin.code_editing" },
		{ import = "plugin.file_management" },
		{ import = "plugin.filetype" },
		{ import = "plugin.interface" },
		{ import = "plugin.language_support" },
		{ import = "plugin.navigation" },
		{ import = "plugin.version_control" },
	}
})
