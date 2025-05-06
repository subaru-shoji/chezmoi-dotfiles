return {
	{
		"quolpr/quicktest.nvim",
		config = function()
			local qt = require("quicktest")

			qt.setup({
				-- Choose your adapter, here all supported adapters are listed
				adapters = {
					-- require("quicktest.adapters.golang")({}),
					require("quicktest.adapters.vitest")({}),
					-- require("quicktest.adapters.playwright")({}),
					-- require("quicktest.adapters.elixir"),
					-- require("quicktest.adapters.criterion"),
					require("quicktest.adapters.dart"),
					-- require("quicktest.adapters.rspec"),
				},
				-- split or popup mode, when argument not specified
				default_win_mode = "popup",
				use_builtin_colorizer = true
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
	}
}
