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
vim.keymap.set("x", "y", "y`]")

vim.keymap.set("i", "<c-bs>", "<c-\\><c-o>db")

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.keymap.set("n", "K", "<cmd>BufferNext<cr>", { noremap = true, silent = true, buffer = true })
		vim.keymap.set("n", "J", "<cmd>BufferPrevious<cr>", { noremap = true, silent = true, buffer = true })
	end,
})
vim.keymap.set("n", "<c-w>s", "<cmd>rightbelow wincmd s<cr>")
vim.keymap.set("n", "<c-w>v", "<cmd>rightbelow wincmd v<cr>")
vim.keymap.set("n", "t", "<cmd>wincmd w<cr>")
vim.keymap.set("n", "X", "<cmd>Telescope oldfiles<cr>")
vim.keymap.set("n", "C", function()
	require("buffer_util").smart_close()
end)

vim.keymap.set("n", "<c-f>", [[<cmd>lua require "hop".hint_words()<cr>]])
vim.keymap.set("i", "<c-f>", [[<c-o><cmd>lua require "hop".hint_words()<cr>]])
vim.keymap.set("v", "<c-f>", [[<cmd>lua require "hop".hint_words()<cr>]])
vim.api.nvim_set_keymap("x", "/", ":SearchBoxIncSearch visual_mode=true<CR>", { noremap = true })
vim.keymap.set(
	"n",
	"?",
	"<cmd>silent vimgrep//gj%|Trouble qflist<cr>",
	{ desc = "Populate latest search result to quickfix list" }
)

vim.keymap.set("n", "\\", function()
	local options = vim.bo.ft == "neo-tree" or "default"
	require("menu").open(options)
end, {})

local wk = require("which-key")
local telescope = require("telescope.builtin")
local finder = require("telescope.finder")

