local contains = require("util").contains

local is_current_buffer_pinned = function()
	local pinned_paths_str = vim.g["BufferlinePinnedBuffers"]

	if not pinned_paths_str or pinned_paths_str == "" then
		return false
	end

	local pinned_buffer_list = {}
	for path in pinned_paths_str:gmatch("[^,]+") do
		table.insert(pinned_buffer_list, path)
	end

	return contains(pinned_buffer_list, vim.fn.expand("%:p"))
end

return {
	smart_close = function()
		if is_current_buffer_pinned() then
			return
		end

		local file_type_list = { "NvimTree", "qf", "Trouble", "spectre_panel", "notify" }

		if contains(file_type_list, vim.bo.filetype) then
			vim.api.nvim_command("wincmd c")
		elseif vim.api.nvim_win_get_config(0).relative ~= "" then
			-- close if current window is floating window.
			vim.api.nvim_win_close(0, false)
		else
			if #vim.fn.win_findbuf(vim.fn.bufnr("%")) > 1 then
				vim.api.nvim_command("wincmd c")
			else
				require("bufdelete").bufdelete(0, false)
			end
		end
	end,
	close_all = function()
		if vim.fn.confirm("Quit all?", "Yes\nNo") == 1 then
			vim.cmd("qa")
		end
	end,
}
