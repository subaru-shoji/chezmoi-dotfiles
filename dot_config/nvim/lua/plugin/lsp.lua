return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local on_attach = function()
                require('folding').on_attach()
            end
            require("lspconfig").rust_analyzer.setup({on_attach = on_attach})
            require("lspconfig").clojure_lsp.setup({on_attach = on_attach})
            require("lspconfig").elmls.setup({on_attach = on_attach})

            vim.cmd(
                [[autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)]])
        end
    }, {
        "kosayoda/nvim-lightbulb",
        config = function()
            vim.cmd(
                [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
        end
    },
    {"onsails/lspkind-nvim", config = function() require("lspkind").init() end},
    {"pierreglaser/folding-nvim"}
}
