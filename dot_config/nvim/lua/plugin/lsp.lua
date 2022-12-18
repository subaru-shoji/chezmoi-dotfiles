return {
    {
        "neovim/nvim-lspconfig",
        requires = {
            "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim"
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()
            -- local capabilities = require('cmp_nvim_lsp').update_capabilities(
            --                          vim.lsp.protocol.make_client_capabilities())
            local on_attach = function()
                -- require('folding').on_attach()
            end

            local lsp_server_list = {
                rust_analyzer = {},
                clojure_lsp = {},
                elmls = {},
                tsserver = {}
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

            local runtime_path = vim.split(package.path, ';')
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")

            require'lspconfig'.sumneko_lua.setup {
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT'
                            -- Setup your lua path
                            -- path = runtime_path
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {'vim'}
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true)
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {enable = false}
                    }
                }
            }

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
        "rmagatti/goto-preview",
        config = function() require('goto-preview').setup {} end
    }
}
