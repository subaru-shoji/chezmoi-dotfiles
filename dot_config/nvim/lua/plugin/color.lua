return {
    {
        "folke/tokyonight.nvim",
        setup = function() vim.o.termguicolors = true end,
        config = function()
            vim.g.tokyonight_style = "storm"
            vim.g.tokyonight_italic_functions = true
            vim.g.tokyonight_sidebars = {}
            vim.g.tokyonight_hide_inactive_statusline = true;
            vim.cmd([[ colorscheme tokyonight ]])
        end
    }
}
