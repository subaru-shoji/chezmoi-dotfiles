return {
	{
		"kdheepak/lazygit.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		config = function()
			require("telescope").load_extension("lazygit")
		end,
	},
}
