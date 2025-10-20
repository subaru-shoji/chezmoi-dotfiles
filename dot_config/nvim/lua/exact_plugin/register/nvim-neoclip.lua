return {
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = { "nvim-telescope/telescope.nvim" },
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("neoclip").setup({
				keys = {
					telescope = {
						i = {
							select = "<cr>",
							paste = "<c-v>",
							paste_behind = "<c-k>",
						},
					},
				},
			})
			require("telescope").load_extension("neoclip")
		end,
	},
}
