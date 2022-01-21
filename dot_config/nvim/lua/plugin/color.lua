return {
    {
        "folke/tokyonight.nvim",
        setup = function() vim.o.termguicolors = true end,
        config = function()
            vim.g.tokyonight_style = "night"
            vim.g.tokyonight_italic_functions = true
            vim.g.tokyonight_sidebars = {}
            vim.cmd([[ colorscheme tokyonight ]])
        end
    }
}
