return {
	-- installer for LSP servers / formatters
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
				"prettierd",
			},
			ui = {
				keymaps = {
					toggle_help = "<f1>",
				},
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			{ "mason-org/mason-lspconfig.nvim", config = function() end },
		},
		opts = {
			---@type vim.diagnostic.Opts
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
			},
			-- server configs; `mason = false` skips mason install/enable
			-- (language-specific servers are added in plugins/lang.lua)
			---@type table<string, vim.lsp.Config|{ mason?: boolean }>
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								callSnippet = "Replace",
							},
							doc = {
								privateName = { "^_" },
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			-- buffer-local keymaps and per-client tweaks
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("my_lsp_attach", { clear = true }),
				callback = function(event)
					local buf = event.buf
					local client = vim.lsp.get_client_by_id(event.data.client_id)

					local function bmap(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc, silent = true })
					end

					-- stylua: ignore start
					bmap("n", "gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
					bmap("n", "gr", function() Snacks.picker.lsp_references() end, "References")
					bmap("n", "gI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
					bmap("n", "gy", function() Snacks.picker.lsp_type_definitions() end, "Goto Type Definition")
					bmap("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
					bmap("n", "gh", function() return vim.lsp.buf.hover() end, "Hover")
					bmap("n", "gK", function() return vim.lsp.buf.signature_help() end, "Signature Help")
					bmap("i", "<c-k>", function() return vim.lsp.buf.signature_help() end, "Signature Help")
					bmap({ "n", "x" }, "<leader>.", vim.lsp.buf.code_action, "Code Action")
					bmap({ "n", "x" }, ",la", vim.lsp.buf.code_action, "Code Action")
					bmap("n", ",lr", vim.lsp.buf.rename, "Rename Symbol")
					bmap("n", ",lR", function() Snacks.rename.rename_file() end, "Rename File")
					bmap("n", ",li", function() Snacks.picker.lsp_config() end, "LSP Info")
					bmap("n", "]]", function() Snacks.words.jump(vim.v.count1) end, "Next Reference")
					bmap("n", "[[", function() Snacks.words.jump(-vim.v.count1) end, "Prev Reference")
					-- stylua: ignore end

					if client then
						-- inlay hints
						if client:supports_method("textDocument/inlayHint") and vim.bo[buf].buftype == "" then
							vim.lsp.inlay_hint.enable(true, { bufnr = buf })
						end
						-- ruff: disable hover in favor of pyright
						if client.name == "ruff" then
							client.server_capabilities.hoverProvider = false
						end
					end
				end,
			})

			vim.lsp.config("*", {
				capabilities = {
					workspace = {
						fileOperations = {
							didRename = true,
							willRename = true,
						},
					},
				},
			})

			local mason_map = require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package
			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(opts.servers) do
				local config = vim.deepcopy(server_opts)
				local use_mason = config.mason ~= false and mason_map[server] ~= nil
				config.mason = nil
				vim.lsp.config(server, config)
				if use_mason then
					table.insert(ensure_installed, server)
				else
					vim.lsp.enable(server)
				end
			end

			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed,
				-- stylua is a formatter, but mason-lspconfig would auto-enable it as an LSP
				automatic_enable = { exclude = { "stylua" } },
			})
		end,
	},

	-- multi-source hover (LSP / diagnostics / man / dictionary)
	{
		"lewis6991/hover.nvim",
		opts = {
			providers = {
				"hover.providers.diagnostic",
				"hover.providers.lsp",
				"hover.providers.man",
				"hover.providers.dictionary",
			},
			preview_opts = { border = "rounded" },
			preview_window = false,
			title = true,
		},
		config = function(_, opts)
			require("hover").config(opts)
		end,
		keys = {
			{
				"D",
				function()
					-- pressing D again focuses the hover window (for scrolling)
					local hover_win = vim.b.hover_preview
					if hover_win and vim.api.nvim_win_is_valid(hover_win) then
						vim.api.nvim_set_current_win(hover_win)
					else
						require("hover").open()
					end
				end,
				desc = "Hover (multi-source)",
			},
			-- stylua: ignore start
			{ "<c-n>", function() require("hover").switch("next") end, desc = "Hover next source" },
			{ "<c-p>", function() require("hover").switch("previous") end, desc = "Hover prev source" },
			-- stylua: ignore end
		},
	},
}
