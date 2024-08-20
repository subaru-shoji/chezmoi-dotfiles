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
		lazy = true,
		cmd = { "NvimTreeOpen" },
		config = function()
			local function my_on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- custom mappings
				vim.keymap.set("n", "l", api.node.open.edit, opts("edit"))
			end
			require("nvim-tree").setup({
				on_attach = my_on_attach,
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
