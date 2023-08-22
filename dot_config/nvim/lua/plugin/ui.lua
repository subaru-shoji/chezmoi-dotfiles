return {
	{
		"folke/noice.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				-- add any options here
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{ "MunifTanjim/nui.nvim" },
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup()
		end,
	},
	{ "VonHeikemen/searchbox.nvim", dependencies = { { "MunifTanjim/nui.nvim" } } },
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				-- config
			})
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"rcarriga/nvim-notify",
		dependencies = { "nvim-telescope/telescope.nvim" },
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local notify = require("notify")
			notify.setup({ max_width = 40 })
			vim.notify = notify
		end,
	},
}
