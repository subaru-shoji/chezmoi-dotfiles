return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"robitx/gp.nvim",
		config = function()
			local conf = {
				-- For customization, refer to Install > Configuration in the Documentation/Readme
			}
			require("gp").setup(conf)
			-- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this if you want to always pull the latest change
		opts = {
			-- add any opts here
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	{
		"GeorgesAlkhouri/nvim-aider",
		cmd = {
			"AiderTerminalToggle",
			"AiderHealth",
		},
		-- keys = {
		-- 	{ "<leader>a/", "<cmd>AiderTerminalToggle<cr>",    desc = "Open Aider" },
		-- 	{ "<leader>as", "<cmd>AiderTerminalSend<cr>",      desc = "Send to Aider",                  mode = { "n", "v" } },
		-- 	{ "<leader>ac", "<cmd>AiderQuickSendCommand<cr>",  desc = "Send Command To Aider" },
		-- 	{ "<leader>ab", "<cmd>AiderQuickSendBuffer<cr>",   desc = "Send Buffer To Aider" },
		-- 	{ "<leader>a+", "<cmd>AiderQuickAddFile<cr>",      desc = "Add File to Aider" },
		-- 	{ "<leader>a-", "<cmd>AiderQuickDropFile<cr>",     desc = "Drop File from Aider" },
		-- 	{ "<leader>ar", "<cmd>AiderQuickReadOnlyFile<cr>", desc = "Add File as Read-Only" },
		-- 	-- Example nvim-tree.lua integration if needed
		-- 	{ "<leader>a+", "<cmd>AiderTreeAddFile<cr>",       desc = "Add File from Tree to Aider",    ft = "NvimTree" },
		-- 	{ "<leader>a-", "<cmd>AiderTreeDropFile<cr>",      desc = "Drop File from Tree from Aider", ft = "NvimTree" },
		-- },
		dependencies = {
			"folke/snacks.nvim",
			--- The below dependencies are optional
			"catppuccin/nvim",
			"nvim-tree/nvim-tree.lua",
		},
		config = true,
	},
}
