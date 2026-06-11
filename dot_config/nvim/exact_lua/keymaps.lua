-- Keymap structure:
--   <space>  main leader  : single-key frequent actions
--   ,        sub leader   : two-key, by category (a=ai, l=lsp, g=git, b=buffer, u=toggle)
--   <tab>    picker leader: snacks pickers (defined in plugins/snacks.lua)
-- Plugin-dependent keymaps live in their plugin specs; this file is plugin-free
-- except for Snacks (loaded eagerly before this file runs).

local map = vim.keymap.set

-- insert/cmdline helpers
map("i", "jj", "<esc>")
map("i", "<c-a>", "<c-o>I", { silent = true })
map("i", "<c-e>", "<c-o>A", { silent = true })
map("c", "<c-a>", "<home>")
map("c", "<c-e>", "<end>")
map({ "n", "v" }, "<c-a>", "^")
map({ "n", "v" }, "<c-e>", "g_")
map({ "n", "v" }, "gj", "G")
map({ "n", "v" }, "gk", "gg")

-- save
map({ "n", "v" }, "<c-s>", "<cmd>update<cr>", { desc = "Save" })
map("i", "<c-s>", "<esc><cmd>update<cr>", { desc = "Save" })

-- jumplist on H/L (<tab> is the picker leader, so <c-i> is unavailable)
map("n", "H", "<c-o>", { desc = "Jump Back" })
map("n", "L", "<c-i>", { desc = "Jump Forward" })

map("n", "<esc><esc>", "<cmd>nohlsearch<cr>", { silent = true, desc = "Clear Search Highlight" })

-- windows
map("n", "t", "<cmd>wincmd w<cr>", { desc = "Next Window" })

-- shift-arrow selection
map("n", "<s-up>", "v<up>")
map("n", "<s-down>", "v<down>")
map("v", "<s-up>", "<up>")
map("v", "<s-down>", "<down>")
map("v", "<s-left>", "<left>")
map("v", "<s-right>", "<right>")
map("i", "<s-up>", "<esc>v<up>")
map("i", "<s-down>", "<esc>v<down>")
map("i", "<s-left>", "<esc>v<left>")
map("i", "<s-right>", "<esc>v<right>")

-- move lines
map("n", "<a-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Line Down" })
map("n", "<a-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Line Up" })
map("i", "<a-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
map("i", "<a-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
map("v", "<a-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Selection Down" })
map("v", "<a-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Selection Up" })

-- keep selection when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- treesitter incremental selection: v expands, V shrinks (visual mode)
require("incremental_selection").setup()

-- undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- diagnostics ( ]d / [d are builtin )
local function diag_jump(count, severity)
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		vim.diagnostic.jump({ count = count, severity = severity })
	end
end
map("n", "]e", diag_jump(1, "ERROR"), { desc = "Next Error" })
map("n", "[e", diag_jump(-1, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diag_jump(1, "WARN"), { desc = "Next Warning" })
map("n", "[w", diag_jump(-1, "WARN"), { desc = "Prev Warning" })

-- smart close: close special/floating/duplicated windows, otherwise delete the
-- buffer while keeping the window layout
local function smart_close()
	if vim.api.nvim_win_get_config(0).relative ~= "" then
		vim.api.nvim_win_close(0, false)
		return
	end
	local special_ft = { "qf", "help", "trouble", "grug-far", "checkhealth", "notify", "gitsigns-blame" }
	if vim.tbl_contains(special_ft, vim.bo.filetype) or vim.bo.buftype ~= "" then
		if not pcall(vim.cmd.close) then
			Snacks.bufdelete()
		end
	elseif #vim.fn.win_findbuf(vim.fn.bufnr("%")) > 1 then
		vim.cmd.close()
	else
		Snacks.bufdelete()
	end
end

-- reopen closed buffers with X
local closed_files = {}
vim.api.nvim_create_autocmd("BufDelete", {
	group = vim.api.nvim_create_augroup("my_closed_buffers", { clear = true }),
	callback = function(event)
		local file = event.file
		if file == "" or vim.fn.filereadable(file) ~= 1 then
			return
		end
		for i, f in ipairs(closed_files) do
			if f == file then
				table.remove(closed_files, i)
				break
			end
		end
		table.insert(closed_files, file)
		if #closed_files > 50 then
			table.remove(closed_files, 1)
		end
	end,
})

map("n", "C", smart_close, { desc = "Smart Close" })
map("n", "X", function()
	local file = table.remove(closed_files)
	if file then
		vim.cmd.edit(vim.fn.fnameescape(file))
	else
		vim.notify("No recently closed buffers", vim.log.levels.INFO)
	end
end, { desc = "Reopen Closed Buffer" })

-- main leader
map("n", "<leader>y", function()
	local relative_path = vim.fn.expand("%:.")
	vim.fn.setreg("+", relative_path)
	vim.notify("Copied: " .. relative_path)
end, { desc = "Yank Relative Path" })
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>qq", smart_close, { desc = "Smart Close" })
map("n", "<leader>qc", "<cmd>close<cr>", { desc = "Close Window" })
map("n", "<leader>qa", function()
	if vim.fn.confirm("Quit all?", "&Yes\n&No") == 1 then
		vim.cmd.qa()
	end
end, { desc = "Quit All" })

-- ai (, a *): other ,a* keymaps live in plugins/ai.lua (sidekick)
map("x", ",aj", function()
	require("llm_rewrite").fix_japanese()
end, { desc = "Fix Japanese with LLM" })

-- toggles (, u *)
Snacks.toggle({
	name = "Auto Format",
	get = function()
		return vim.g.autoformat ~= false
	end,
	set = function(state)
		vim.g.autoformat = state
	end,
}):map(",uf")
Snacks.toggle.option("spell", { name = "Spelling" }):map(",us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map(",uw")
Snacks.toggle.line_number():map(",ul")
Snacks.toggle.diagnostics():map(",ud")
Snacks.toggle.inlay_hints():map(",uh")
Snacks.toggle.indent():map(",ug")
