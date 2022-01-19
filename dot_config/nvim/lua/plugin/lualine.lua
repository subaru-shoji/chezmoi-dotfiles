return {
    {
        "nvim-lualine/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true},
        config = function()
            require("lualine").setup({
                options = {
                    theme = "tokyonight",
                    disabled_filetypes = {"Trouble", "NvimTree", "SidebarNvim"}
                },
                sections = {
                    lualine_c = {{"filename", file_status = true, path = 1}},
                    lualine_a = {"mode"},
                    lualine_b = {"branch"},
                    lualine_x = {"encoding", "fileformat", "filetype"},
                    lualine_y = {"progress"},
                    lualine_z = {"location"}
                },
                extensions = {"quickfix"}
            })
        end
    }
}
