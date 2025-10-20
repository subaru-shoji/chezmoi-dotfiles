return {
	"nvim-pack/nvim-spectre",
	config = function()
		require("spectre").setup({
			color_devicons = true,
			is_open_target_win = false,
			is_insert_mode = true,
		})
	end,
}
