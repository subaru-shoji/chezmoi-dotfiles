local vimp = require("vimp")

vim.g.mapleader = " "

vimp.imap("jj", "<esc>")

vimp.imap({"silent"}, "<c-a>", "<c-o>I")
vimp.imap({"silent"}, "<c-e>", "<c-o>A")
vimp.cmap({"silent"}, "<c-a>", "<home>")
vimp.cmap({"silent"}, "<c-e>", "<end>")
vimp.nmap("<c-a>", "^")
vimp.nmap("<c-e>", "g_")
vimp.vmap("<c-a>", "^")
vimp.vmap("<c-e>", "g_")

vimp.nnoremap("<c-s>", "<cmd>update<cr>")
vimp.vnoremap("<c-s>", "<cmd>update<cr>")
vimp.inoremap("<c-s>", "<esc><cmd>update<cr>")

vimp.nnoremap("H", "<c-o>")
vimp.nnoremap("L", "<c-i>")
vimp.nnoremap("<c-j>", "<cmd>Telescope jumplist<cr>")

vimp.nnoremap({"silent", "nowait"}, "<esc><esc>", "<cmd>nohl<cr>")

vimp.nmap("<s-up>", "v<up>")
vimp.nmap("<s-down>", "v<down>")
vimp.nmap("<s-left>", "v<left>")
vimp.nmap("<s-right>", "v<right>")
vimp.vmap("<s-up>", "<up>")
vimp.vmap("<s-down>", "<down>")
vimp.vmap("<s-left>", "<left>")
vimp.vmap("<s-right>", "<right>")
vimp.imap("<s-up>", "<esc>v<up>")
vimp.imap("<s-down>", "<esc>v<down>")
vimp.imap("<s-left>", "<esc>v<left>")
vimp.imap("<s-right>", "<esc>v<right>")

vimp.vmap("Y", '"+y')
vimp.vmap("X", '"+x')

-- window/buffer management--
vim.cmd(
    [[autocmd BufEnter * map <buffer> <silent> <s-k> <cmd>BufferLineCycleNext<cr>]])
vimp.nnoremap({"silent"}, "J", "<cmd>BufferLineCyclePrev<cr>")
vim.keymap.set("n", "<c-w>q", function() require("buffer").smart_close() end)
vim.keymap.set("n", "<c-w>Q", function() require("buffer").close_all() end)
vim.keymap.set("n", "<c-w>s", "<cmd>rightbelow wincmd s<cr>")
vim.keymap.set("n", "<c-w>v", "<cmd>rightbelow wincmd v<cr>")
vim.keymap.set("n", "t", "<cmd>wincmd w<cr>")
vim.keymap.set("n", "X", "<cmd>Telescope oldfiles<cr>")
vim.keymap.set("n", "C", function() require("buffer").smart_close() end)

vimp.nmap("gs", "<plug>(GrepperOperator)")
vimp.xmap("gs", "<plug>(GrepperOperator)")

local wk = require("which-key")
local telescope = require("telescope.builtin")

wk.register({
    D = {
        function() require('goto-preview').goto_preview_definition() end,
        "definition"
    },
    f = {"<cmd>HopChar2<cr>", "hop char2"},
    F = {function() require("hop").hint_words() end, "hop"},
    ["?"] = {function() require("searchbox").incsearch() end, "SearchBox"}
}, {})

vimp.inoremap("<c-f>", [[<c-o><cmd>lua require "hop".hint_words()<cr>]])
vim.api.nvim_set_keymap("x", "/", ":SearchBoxIncSearch visual_mode=true<CR>",
                        {noremap = true})

local find_files_action = {function() telescope.find_files() end, "find file"}
wk.register({
    [" "] = find_files_action,
    a = {function() vim.fn["sidebar#toggle"]('nvimtree') end, "file-tree bar"},
    g = {"<cmd>Telescope git_status<cr>", "telescopt git status"},
    r = {"<cmd>SearchBoxReplace confirm=menu<cr>", "SearchBoxReplace"},
    s = {"<cmd>Grepper -tool ag<cr>", "Search Project"},
    w = {function() require('nvim-window').pick() end, "switch window"},
    x = {require("buffer").smart_close, "smart quit buffer"},
    q = {
        a = {require("buffer").close_all, "close_all"},
        q = {require("buffer").smart_close, "smart quit buffer"},
        c = {function() vim.api.nvim_command "wincmd c" end, "close window"}
    },
    ["."] = {
        function()
            -- telescope.lsp_code_actions()
            vim.lsp.buf.code_action()
        end, "telescope lsp action"
    }
}, {prefix = "<leader>"})

