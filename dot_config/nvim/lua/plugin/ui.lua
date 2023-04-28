return {
	{ "MunifTanjim/nui.nvim" },
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup()
		end,
	},
	{ "VonHeikemen/searchbox.nvim", requires = { { "MunifTanjim/nui.nvim" } } },
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				-- config
			})
		end,
		requires = { "nvim-tree/nvim-web-devicons" },
	},
	-- {
	-- 	"glepnir/dashboard-nvim",
	-- 	setup = function()
	-- 		-- vim.g.dashboard_custom_section = {
	-- 		-- 	buffer_list = {
	-- 		-- 		description = { "Start Project !!" },
	-- 		-- 		command = function()
	-- 		-- 			vim.cmd([[ NvimTreeOpen ]])
	-- 		-- 			vim.wait(100, function() end)
	-- 		-- 			require("telescope.builtin").fd()
	-- 		-- 		end,
	-- 		-- 	},
	-- 		-- }
	-- 		-- vim.g.dashboard_default_executive = "telescope"
	-- 	end,
	-- },
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	},
}
