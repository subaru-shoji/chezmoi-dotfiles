vim.api.nvim_set_var("mapleader", " ")
vim.api.nvim_set_var("maplocalleader", ",")

vim.keymap.set("i", "jj", "<esc>")

vim.keymap.set("i", "<c-a>", "<c-o>I", { silent = true })
vim.keymap.set("i", "<c-e>", "<c-o>A", { silent = true })
vim.keymap.set("c", "<c-a>", "<home>")
vim.keymap.set("c", "<c-e>", "<end>")
vim.keymap.set("n", "<c-a>", "^")
vim.keymap.set("n", "<c-e>", "g_")
vim.keymap.set("v", "<c-a>", "^")
vim.keymap.set("v", "<c-e>", "g_")
vim.keymap.set("n", "gj", "G")
vim.keymap.set("n", "gk", "gg")
vim.keymap.set("v", "gj", "G")
vim.keymap.set("v", "gk", "gg")
vim.keymap.set("n", "gx", "<esc>:URLOpenUnderCursor<cr>")

vim.keymap.set("n", "<c-s>", "<cmd>update<cr>")
vim.keymap.set("v", "<c-s>", "<cmd>update<cr>")
vim.keymap.set("i", "<c-s>", "<esc><cmd>update<cr>")

vim.keymap.set("n", "H", "<c-o>")
vim.keymap.set("n", "L", "<c-i>")

vim.keymap.set("n", "<esc><esc>", "<cmd>nohl<cr>", { silent = true, nowait = true })

vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

vim.keymap.set("n", "<c-up>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<c-down>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<c-left>", "<cmd>vertical resize +2<cr>")
vim.keymap.set("n", "<c-right>", "<cmd>vertical resize -2<cr>")

vim.keymap.set("n", "<s-up>", "v<up>")
vim.keymap.set("n", "<s-down>", "v<down>")
vim.keymap.set("v", "<s-up>", "<up>")
vim.keymap.set("v", "<s-down>", "<down>")
vim.keymap.set("v", "<s-left>", "<left>")
vim.keymap.set("v", "<s-right>", "<right>")
vim.keymap.set("i", "<s-up>", "<esc>v<up>")
vim.keymap.set("i", "<s-down>", "<esc>v<down>")
vim.keymap.set("i", "<s-left>", "<esc>v<left>")
vim.keymap.set("i", "<s-right>", "<esc>v<right>")

vim.keymap.set("v", "Y", '"+y')
vim.keymap.set("v", "X", '"+x')

vim.keymap.set("i", "<c-bs>", "<c-\\><c-o>db")

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.keymap.set("n", "K", "<cmd>BufferLineCycleNext<cr>", { noremap = true, silent = true, buffer = true })
		vim.keymap.set("n", "J", "<cmd>BufferLineCyclePrev<cr>", { noremap = true, silent = true, buffer = true })
	end,
})
-- vim.keymap.set("n", "K", "<cmd>BufferLineCycleNext<cr>")
-- vim.keymap.set("n", "J", "<cmd>BufferLineCyclePrev<cr>")
vim.keymap.set("n", "<c-w>s", "<cmd>rightbelow wincmd s<cr>")
vim.keymap.set("n", "<c-w>v", "<cmd>rightbelow wincmd v<cr>")
vim.keymap.set("n", "t", "<cmd>wincmd w<cr>")
vim.keymap.set("n", "X", "<cmd>Telescope oldfiles<cr>")
vim.keymap.set("n", "C", function()
	require("buffer_util").smart_close()
end)

local wk = require("which-key")
local telescope = require("telescope.builtin")
local finder = require("telescope.finder")

wk.register({
	D = {
		function()
			require("goto-preview").goto_preview_definition()
		end,
		"definition",
	},
	f = {
		function()
			require("hop").hint_words()
		end,
		"hop",
	},
	F = { "<cmd>HopChar2<cr>", "hop char2" },
	["?"] = {
		function()
			require("searchbox").incsearch()
		end,
		"SearchBox",
	},
}, {})

vim.keymap.set("n", "<c-f>", [[<cmd>lua require "hop".hint_words()<cr>]])
vim.keymap.set("i", "<c-f>", [[<c-o><cmd>lua require "hop".hint_words()<cr>]])
vim.keymap.set("v", "<c-f>", [[<cmd>lua require "hop".hint_words()<cr>]])
vim.api.nvim_set_keymap("x", "/", ":SearchBoxIncSearch visual_mode=true<CR>", { noremap = true })

vim.keymap.set("n", "\\", function()
	local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
	require("menu").open(options)
end, {})

