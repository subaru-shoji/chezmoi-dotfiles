return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- local capabilities = require('cmp_nvim_lsp').update_capabilities(
            --                          vim.lsp.protocol.make_client_capabilities())
            local on_attach = function()
                require('folding').on_attach()
            end

            local lsp_server_list = {
                rust_analyzer = {},
                clojure_lsp = {},
                elmls = {}
            }

            local util = require("util")

            local base_config = {
                -- capabilities = capabilities,
                on_attach = on_attach
            }

            for server, config in pairs(lsp_server_list) do
                local merged_config = util.merge(config, base_config)
                require("lspconfig")[server].setup(merged_config)
            end

            vim.cmd(
                [[autocmd BufWritePre *.rs,*.dart lua vim.lsp.buf.formatting_sync(nil, 1000)]])
        end
    }, {
        "kosayoda/nvim-lightbulb",
        config = function()
            vim.cmd(
                [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
        end
    },
    {"onsails/lspkind-nvim", config = function() require("lspkind").init() end},
    {"pierreglaser/folding-nvim"}, {
        "ray-x/lsp_signature.nvim",
        config = function()
            require"lsp_signature".setup {
                bind = true,
                handler_opts = {border = "rounded"}
            }
        end
    }, {
        "rmagatti/goto-preview",
        config = function() require('goto-preview').setup {} end
    }
}
