return {
	{
		"Shougo/ddc.vim",
		requires = {
			"Shougo/ddc-matcher_head",
			"Shougo/ddc-nvim-lsp",
			"LumaKernel/ddc-tabnine",
			"Shougo/ddc-around",
			"Shougo/ddc-sorter_rank",
			"matsui54/ddc-nvim-lsp-doc",
		},
		config = function()
			local patch_global = vim.fn["ddc#custom#patch_global"] -- patch_global("sources", {"nvim-lsp", "skkeleton"})
			patch_global("sources", { "tabnine", "nvim-lsp", "skkeleton", "around" })
			patch_global("sourceOptions", {
				_ = { matchers = { "matcher_head" }, sorters = { "sorter_rank" } },
				["nvim-lsp"] = {
					mark = "lsp",
					forceCompletionPattern = "\\.\\w*|:\\w*|->\\w*",
				},
				skkeleton = { mark = "skkeleton", matchers = { "skkeleton" }, sorters = {} },
				tabnine = { mark = "TN", maxCandidates = 5, isVolatile = true },
			})
			patch_global({ backspaceCompletion = true })

			vim.fn["ddc#custom#patch_filetype"]("clojure", "sources", { "iced" })
			vim.cmd([[
inoremap <silent><expr> <tab> pumvisible() ? '<c-n>' : (col('.') <= 1 <bar><bar> getline('.')[col('.') - 2] =~# '\s') ? '<tab>' : ddc#manual_complete()
inoremap <expr><s-tab>  pumvisible() ? '<c-p>' : '<c-h>'
inoremap <expr><cr>  pumvisible() ? "<c-y>" : "<cr>"
            ]])
			vim.fn["ddc#enable"]()
			vim.fn["ddc_nvim_lsp_doc#enable"]()
		end,
	},
}
