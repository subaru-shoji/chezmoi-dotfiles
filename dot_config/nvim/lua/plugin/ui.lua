return {
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
	-- {
	-- 	"glepnir/dashboard-nvim",
	-- 	init = function()
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
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			local notify = require("notify")
			notify.setup({ max_width = 40 })
			vim.notify = notify
		end,
	},
}
