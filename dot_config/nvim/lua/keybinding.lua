-- vikeymap.set."i",g.mapleader = " "

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

vim.keymap.set("n", "<c-s>", "<cmd>update<cr>")
vim.keymap.set("v", "<c-s>", "<cmd>update<cr>")
vim.keymap.set("i", "<c-s>", "<esc><cmd>update<cr>")

vim.keymap.set("n", "H", "<c-o>")
vim.keymap.set("n", "L", "<c-i>")
vim.keymap.set("n", "<c-j>", "<cmd>Telescope jumplist<cr>")

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

--overwrite on enter.
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.keymap.set("n", "K", "<cmd>BufferLineCycleNext<cr>")
		vim.keymap.set("n", "J", "<cmd>BufferLineCyclePrev<cr>")
	end,
})
vim.keymap.set("n", "<c-w>q", function()
	require("buffer").smart_close()
end)
vim.keymap.set("n", "<c-w>Q", function()
	require("buffer").close_all()
end)
vim.keymap.set("n", "<c-w>s", "<cmd>rightbelow wincmd s<cr>")
vim.keymap.set("n", "<c-w>v", "<cmd>rightbelow wincmd v<cr>")
vim.keymap.set("n", "t", "<cmd>wincmd w<cr>")
vim.keymap.set("n", "X", "<cmd>Telescope oldfiles<cr>")
vim.keymap.set("n", "C", function()
	require("buffer").smart_close()
end)

vim.keymap.set("n", "gs", "<plug>(GrepperOperator)")

local wk = require("which-key")
local telescope = require("telescope.builtin")

wk.register({
	D = {
		function()
			require("goto-preview").goto_preview_definition()
		end,
		"definition",
	},
	f = { "<cmd>HopChar2<cr>", "hop char2" },
	F = {
		function()
			require("hop").hint_words()
		end,
		"hop",
	},
	["?"] = {
		function()
			require("searchbox").incsearch()
		end,
		"SearchBox",
	},
}, {})

vim.keymap.set("i", "<c-f>", [[<c-o><cmd>lua require "hop".hint_words()<cr>]])
vim.api.nvim_set_keymap("x", "/", ":SearchBoxIncSearch visual_mode=true<CR>", { noremap = true })

wk.register({
	[" "] = {
		function()
			telescope.find_files()
		end,
		"find file",
	},
	a = {
		function()
			vim.cmd.SidebarToggle("nvimtree")
		end,
		"file-tree bar",
	},
	g = { "<cmd>Telescope git_status<cr>", "telescopt git status" },
	r = { "<cmd>SearchBoxReplace confirm=menu<cr>", "SearchBoxReplace" },
	s = {
		function()
			vim.cmd.SidebarToggle("spectre")
		end,
		"Search Project",
	},
	w = {
		function()
			require("nvim-window").pick()
		end,
		"switch window",
	},
	x = { require("buffer").smart_close, "smart quit buffer" },
	p = { "<cmd>Telescope neoclip<cr>", "neoclip" },
	q = {
		a = { require("buffer").close_all, "close_all" },
		q = { require("buffer").smart_close, "smart quit buffer" },
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
}, { prefix = "<leader>" })

wk.register({
	f = {
		name = "file",
		b = { "<cmd>Grepper -buffer -tool ag<cr>", "Grepper buffer" },
		f = { "<cmd>Grepper -tool ag<cr>", "Search Project" },
		d = { "<cmd>Grepper -grepprg fd --hidden -t f<cr>", "fd quickfix" },
		r = {
			function()
				telescope.oldfiles()
			end,
			"find recent files",
		},
	},
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
		t = { "<cmd>TroubleToggle<cr>", "trouble bar" },
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

local appears = function(opts)
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	opts = opts or {}
	pickers
			.new(opts, {
				prokeymap.setp("i"),
				t_title = "appear",
				finder = finders.new_table({
					results = { "NvimTreeToggle", "FloatermNew ranger" },
				}),
				sorter = conf.generic_sorter(opts),
				attach_mappings = function(prompt_bufnr)
					actions.select_default:replace(function()
						local selection = action_state.get_selected_entry()
						if selection == nil then
							print("[telescope] Nothing currently selected")
							return
						end

						actions.close(prompt_bufnr)
						local cmd = selection.value
						print(cmd)
						vim.cmd(cmd)
					end)

					return true
				end,
			})
			:find()
end

wk.register({
	["<tab>"] = {
		function()
			telescope.commands()
		end,
		"find command",
	},
	a = { "<cmd>Telescope<cr>", "telescope" },
	b = {
		function()
			telescope.buffers()
		end,
		"buffers",
	},
	c = {
		function()
			appears()
		end,
		"appears",
	},
	d = {
		function()
			telescope.lsp_document_diagnostics()
		end,
		"lsp diagnotics",
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
		function()
			telescope.oldfiles()
		end,
		"recent files",
	},
	s = {
		function()
			telescope.grep_string()
		end,
		"search word",
	},
	p = { "<cmd>Telescope neoclip<cr>", "neoclip" },
}, { prefix = "<tab>" })

if vim.fn.executable("fcitx5-remote") then
	for _, event in ipairs({ "InsertLeave", "CmdlineLeave" }) do
		vim.api.nvim_create_autocmd(event, {
			pattern = "*",
			callback = function(_)
				vim.fn.system("fcitx5-remote -c")
			end,
		})
	end
elseif vim.fn.executable("im-select") then
	for _, event in ipairs({ "InsertLeave", "CmdlineLeave" }) do
		vim.api.nvim_create_autocmd(event, {
			pattern = "*",
			callback = function(_)
				vim.fn.system("im-select com.apple.keylayout.ABC")
			end,
		})
	end
end

vim.keymap.set("n", "<c-k>", "i<Plug>(skkeleton-enable)")
vim.keymap.set("i", "<c-k>", "<Plug>(skkeleton-toggle)")
vim.keymap.set("c", "<c-k>", "<Plug>(skkeleton-toggle)")
