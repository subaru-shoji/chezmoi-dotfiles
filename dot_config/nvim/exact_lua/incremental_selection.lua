-- Treesitter incremental selection: in visual mode, v expands the selection to
-- the smallest named node strictly containing it, V undoes one expansion.
-- (The nvim-treesitter main branch dropped the incremental_selection module,
-- so this reimplements it on the builtin vim.treesitter API.)
local M = {}

local stack = {} ---@type TSNode[]
local last_range ---@type integer[]? selection we set: {srow, scol, erow, ecol} 0-based, end-exclusive
local selecting = false -- suppress the ModeChanged reset while we rebuild the selection

-- current visual selection as a 0-based end-exclusive range
local function visual_range()
	local v, c = vim.fn.getpos("v"), vim.fn.getpos(".")
	local sr, sc, er, ec = v[2], v[3], c[2], c[3]
	if sr > er or (sr == er and sc > ec) then
		sr, sc, er, ec = er, ec, sr, sc
	end
	return { sr - 1, sc - 1, er - 1, ec }
end

-- charwise visual selection over a 0-based end-exclusive range
local function select_range(r)
	local sr, sc, er, ec = r[1], r[2], r[3], r[4]
	if ec == 0 then -- range ends at col 0: pull the end back to the previous line
		er = er - 1
		ec = math.max(#(vim.api.nvim_buf_get_lines(0, er, er + 1, false)[1] or ""), 1)
	end
	selecting = true
	vim.cmd([[execute "normal! \<esc>"]])
	vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
	vim.cmd("normal! v")
	vim.api.nvim_win_set_cursor(0, { er + 1, math.max(ec - 1, 0) })
	selecting = false
	last_range = visual_range() -- read back: multibyte ends don't round-trip exactly
end

-- node range strictly contains r
local function contains(node, r)
	local nsr, nsc, ner, nec = node:range()
	local starts_before = nsr < r[1] or (nsr == r[1] and nsc <= r[2])
	local ends_after = ner > r[3] or (ner == r[3] and nec >= r[4])
	local equal = nsr == r[1] and nsc == r[2] and ner == r[3] and nec == r[4]
	return starts_before and ends_after and not equal
end

local function climb(node, r)
	while node and not contains(node, r) do
		node = node:parent()
	end
	return node
end

function M.expand()
	local ok, parser = pcall(vim.treesitter.get_parser, 0)
	if not ok or not parser then
		return vim.api.nvim_feedkeys("v", "n", false)
	end
	parser:parse(true)
	local cur = visual_range()
	if last_range and not vim.deep_equal(cur, last_range) then
		stack, last_range = {}, nil -- selection was moved manually: re-seed from it
	end
	local top = stack[#stack]
	local base = top and { top:range() } or cur
	local node = top and climb(top:parent(), base)
	if not node then
		-- fresh selection, or :parent() ran out at the root of an injected tree:
		-- look the range up again, in the latter case in the host language
		node = climb(parser:named_node_for_range(base, { ignore_injections = top ~= nil }), base)
	end
	if not node then
		return
	end
	stack[#stack + 1] = node
	select_range({ node:range() })
end

function M.shrink()
	if #stack > 1 then
		table.remove(stack)
		select_range({ stack[#stack]:range() })
	elseif not last_range then
		vim.api.nvim_feedkeys("V", "n", false) -- nothing expanded yet: keep builtin linewise toggle
	end
end

function M.setup()
	vim.keymap.set("x", "v", M.expand, { desc = "Expand Selection" })
	vim.keymap.set("x", "V", M.shrink, { desc = "Shrink Selection" })
	vim.api.nvim_create_autocmd("ModeChanged", {
		group = vim.api.nvim_create_augroup("my_incremental_selection", { clear = true }),
		pattern = "[vV\x16]*:*",
		callback = function()
			if not selecting then
				stack, last_range = {}, nil
			end
		end,
	})
end

return M
