return {
    {
        "hrsh7th/nvim-cmp",
        requires = {
            "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp", "hrsh7th/cmp-vsnip", "hrsh7th/vim-vsnip"
        },
        config = function()
            vim.g.completeopt = {"menu", "menuone", "noselect"}

            local cmp = require "cmp"

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    end
                },
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm({select = true}),
                    ['<Tab>'] = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end,
                    ['<S-Tab>'] = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end
                },
                sources = cmp.config.sources({
                    {name = 'nvim_lsp'}, {name = 'vsnip'}
                }, {{name = 'buffer'}})
            })

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            -- cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                sources = cmp.config
                    .sources({{name = 'path'}}, {{name = 'cmdline'}})
            })
        end
    }
}
