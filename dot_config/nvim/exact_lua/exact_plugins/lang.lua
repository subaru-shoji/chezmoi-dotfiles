-- language servers: TypeScript/JS (vtsls), Python (pyright + ruff), Dart/Flutter (dartls)
-- merged into the lspconfig opts defined in plugins/lsp.lua

local ts_settings = {
	updateImportsOnFileMove = { enabled = "always" },
	suggest = {
		completeFunctionCalls = true,
	},
	inlayHints = {
		enumMemberValues = { enabled = true },
		functionLikeReturnTypes = { enabled = true },
		parameterNames = { enabled = "literals" },
		parameterTypes = { enabled = true },
		propertyDeclarationTypes = { enabled = true },
		variableTypes = { enabled = false },
	},
}

return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				vtsls = {
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					settings = {
						complete_function_calls = true,
						vtsls = {
							enableMoveToFileCodeAction = true,
							autoUseWorkspaceTsdk = true,
							experimental = {
								maxInlayHintLength = 30,
								completion = {
									enableServerSideFuzzyMatch = true,
								},
							},
						},
						typescript = ts_settings,
						javascript = ts_settings,
					},
				},
				pyright = {},
				ruff = {
					cmd_env = { RUFF_TRACE = "messages" },
					init_options = {
						settings = {
							logLevel = "error",
						},
					},
				},
				-- ships with the Dart/Flutter SDK; not available via mason
				dartls = { mason = false },
			},
		},
	},
}
