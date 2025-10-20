return {
	{
		"p00f/nvim-ts-rainbow",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				incremental_selection = {
					enable = true,
					keymaps = {
						-- init_selection = "gnn", -- set to `false` to disable one of the mappings
						node_incremental = "v",
						scope_incremental = "t",
						node_decremental = "T",
					},
				},
			})
		end,
	},
}
