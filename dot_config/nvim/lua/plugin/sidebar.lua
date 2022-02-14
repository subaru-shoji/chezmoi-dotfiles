function openSidebar()
    vim.cmd [[SidebarNvimOpen]]
    vim.cmd [[exe 1 . "wincmd w"]]
end

return {
    {
        "brglng/vim-sidebar-manager",
        setup = function()
            vim.g.sidebars = {
                nvimtree = {
                    position = 'left',
                    check_win = function(nr)
                        return vim.fn.getwinvar(nr, '&filetype') == 'NvimTree'
                    end,
                    open = 'NvimTreeOpen',
                    close = 'NvimTreeClose'
                },
                sidebar = {
                    position = 'left',
                    check_win = function(nr)
                        return vim.fn.getwinvar(nr, '&filetype') ==
                                   'SidebarNvim'
                    end,
                    open = openSidebar,
                    close = "SidebarNvimClose"
                }

            }
        end
    }, {
        "kyazdani42/nvim-tree.lua",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = function()
            local tree_cb = require("nvim-tree.config").nvim_tree_callback
            local list = {
                {
                    key = {"<CR>", "o", "l", "<2-LeftMouse>"},
                    cb = tree_cb("edit")
                }, {key = {"<2-RightMouse>", "<C-]>"}, cb = tree_cb("cd")},
                {key = "<C-v>", cb = tree_cb("vsplit")},
                {key = "<C-x>", cb = tree_cb("split")},
                {key = "<C-t>", cb = tree_cb("tabnew")},
                {key = "<", cb = tree_cb("prev_sibling")},
                {key = ">", cb = tree_cb("next_sibling")},
                {key = "P", cb = tree_cb("parent_node")},
                {key = {"<BS>", "h"}, cb = tree_cb("close_node")},
                {key = "<S-CR>", cb = tree_cb("close_node")},
                {key = "K", cb = tree_cb("first_sibling")},
                {key = "J", cb = tree_cb("last_sibling")},
                {key = "I", cb = tree_cb("toggle_ignored")},
                {key = "H", cb = tree_cb("toggle_dotfiles")},
                {key = "R", cb = tree_cb("refresh")},
                {key = "a", cb = tree_cb("create")},
                {key = "d", cb = tree_cb("remove")},
                {key = "r", cb = tree_cb("rename")},
                {key = "<C-r>", cb = tree_cb("full_rename")},
                {key = "x", cb = tree_cb("cut")},
                {key = "c", cb = tree_cb("copy")},
                {key = "p", cb = tree_cb("paste")},
                {key = "y", cb = tree_cb("copy_name")},
                {key = "Y", cb = tree_cb("copy_path")},
                {key = "gy", cb = tree_cb("copy_absolute_path")},
                {key = "[c", cb = tree_cb("prev_git_item")},
                {key = "]c", cb = tree_cb("next_git_item")},
                {key = "-", cb = tree_cb("dir_up")},
                {key = "s", cb = tree_cb("system_open")},
                {key = "q", cb = tree_cb("close")},
                {key = "?", cb = tree_cb("toggle_help")}
            }

            require("nvim-tree").setup({
                diagnostics = {enable = true},
                view = {mappings = {custom_only = false, list = list}}
            })
        end
    }, {"sidebar-nvim/sidebar.nvim"}
}
