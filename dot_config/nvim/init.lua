local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        "git", "clone", "https://github.com/wbthomason/packer.nvim",
        install_path
    })
    execute "packadd packer.nvim"
end

require("packer").startup(function(use)
    use "wbthomason/packer.nvim"
    use "svermeulen/vimpeccable"
    use "norcalli/nvim_utils"
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use {"hoob3rt/lualine.nvim", requires = {"kyazdani42/nvim-web-devicons"}}
    use {
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
    }
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = function() vim.g.nvim_tree_follow = 1 end
    }
    use {

        "lambdalisue/fern.vim",
        setup = function() vim.g["fern#renderer"] = "nerdfont" end
    }
    use "lambdalisue/nerdfont.vim"
    use "lambdalisue/glyph-palette.vim"
    use "lambdalisue/fern-renderer-nerdfont.vim"
    use "lambdalisue/fern-git-status.vim"
    use "lambdalisue/fern-hijack.vim"
    use "yuki-yano/fern-preview.vim"
    use {
        "neovim/nvim-lspconfig",
        config = function()
            require'lspconfig'.rust_analyzer.setup {}
            require'lspconfig'.tsserver.setup {}
        end
    }
    use {
        "tjdevries/nlua.nvim",
        config = function()
            require('nlua.lsp.nvim').setup(require('lspconfig'), {})
            vim.cmd [[autocmd BufWritePost *.lua silent lua require'nlua'.format_file()]]
        end
    }
    use {"rust-lang/rust.vim", init = function() vim.g.rustfmt_autosave = 1 end}

    use 'leafgarland/typescript-vim'
    use {
        'peitalin/vim-jsx-typescript',
        config = function()
            vim.cmd [[autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact]]
        end
    }

    use {"tyru/eskk.vim"}
    use {
        "glepnir/lspsaga.nvim",
        config = function()
            local saga = require "lspsaga"
            saga.init_lsp_saga()
        end
    }
    use {
        "kosayoda/nvim-lightbulb",
        config = function()
            vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
        end
    }
    use {
        "onsails/lspkind-nvim",
        config = function() require("lspkind").init() end
    }
    use {
        "nvim-lua/completion-nvim",
        config = function()
            vim.g.completion_sorting = "none"

            vim.cmd [[autocmd BufEnter * lua require'completion'.on_attach()]]

            vim.api.nvim_exec([[
					augroup CompletionTriggerCharacter
							autocmd!
							autocmd BufEnter * let completion_enable_auto_popup = 1
							autocmd BufEnter *.lua let completion_enable_auto_popup = 0
					augroup end
				]], false)
        end
    }
    use 'famiu/bufdelete.nvim'

    use {
        "folke/which-key.nvim",
        config = function() require("which-key").setup {} end
    }
    use "marko-cerovac/material.nvim"
    use "euclidianAce/BetterLua.vim"
    use {
        "rcarriga/nvim-dap-ui",
        requires = {"mfussenegger/nvim-dap"},
        config = function() require("dapui").setup() end
    }
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup() end
    }
    use "b3nj5m1n/kommentary"
    use {
        "TimUntersberger/neogit",
        config = function()
            require("neogit").setup {integrations = {diffview = true}}
        end
    }
    use {"tyru/open-browser-github.vim", requires = "tyru/open-browser.vim"}
    use {'iberianpig/tig-explorer.vim', requires = {'rbgrouleff/bclose.vim'}}
    use {

        "phaazon/hop.nvim",
        as = "hop",
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require"hop".setup {keys = "etovxqpdygfblzhckisuran"}
        end
    }
    use {
        "akinsho/nvim-bufferline.lua",
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require("bufferline").setup {} end
    }
    use "simrat39/symbols-outline.nvim"
    use "mg979/vim-visual-multi"
    use {
        'akinsho/flutter-tools.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require("flutter-tools").setup {
                flutter_lookup_cmd = "asdf where flutter",
                debugger = {enabled = true}
            }
            require("telescope").load_extension("flutter")
        end
    }
    use "sheerun/vim-polyglot"
end)

-- vim.cmd("set guicursor=")
vim.o.termguicolors = true

vim.o.pumblend = 15
require("material").set()
require("lualine").setup {options = {theme = "material-nvim"}}

local vimp = require("vimp")

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hidden = true
vim.o.history = 5000

vim.o.tabstop = 2
vim.o.shiftwidth = vim.o.tabstop
vim.g.mapleader = " "

vim.wo.number = true
-- vim.wo.cursorcolumn = true
vim.wo.cursorline = true

vimp.imap("<tab>", "<Plug>(completion_smart_tab)")
vimp.imap("<s-tab>", "<Plug>(completion_smart_s_tab)")

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing message extra message when using completion
vim.o.shortmess = vim.o.shortmess .. "c"

vim.g.timeoutlen = 10