wk.register({
    f = {
        name = "file",
        b = {"<cmd>Grepper -buffer -tool ag<cr>", "Grepper buffer"},
        d = {"<cmd>Grepper -grepprg fd --hidden -t f<cr>", "fd quickfix"},
        f = {"<cmd>Grepper -grepprg fd --hidden -t f<cr>", "fd quickfix"},
        r = {function() telescope.oldfiles() end, "find recent files"}
    },
    l = {
        name = "lsp",
        r = {function() vim.lsp.buf.rename() end, "rename symbol"},
        R = {
            function()
                local current_file_path = vim.fn.expand("%f")
                local changed_file_path =
                    vim.fn.input("Change file name: ", current_file_path)
                vim.lsp.util.rename(current_file_path, changed_file_path)
            end, "rename file"
        },
        t = {"<cmd>TroubleToggle<cr>", "trouble bar"}
    },
    g = {
        name = "git",
        s = {
            function() require("neogit").open({kind = "split"}) end,
            "neogit status"
        },
        c = {function() require("neogit").open({"commit"}) end, "neogit commit"},
        b = {function() require("neogit").open({"branch"}) end, "neogit branch"},
        B = {function() require("agitator").git_blame_toggle() end, "git blame"},
        l = {function() require("neogit").open({"log"}) end, "neogit log"},
        t = {"<cmd>Tig<cr>", "tig"},
        g = {"<cmd>Telescope git_status<cr>", "telescopt git status"},
        h = {"<cmd>OpenGithubFile<cr>", "open github"}
    },
    a = {
        name = "often use tools",
        a = {
            function() vim.fn["sidebar#toggle"]('nvimtree') end, "file-tree bar"
        },
        s = {"<cmd>botright TigStatus<cr>", "tig status"}
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
            end, "mouse toggle"
        }
    }
}, {prefix = ","})

wk.register({
    d = {function() telescope.lsp_definitions() end, "go to definition"},
    r = {function() telescope.lsp_references() end, "show reference"},
    k = {"gg", "go to top"},
    j = {"G", "go to bottom"}
}, {prefix = "g"})

wk.register({k = {"gg", "go to top"}, j = {"G", "go to bottom"}},
            {prefix = "g", mode = "v"})

local appears = function(opts)
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "appear",
        finder = finders.new_table({
            results = {"NvimTreeToggle", "FloatermNew ranger"}
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
        end
    }):find()
end

wk.register({
    ["<tab>"] = {function() telescope.commands() end, "find command"},
    a = {"<cmd>Telescope<cr>", "telescope"},
    b = {function() telescope.buffers() end, "buffers"},
    c = {function() appears() end, "appears"},
    d = {function() telescope.lsp_document_diagnostics() end, "lsp diagnotics"},
    f = {function() telescope.fd() end, "fd"},
    g = {function() telescope.git_status() end, "git status"},
    r = {function() telescope.oldfiles() end, "recent files"},
    y = {"<cmd>Telescope neoclip<cr>", "neoclip"}
}, {prefix = "<tab>"})

if vim.fn.executable("fcitx5-remote") then
    for _, event in ipairs({"InsertLeave", "CmdlineLeave"}) do
        vim.api.nvim_create_autocmd(event, {
            pattern = "*",
            callback = function(_) vim.fn.system("fcitx5-remote -c") end
        })
    end
elseif vim.fn.executable("im-select") then
    for _, event in ipairs({"InsertLeave", "CmdlineLeave"}) do
        vim.api.nvim_create_autocmd(event, {
            pattern = "*",
            callback = function(_)
                vim.fn.system("im-select com.apple.keylayout.ABC")
            end
        })
    end
end

vimp.nmap("<c-k>", "i<Plug>(skkeleton-enable)")
vimp.imap("<c-k>", "<Plug>(skkeleton-toggle)")
vimp.cmap("<c-k>", "<Plug>(skkeleton-toggle)")
