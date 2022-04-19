return {
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = "all",
                ignore_install = {"phpdoc"},
                sync_install = true,
                highlight = {enable = true},
                indent = {enable = true}

            }
            vim.o.foldmethod = 'expr'
            vim.o.foldexpr = 'nvim_treesitter#foldexpr'
        end
    }
}

