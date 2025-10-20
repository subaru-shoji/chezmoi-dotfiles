return {
	{
		"RRethy/nvim-treesitter-endwise",
		lazy = true,
		ft = { "ruby", "lua", "vimscript", "bash", "elixir", "fish" },
		config = function()
			require("nvim-treesitter.configs").setup({ endwise = { enable = true } })
		end,
	},
}
