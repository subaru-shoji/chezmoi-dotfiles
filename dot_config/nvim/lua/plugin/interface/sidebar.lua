local function openSidebar()
	vim.cmd([[SidebarNvimOpen]])
	vim.cmd([[exe 1 . "wincmd w"]])
end

return {
	{
		"brglng/vim-sidebar-manager",
		dependencies = { "nvim-pack/nvim-spectre" },
		lazy = true,
		cmd = { "SidebarToggle" },
		init = function()
			local spectre = require("spectre")

			vim.g.sidebars = {
				neotree = {
					position = "left",
					check_win = function(nr)
						return vim.fn.getwinvar(nr, "&filetype") == "neo-tree"
					end,
					open = "Neotree",
					close = "Neotree close",
				},
				sidebar = {
					position = "left",
					check_win = function(nr)
						return vim.fn.getwinvar(nr, "&filetype") == "SidebarNvim"
					end,
					open = openSidebar,
					close = "SidebarNvimClose",
				},
				spectre = {
					position = "left",
					check_win = function(nr)
						return vim.fn.getwinvar(nr, "&filetype") == "spectre_panel"
					end,
					open = function()
						spectre.open()
					end,
					close = function()
						spectre.close()
					end,
				},
			}
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
	},
	{ "sidebar-nvim/sidebar.nvim" },
	{
		"nvim-pack/nvim-spectre",
		config = function()
			require("spectre").setup({
				color_devicons = true,
				is_open_target_win = false,
				is_insert_mode = true,
			})
		end,
	},
}