wk.register({
	[" "] = {
		function()
			telescope.fd()
		end,
		"find file",
	},
	a = {
		function()
			vim.cmd.SidebarToggle("nvimtree")
		end,
		"file-tree bar",
	},
	d = {
		function()
			vim.cmd.SidebarCloseAll()
		end,
		"close sidebar",
	},
	f = {
		"<cmd>Yazi cwd<cr>",
		"yazi filer",
	},
	g = { "<cmd>Telescope git_status<cr>", "telescope git status" },
	o = { "<cmd>Other<cr>", "other switcher" },
	r = { "<cmd>SearchBoxReplace confirm=menu<cr>", "SearchBoxReplace" },
	s = {
		function()
			vim.cmd.SidebarToggle("spectre")
		end,
		"Search Project",
	},
	t = {
		"<cmd>NvimTreeFindFile<cr>",
		"Find file on NvimTree",
	},
	w = {
		function()
			require("nvim-window").pick()
		end,
		"switch window",
	},
	x = { require("buffer_util").smart_close, "smart quit buffer" },
	p = { "<cmd>Telescope neoclip<cr>", "neoclip" },
	q = {
		a = { require("buffer_util").close_all, "close_all" },
		q = { require("buffer_util").smart_close, "smart quit buffer" },
		c = {
			function()
				vim.api.nvim_command("wincmd c")
			end,
			"close window",
		},
	},
	["."] = {
		function()
			-- telescope.lsp_code_actions()
			vim.lsp.buf.code_action()
		end,
		"telescope lsp action",
	},
	[","] = {
		function()
			finder.language_command_picker()
		end,
		"language commands",
	},
}, { prefix = "<leader>" })

wk.register({
	l = {
		name = "lsp",
		r = {
			function()
				vim.lsp.buf.rename()
			end,
			"rename symbol",
		},
		R = {
			function()
				local current_file_path = vim.fn.expand("%f")
				local changed_file_path = vim.fn.input("Change file name: ", current_file_path)
				vim.lsp.util.rename(current_file_path, changed_file_path)
			end,
			"rename file",
		},
	},
	g = {
		name = "git",
		s = {
			function()
				vim.cmd.Neogit("kind=split")
			end,
			"neogit status",
		},
		c = {
			function()
				vim.cmd.Neogit("commit")
			end,
			"neogit commit",
		},
		b = {
			function()
				vim.cmd.Neogit("branch")
			end,
			"neogit branch",
		},
		B = {
			function()
				require("agitator").git_blame_toggle()
			end,
			"git blame",
		},
		l = {
			function()
				vim.cmd.Neogit("log")
			end,
			"neogit log",
		},
		t = { "<cmd>Tig<cr>", "tig" },
		g = { "<cmd>Telescope git_status<cr>", "telescopt git status" },
		h = { "<cmd>OpenGithubFile<cr>", "open github" },
	},
	a = {
		name = "often use tools",
		a = {
			function()
				vim.cmd.SidebarToggle("nvimtree")
			end,
			"file-tree bar",
		},
		s = { "<cmd>botright TigStatus<cr>", "tig status" },
	},
	b = {
		name = "buffer",
		z = { function()
			require('close_buffers').wipe({ type = 'other' })
		end,
			"delete other buffer"
		},
		p = { "<cmd>BufferLineTogglePin<cr>", "toggle buffer pinned" },
	},
	t = {
		name = "toggle",
		m = {
			function()
				if vim.o.mouse ~= "a" then
					vim.o.mouse = "a"
				else
					vim.o.mouse = ""
				end
			end,
			"mouse toggle",
		},
	},
	[","] = {
		name = "language",
		r = {
			name = "ruby",
			o = { "<cmd>Other<cr>", "other switcher" },
			s = { "<cmd>RailsGenerateSigFile<cr>", "generate sig file" },
		},
	},
}, { prefix = "," })

wk.register({
	d = {
		function()
			telescope.lsp_definitions()
		end,
		"go to definition",
	},
	r = {
		function()
			telescope.lsp_references()
		end,
		"show reference",
	},
}, { prefix = "g" })

wk.register({
	["<tab>"] = {
		"<cmd>Telescope cmdline<cr>",
		"find command",
	},
	a = { "<cmd>Telescope<cr>", "telescope" },
	b = {
		function()
			telescope.buffers()
		end,
		"buffers",
	},
	d = {
		function()
			telescope.lsp_document_diagnostics()
		end,
		"lsp diagnotics",
	},
	e = {
		function()
			finder.my_custom_search()
		end,
		"gh pr files",
	},
	f = {
		function()
			telescope.fd()
		end,
		"fd",
	},
	g = {
		function()
			telescope.git_status()
		end,
		"git status",
	},
	h = {
		"<cmd>Telescope help_tags<cr>",
		"help",
	},
	j = {
		function()
			telescope.jumplist()
		end,
		"jumplist",
	},
	n = {
		"<cmd>Telescope notify<cr>",
		"notify",
	},
	r = {
		"<cmd>Telescope oldFiles<cr>",
		"recent files",
	},
	s = {
		function()
			require("telescope").extensions.egrepify.egrepify({})
		end,
		"search word",
	},
	p = { "<cmd>Telescope neoclip<cr>", "neoclip" },
}, { prefix = "<tab>" })
