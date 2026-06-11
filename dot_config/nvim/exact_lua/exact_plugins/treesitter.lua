return {
	-- nvim-treesitter main branch: requires the tree-sitter CLI for :TSInstall
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		commit = vim.fn.has("nvim-0.12") == 0 and "7caec274fd19c12b55902a5b795100d21531391f" or nil,
		version = false,
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"dart",
				"diff",
				"fish",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
		},
		config = function(_, opts)
			local TS = require("nvim-treesitter")
			if not TS.get_installed then
				vim.notify("Please update nvim-treesitter (main branch required)", vim.log.levels.ERROR)
				return
			end
			TS.setup(opts)

			local installed = TS.get_installed()
			local to_install = vim.tbl_filter(function(lang)
				return not vim.tbl_contains(installed, lang)
			end, opts.ensure_installed)
			if #to_install > 0 then
				TS.install(to_install, { summary = true })
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("my_treesitter", { clear = true }),
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(ev.match)
					if lang and vim.tbl_contains(TS.get_installed(), lang) then
						pcall(vim.treesitter.start, ev.buf)
						vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},

	-- auto-close/rename HTML and JSX tags
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {},
	},

	-- ]f / [f / ]c / [c moves (and textobject queries used by mini.ai)
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("nvim-treesitter-textobjects").setup(opts)
			local moves = {
				goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
				goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
				goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
				goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
			}
			for method, keymaps in pairs(moves) do
				for key, query in pairs(keymaps) do
					vim.keymap.set({ "n", "x", "o" }, key, function()
						-- keep builtin ]c/[c in diff mode
						if vim.wo.diff and key:find("[cC]") then
							return vim.cmd("normal! " .. key)
						end
						require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
					end, { desc = ("%s %s"):format(key:sub(1, 1) == "[" and "Prev" or "Next", query), silent = true })
				end
			end
		end,
	},
}
