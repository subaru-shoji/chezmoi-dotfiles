return true and {} or {
    {
        "Shougo/ddc.vim",
        requires = {
            "Shougo/ddc-nvim-lsp", "Shougo/ddc-sorter_rank", "Shougo/pum.vim",
            "tani/ddc-fuzzy", "LumaKernel/ddc-file",
            "matsui54/denops-popup-preview.vim",
            "matsui54/denops-signature_help"
        },
        config = function()
            local patch_global = vim.fn["ddc#custom#patch_global"] -- patch_global("sources", {"nvim-lsp", "skkeleton"})
            patch_global('completionMenu', 'pum.vim')
            patch_global('autoCompleteEvents', {
                'InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged'
            })
            patch_global("sources", {"nvim-lsp", "file", "skkeleton"})
            patch_global("sourceOptions", {
                _ = {
                    matchers = {"matcher_fuzzy"},
                    sorters = {"sorter_fuzzy"},
                    converters = {"converter_fuzzy"}
                },
                ["nvim-lsp"] = {
                    mark = "lsp",
                    forceCompletionPattern = "\\.\\w*|:\\w*|->\\w*"
                },
                file = {
                    mark = 'F',
                    isVolatile = true,
                    forceCompletionPattern = "\\S/\\S*"
                },
                skkeleton = {
                    mark = "skkeleton",
                    matchers = {"skkeleton"},
                    sorters = {}
                }
            })
            patch_global({backspaceCompletion = true})

            vim.cmd([[
inoremap <c-n>   <cmd>call pum#map#insert_relative(+1)<cr>
inoremap <c-p>   <cmd>call pum#map#insert_relative(-1)<cr>
inoremap <silent><expr> <TAB> ddc#map#pum_visible() ? '<C-n>' : (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?  '<TAB>' : pum#map#insert_relative(+1)
inoremap <expr><S-TAB>  ddc#map#pum_visible() ? '<C-p>' : '<C-h>'
inoremap <c-y>   <cmd>call pum#map#confirm()<cr>
            ]])

            vim.fn["ddc#enable"]()
            vim.fn["signature_help#enable"]()
            vim.fn["popup_preview#enable"]()
        end
    }
}