vimp.imap("<c-q>", "<esc>")

vimp.imap({"silent"}, "<c-a>", "<c-o>I")
vimp.imap({"silent"}, "<c-e>", "<c-o>A")
vimp.cmap({"silent"}, "<c-a>", "<home>")
vimp.cmap({"silent"}, "<c-e>", "<end>")
vimp.nmap("<c-a>", "0")
vimp.nmap("<c-e>", "g_")
vimp.vmap("<c-a>", "0")
vimp.vmap("<c-e>", "g_")

vimp.nnoremap("<c-s>", ":update<cr>")
vimp.vnoremap("<c-s>", ":update<cr>")
vimp.inoremap("<c-s>", "<esc>:update<cr>")

vimp.nnoremap("H", "<c-o>")
vimp.nnoremap("L", "<c-i>")
vimp.nnoremap("<c-i>", ":Telescope jumplist<cr>")

vimp.nnoremap({"silent", "nowait"}, "<esc><esc>", ":nohl<cr>")

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

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufEnter * map <buffer> <silent> <s-k> :BufferLineCycleNext<cr>
  augroup end
]], false)
vimp.nnoremap({"silent"}, "J", ":BufferLineCyclePrev<cr>")
vimp.nnoremap("W", "<c-w>w")

local wk = require("which-key")
local telescope = require("telescope.builtin")

wk.register({
    D = {
        function() require("lspsaga.hover").render_hover_doc() end, "definition"
    },
    R = {function() require"lspsaga.provider".lsp_finder() end, "references"},
    f = {function() require"hop".hint_words() end, "hop"},
    F = {":HopChar1<cr>", "hop char1"}
}, {})

vimp.inoremap("<c-f>", [[<c-o><cmd>lua require "hop".hint_words()<cr>]])

local find_files_action = {function() telescope.find_files() end, "find file"}
local find_match_word_action = {
    function() require("telescope.builtin").live_grep() end, "find match word"
}

wk.register({
    [" "] = find_files_action,
    ["/"] = find_match_word_action,
    f = {
        name = "file",
        f = find_files_action,
        r = {
            function() require("telescope.builtin").oldfiles() end,
            "find recent files"
        },
        g = find_match_word_action,
        s = find_match_word_action,
        ["/"] = find_match_word_action,
        w = find_match_word_action,
        c = {function() telescope.commands() end, "find command"}
    },
    q = {
        a = {
            function()
                if (vim.fn.confirm("Quit all?", "Yes\nNo") == 1) then
                    vim.cmd(":qa")
                end
            end, "quit all"
        },
        w = {"<c-w>c", "quit window"},
        q = {":Bdelete<cr>", "quit buffer"}
    },
    g = {
        s = {
            function() require("neogit").open({kind = "split"}) end,
            "neogit status"
        },
        c = {function() require("neogit").open({"commit"}) end, "neogit commit"},
        b = {function() require("neogit").open({"branch"}) end, "neogit branch"},
        l = {function() require("neogit").open({"log"}) end, "neogit log"},
        t = {":Tig<cr>", "tig"},
        g = {":Tig<cr>", "tig"},
        h = {":OpenGithubFile<cr>", "open github"}
    },
    e = {
        e = {":Fern . -reveal=%<cr>", "file explorer"},
        t = {":Fern . -drawer -reveal=% -toggle<cr>", "file tree"}
    },
    b = {
        b = {":NvimTreeToggle<cr>", "file-tree bar"},
        f = {":NvimTreeToggle<cr>", "file-tree bar"},
        s = {":SymbolsOutline<cr>", "symbols-outline bar"}
    },
    m = {
        function()
            if vim.o.mouse ~= "a" then
                vim.o.mouse = "a"
            else
                vim.o.mouse = ""
            end
        end, "mouse toggle"
    },
    t = {
        m = {
            function()
                if vim.o.mouse ~= "a" then
                    vim.o.mouse = "a"
                else
                    vim.o.mouse = ""
                end
            end, "mouse toggle"
        }
    },
    ["."] = {
        function() require("lspsaga.codeaction").code_action() end, "lsp action"
    }
}, {prefix = "<leader>"})

wk.register({
    d = {function() vim.lsp.buf.definition() end, "go to definition"},
    r = {
        function() require"lspsaga.provider".lsp_finder() end, "show reference"
    },
    k = {"gg", "go to top"},
    j = {"G", "go to bottom"}
}, {prefix = "g"})

vim.api.nvim_exec([[
		augroup fern-settings
		autocmd!
		autocmd FileType fern nmap <silent> <buffer> H <Plug>(fern-action-preview:toggle)
		augroup END
	]], false)

vim.api.nvim_exec([[
		if executable('fcitx')
			 autocmd InsertLeave * :call system('fcitx-remote -c')
			 autocmd CmdlineLeave * :call system('fcitx-remote -c')
		endif
	]], false)
