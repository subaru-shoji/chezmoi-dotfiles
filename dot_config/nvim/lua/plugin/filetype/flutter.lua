return {
	{
		"akinsho/flutter-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local config = {}

			if vim.fn.executable("fvm") then
				config.fvm = true
			elseif vim.fn.executable("asdf") then
				config.flutter_lookup_cmd = "asdf where flutter"
			end

			require("flutter-tools").setup(config)
		end,
	},
}