wk.add({
	-- Mappings without prefix (previously in wk.register({}, {}))
	{
		"D",
		function()
			require("goto-preview").goto_preview_definition()
		end,
		desc = "definition",
	},
	{
		"f",
		function()
			require("hop").hint_words()
		end,
		desc = "hop",
	},
	{ "F", "<cmd>HopChar2<cr>", desc = "hop char2" },
	-- { "?",          function() require("searchbox").incsearch() end,                  desc = "SearchBox" },

	-- Mappings with <leader> prefix
	{ "<leader>", group = "leader" },
	{
		"<leader> ",
		function()
			telescope.fd()
		end,
		desc = "find file",
	},
	{
		"<leader>a",
		function()
			vim.cmd.SidebarToggle("neotree")
		end,
		desc = "file-tree bar",
	},
	{ "<leader>c", group = "copilot agent" },
	{
		"<leader>cx",
		function()
			require("codex").toggle()
		end,
		desc = "codex",
	},
	{
		"<leader>cc",
		function()
			vim.cmd([[ClaudeCode]])
		end,
		desc = "claude code",
	},
	{
		"<leader>d",
		function()
			vim.cmd.SidebarCloseAll()
		end,
		desc = "close sidebar",
	},
	{ "<leader>f", "<cmd>Yazi cwd<cr>", desc = "yazi filer" },
	{ "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGit" },
	-- { "<leader>g",  "<cmd>Telescope git_status<cr>",                                  desc = "telescope git status" },
	{ "<leader>o", "<cmd>Other<cr>", desc = "other switcher" },
	{ "<leader>r", "<cmd>SearchBoxReplace confirm=menu<cr>", desc = "SearchBoxReplace" },
	{
		"<leader>s",
		function()
			vim.cmd.SidebarToggle("spectre")
		end,
		desc = "Search Project",
	},
	{ "<leader>t", "<cmd>Neotree reveal<cr>", desc = "Find file on Neotree" },
	{
		"<leader>w",
		function()
			require("nvim-window").pick()
		end,
		desc = "switch window",
	},
	{ "<leader>x", require("buffer_util").smart_close, desc = "smart quit buffer" },
	{ "<leader>p", "<cmd>Telescope neoclip<cr>", desc = "neoclip" },
	{ "<leader>q", group = "quit/close" },
	{ "<leader>qa", require("buffer_util").close_all, desc = "close_all" },
	{ "<leader>qq", require("buffer_util").smart_close, desc = "smart quit buffer" },
	{
		"<leader>qc",
		function()
			vim.api.nvim_command("wincmd c")
		end,
		desc = "close window",
	},
	{
		"<leader>.",
		function()
			vim.lsp.buf.code_action()
		end,
		desc = "telescope lsp action",
	},
	{
		"<leader>,",
		function()
			finder.language_command_picker()
		end,
		desc = "language commands",
	},

	-- Mappings with , prefix
	{ ",", group = "local leader" },
	{ ",l", group = "lsp" },
	{
		",lr",
		function()
			vim.lsp.buf.rename()
		end,
		desc = "rename symbol",
	},
	{
		",lR",
		function()
			local current_file_path = vim.fn.expand("%f")
			local changed_file_path = vim.fn.input("Change file name: ", current_file_path)
			vim.lsp.util.rename(current_file_path, changed_file_path)
		end,
		desc = "rename file",
	},
	{ ",g", group = "git" },
	{
		",gs",
		function()
			vim.cmd.Neogit("kind=split")
		end,
		desc = "neogit status",
	},
	{
		",gc",
		function()
			vim.cmd.Neogit("commit")
		end,
		desc = "neogit commit",
	},
	{
		",gb",
		function()
			vim.cmd.Neogit("branch")
		end,
		desc = "neogit branch",
	},
	{
		",gB",
		function()
			require("agitator").git_blame_toggle()
		end,
		desc = "git blame",
	},
	{
		",gl",
		function()
			vim.cmd.Neogit("log")
		end,
		desc = "neogit log",
	},
	{ ",gt", "<cmd>Tig<cr>", desc = "tig" },
	{ ",gg", "<cmd>Telescope git_status<cr>", desc = "telescopt git status" },
	{ ",gh", "<cmd>OpenGithubFile<cr>", desc = "open github" },
	{ ",a", group = "often use tools" },
	{
		",aa",
		function()
			vim.cmd.SidebarToggle("neotree")
		end,
		desc = "file-tree bar",
	},
	{ ",as", "<cmd>botright TigStatus<cr>", desc = "tig status" },
	{ ",b", group = "buffer" },
	{ ",bp", "<cmd>BufferLineTogglePin<cr>", desc = "toggle buffer pinned" },
	{ ",t", group = "test" },
	{
		",ta",
		function()
			local qt = require("quicktest")

			qt.run_all()
		end,
		desc = "test all",
	},
	{
		",tf",
		function()
			local qt = require("quicktest")

			qt.run_file()
		end,
		desc = "test file",
	},
	{
		",tt",
		function()
			local qt = require("quicktest")

			qt.run_file()
		end,
		desc = "test file",
	},
	{
		",tl",
		function()
			local qt = require("quicktest")
			-- current_win_mode return currently opened panel, split or popup
			qt.run_line()
		end,
		desc = "test line",
	},
	{
		",tp",
		function()
			local qt = require("quicktest")
			qt.run_previous()
		end,
		desc = "test previous",
	},
	{ ",,", group = "language" },
	{ ",,r", group = "ruby" },
	{ ",,ro", "<cmd>Other<cr>", desc = "other switcher" },
	{ ",,rs", "<cmd>RailsGenerateSigFile<cr>", desc = "generate sig file" },

	-- Mappings with g prefix
	{ "g", group = "goto/show" },
	{
		"gd",
		function()
			telescope.lsp_definitions()
		end,
		desc = "go to definition",
	},
	{
		"gr",
		function()
			telescope.lsp_references()
		end,
		desc = "show reference",
	},

	-- Mappings with <tab> prefix
	{ "<tab>", group = "telescope" },
	{ "<tab><tab>", "<cmd>Telescope cmdline<cr>", desc = "find command" },
	{ "<tab>a", "<cmd>Telescope<cr>", desc = "telescope" },
	{
		"<tab>b",
		function()
			telescope.buffers()
		end,
		desc = "buffers",
	},
	{
		"<tab>d",
		function()
			telescope.lsp_document_diagnostics()
		end,
		desc = "lsp diagnotics",
	},
	{
		"<tab>e",
		function()
			finder.my_custom_search()
		end,
		desc = "gh pr files",
	},
	{
		"<tab>f",
		function()
			telescope.fd()
		end,
		desc = "fd",
	},
	{
		"<tab>g",
		function()
			telescope.git_status()
		end,
		desc = "git status",
	},
	{ "<tab>h", "<cmd>Telescope help_tags<cr>", desc = "help" },
	{
		"<tab>j",
		function()
			telescope.jumplist()
		end,
		desc = "jumplist",
	},
	{
		"<tab>k",
		function()
			telescope.keymaps()
		end,
		desc = "keymaps",
	},
	{ "<tab>n", "<cmd>Telescope notify<cr>", desc = "notify" },
	{ "<tab>r", "<cmd>Telescope oldFiles<cr>", desc = "recent files" },
	{
		"<tab>s",
		function()
			require("telescope").extensions.egrepify.egrepify({})
		end,
		desc = "search word",
	},
	{ "<tab>p", "<cmd>Telescope neoclip<cr>", desc = "neoclip" },
})
