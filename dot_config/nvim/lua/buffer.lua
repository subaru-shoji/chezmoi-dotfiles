return {
	smart_close = function()
		local file_type_list = { "NvimTree", "qf", "Trouble", "spectre_panel", "notify" }

		if require("util").contains(file_type_list, vim.bo.filetype) then
			vim.api.nvim_command("wincmd c")
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
