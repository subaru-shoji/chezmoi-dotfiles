local function openSidebar()
	vim.cmd([[SidebarNvimOpen]])
	vim.cmd([[exe 1 . "wincmd w"]])
end

return {
	{
		"brglng/vim-sidebar-manager",
		dependencies = { "nvim-pack/nvim-spectre" },
		init = function()
			local spectre = require("spectre")

			vim.g.sidebars = {
				nvimtree = {
					position = "left",
					check_win = function(nr)
						return vim.fn.getwinvar(nr, "&filetype") == "NvimTree"
					end,
					open = "NvimTreeOpen",
					close = "NvimTreeClose",
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
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				diagnostics = { enable = true },
			})
		end,
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
