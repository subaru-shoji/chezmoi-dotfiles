return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
		"antosha417/nvim-lsp-file-operations",
		"mrbjarksen/neo-tree-diagnostics.nvim",
	},
	lazy = false, -- neo-tree will lazily load itself
	opts = {
		sources = {
			"filesystem",
			"buffers",
			"git_status",
			"diagnostics",
			-- ...and any additional source
		},
		source_selector = {
			winbar = true,
			statusline = false,
		},
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false,
			},
		},
		window = {
			mappings = {
				["P"] = {
					"toggle_preview",
					config = {
						use_float = false,
						-- use_image_nvim = true,
						-- use_snacks_image = true,
						-- title = 'Neo-tree Preview',
					},
				},
				["l"] = "open",
			},
		},
	},
}
