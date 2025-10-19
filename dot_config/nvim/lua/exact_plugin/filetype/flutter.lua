return {
	{
		"akinsho/flutter-tools.nvim",
		lazy = true,
		ft = { "dart" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local config = {}

			if vim.fn.executable("fvm") == 1 then
				config.fvm = true
			elseif vim.fn.executable("asdf") == 1 then
				config.flutter_lookup_cmd = "asdf where flutter"
			end

			require("flutter-tools").setup(config)
			require("telescope").load_extension("flutter")
		end,
	},
}
