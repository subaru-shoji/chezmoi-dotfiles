return {
	"nvim-pack/nvim-spectre",
	config = function()
		require("spectre").setup({
			open_cmd = function()
				vim.cmd('belowright new')
				vim.cmd('resize ' .. math.floor(vim.o.lines * 0.3)) -- 画面の30%
			end
		})
	end,
}
