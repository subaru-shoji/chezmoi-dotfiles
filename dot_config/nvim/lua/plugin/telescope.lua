return {
    {
        "nvim-telescope/telescope.nvim",
        requires = {
            {"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"},
            {"kdheepak/lazygit.nvim"}
        },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-q>"] = actions.smart_send_to_qflist +
                                actions.open_qflist,
                            ["<esc>"] = actions.close
                        }
                    }
                }
            })
            require("telescope").load_extension("lazygit")
        end
    }
}
