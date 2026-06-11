return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = "ConformInfo",
		dependencies = { "mason-org/mason.nvim" },
		keys = {
			{
				",lf",
				function()
					require("conform").format({ lsp_format = "fallback" })
				end,
				mode = { "n", "x" },
				desc = "Format",
			},
		},
		---@type conform.setupOpts
		opts = {
			default_format_opts = {
				timeout_ms = 3000,
				async = false,
				quiet = false,
				lsp_format = "fallback",
			},
			-- toggle with ,uf (global) / vim.b.autoformat (buffer)
			format_on_save = function(bufnr)
				if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
					return
				end
				return {}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				fish = { "fish_indent" },
				sh = { "shfmt" },
				python = { "ruff_format" },
				dart = { "dart_format" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				jsonc = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
}
