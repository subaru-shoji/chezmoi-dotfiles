local function augroup(name)
	return vim.api.nvim_create_augroup("my_" .. name, { clear = true })
end

-- switch IME on insert/cmdline enter/leave
local ime_switch, events
if vim.fn.executable("fcitx5-remote") == 1 then
	ime_switch = function()
		vim.fn.system("fcitx5-remote -c")
	end
	events = { "InsertLeave", "CmdlineLeave" }
elseif vim.fn.executable("macism") == 1 then
	ime_switch = function()
		vim.fn.system("macism com.apple.keylayout.ABC")
	end
	events = { "InsertEnter", "InsertLeave", "CmdlineEnter", "CmdlineLeave" }
end
if ime_switch then
	vim.api.nvim_create_autocmd(events, {
		group = augroup("ime_switch"),
		callback = ime_switch,
	})
end

-- cursorline only in the active window
local cursorline = augroup("active_cursorline")
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
	group = cursorline,
	callback = function()
		vim.wo.cursorline = true
	end,
})
vim.api.nvim_create_autocmd("WinLeave", {
	group = cursorline,
	callback = function()
		vim.wo.cursorline = false
	end,
})

-- check if the file changed outside of neovim
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- go to last cursor location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc_done then
			return
		end
		vim.b[buf].last_loc_done = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"checkhealth",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"notify",
		"qf",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, { buffer = event.buf, silent = true, desc = "Quit buffer" })
		end)
	end,
})

-- unify help key: <f1> in plugin UIs that don't expose a help key option
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("help_with_f1"),
	pattern = { "lazy" },
	callback = function(event)
		vim.keymap.set("n", "<f1>", "?", { buffer = event.buf, remap = true, silent = true, desc = "Help" })
	end,
})

-- wrap and spell check in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "text", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- auto create parent dirs when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
