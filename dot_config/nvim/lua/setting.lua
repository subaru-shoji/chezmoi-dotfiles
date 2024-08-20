vim.o.termguicolors = true

vim.o.pumblend = 15

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hidden = true
vim.o.history = 5000

vim.o.tabstop = 2
vim.o.shiftwidth = vim.o.tabstop

vim.wo.number = true
-- vim.wo.cursorcolumn = true
-- vim.wo.cursorline = true
vim.opt.fillchars["eob"] = "　"

vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.mouse = "a"

vim.g.timeoutlen = 10

if vim.fn.executable("fcitx5-remote") then
	for _, event in ipairs({ "InsertLeave", "CmdlineLeave" }) do
		vim.api.nvim_create_autocmd(event, {
			pattern = "*",
			callback = function(_)
				vim.fn.system("fcitx5-remote -c")
			end,
		})
	end
elseif vim.fn.executable("im-select") then
	for _, event in ipairs({ "InsertLeave", "CmdlineLeave" }) do
		vim.api.nvim_create_autocmd(event, {
			pattern = "*",
			callback = function(_)
				vim.fn.system("im-select com.apple.keylayout.ABC")
			end,
		})
	end
end
