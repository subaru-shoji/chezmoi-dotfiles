return {
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
