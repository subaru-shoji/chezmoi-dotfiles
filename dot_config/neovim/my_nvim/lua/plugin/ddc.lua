return {
    {
        "Shougo/ddc.vim",
        requires = {
            "Shougo/ddc-nvim-lsp", "Shougo/ddc-sorter_rank", "Shougo/pum.vim",
            "Shougo/ddc-matcher_head", "LumaKernel/ddc-file",
            "matsui54/denops-popup-preview.vim",
            "matsui54/denops-signature_help"
        },
        config = function()
            local patch_global = vim.fn["ddc#custom#patch_global"] -- patch_global("sources", {"nvim-lsp", "skkeleton"})
            patch_global('completionMenu', 'pum.vim')
            patch_global('autoCompleteEvents',
                         {'InsertEnter', 'TextChangedI', 'TextChangedP'})
            patch_global("sources", {"nvim-lsp", "file", "skkeleton"})
            patch_global("sourceOptions", {
                _ = {matchers = {"matcher_head"}, sorters = {"sorter_rank"}},
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

            vim.cmd([[
inoremap <c-n>   <cmd>call pum#map#insert_relative(+1)<cr>
inoremap <c-p>   <cmd>call pum#map#insert_relative(-1)<cr>
inoremap <c-y>   <cmd>call pum#map#confirm()<cr>
inoremap <silent><expr> <tab> pum#visible() ? '<cmd>call pum#map#insert_relative(+1)<cr>' : (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?  '<TAB>' : ddc#map#manual_complete()
inoremap <expr><s-tab>  pum#visible() ? '<cmd>call pum#map#insert_relative(-1)<cr>' : '<C-h>'
imap <silent><expr> <cr> pum#visible() ? "\<c-y>" : "\<cr>"
            ]])

            vim.fn["ddc#enable"]()
            -- vim.fn["signature_help#enable"]()
            vim.fn["popup_preview#enable"]()
        end
    }, {
        "Shougo/pum.vim",
        config = function() vim.fn['pum#set_option']('border', 'rounded') end
    }
}

