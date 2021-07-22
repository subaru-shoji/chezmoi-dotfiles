local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  execute "packadd packer.nvim"
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePre init.lua Format
    autocmd BufEnter init.lua PackerInstall
    autocmd BufEnter init.lua PackerCompile
  augroup end
]],
  false
)

vim.cmd [[packadd packer.nvim]]
require("packer").startup(
  function(use)
    use "wbthomason/packer.nvim"
    use "svermeulen/vimpeccable"
    use "norcalli/nvim_utils"
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use {
      "hoob3rt/lualine.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons"
      }
    }
    use {
      "nvim-telescope/telescope.nvim",
      requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
    }
    use {
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons"
      }
    }
    use {
      "lambdalisue/fern.vim",
      setup = function()
        vim.g["fern#renderer"] = "nerdfont"
      end
    }
    use "lambdalisue/nerdfont.vim"
    use "lambdalisue/glyph-palette.vim"
    use "lambdalisue/fern-renderer-nerdfont.vim"
    use "lambdalisue/fern-git-status.vim"
    use "lambdalisue/fern-hijack.vim"

    use {
      "mhartington/formatter.nvim",
      config = function()
        require("formatter").setup {
          filetype = {
            lua = {
              -- luafmt
              function()
                return {
                  exe = "luafmt",
                  args = {"--indent-count", 2, "--stdin"},
                  stdin = true
                }
              end
            }
          }
        }
      end
    }
    use {
      "neovim/nvim-lspconfig",
      config = function()
        require "lspconfig".tsserver.setup {}
      end
    }
    use {
      "kabouzeid/nvim-lspinstall",
      config = function()
        require "lspinstall".setup() -- important

        local servers = require "lspinstall".installed_servers()
        for _, server in pairs(servers) do
          require "lspconfig"[server].setup {}
        end
      end
    }
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
      config = function()
        require("lspkind").init()
      end
    }
    use {
      "nvim-lua/completion-nvim",
      config = function()
        vim.cmd [[autocmd BufEnter * lua require'completion'.on_attach()]]
      end
    }
    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {}
      end
    }
    use "marko-cerovac/material.nvim"
    use "euclidianAce/BetterLua.vim"
    use {
      "tjdevries/nlua.nvim",
      config = function()
        require("nlua.lsp.nvim").setup(require("lspconfig"), {})
      end
    }
    use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}
    use {
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup()
      end
    }
    use "b3nj5m1n/kommentary"
    use "tversteeg/registers.nvim"
    use {
      "TimUntersberger/neogit",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("neogit").setup {}
      end
    }
    use "f-person/git-blame.nvim"
    use "yamatsum/nvim-cursorline"
    use {
      "phaazon/hop.nvim",
      as = "hop",
      config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require "hop".setup {keys = "etovxqpdygfblzhckisuran"}
      end
    }
    use {
      "akinsho/nvim-bufferline.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("bufferline").setup {}
      end
    }
    use "tamago324/nlsp-settings.nvim"
    use "simrat39/symbols-outline.nvim"
    use "mg979/vim-visual-multi"
    use "yuki-yano/fern-preview.vim"
    use "danilamihailov/beacon.nvim"
  end
)

vim.o.termguicolors = true

vim.o.pumblend = 15
require("material").set()
require("lualine").setup {
  options = {
    theme = "material-nvim"
  }
}

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
vim.wo.cursorcolumn = true

vim.cmd("set guicursor=")

-- vimp.inoremap({'expr'}, '<tab>', 'pumvisible() ? "\\<c-n>" : "\\<tab>"')
-- vimp.inoremap({'expr'}, '<s-tab>', 'pumvisible() ? "\\<c-p>" : "\\<tab>"')

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing message extra message when using completion
vim.o.shortmess = vim.o.shortmess .. "c"

vim.g.timeoutlen = 0

vimp.imap("qq", "<esc>")

vimp.imap({"silent"}, "<c-a>", "<c-o>I")
vimp.imap({"silent"}, "<c-e>", "<c-o>A")
vimp.cmap({"silent"}, "<c-a>", "<home>")
vimp.cmap({"silent"}, "<c-e>", "<end>")
vimp.nmap("<c-a>", "0")
vimp.nmap("<c-e>", "$")
vimp.vmap("<c-a>", "0")
vimp.vmap("<c-e>", "$")

vimp.nnoremap("<c-s>", ":update<cr>")
vimp.vnoremap("<c-s>", ":update<cr>")
vimp.inoremap("<c-s>", "<esc>:update<cr>")

vimp.nnoremap("<c-i>", ":Telescope jumplist<cr>")

vimp.nnoremap({"silent"}, "<esc><esc>", ":nohl<cr>")

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

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufEnter * map <buffer> <silent> <s-k> :BufferLineCycleNext<cr>
  augroup end
]],
  false
)
vimp.nnoremap({"silent"}, "J", ":BufferLineCyclePrev<cr>")
vimp.nnoremap("L", "<c-w>w")

local wk = require("which-key")
local telescope = require("telescope.builtin")

wk.register(
  {
    D = {
      function()
        require("lspsaga.hover").render_hover_doc()
      end,
      "definition"
    },
    H = {
      function()
        require("lspsaga.hover").render_hover_doc()
      end,
      "hover"
    },
    R = {
      function()
        require "lspsaga.provider".lsp_finder()
      end,
      "references"
    },
    f = {
      function()
        require "hop".hint_words()
      end,
      "hop"
    },
    F = {
      ":HopChar1<cr>",
      "hop char1"
    },
  },
  {}
)

vimp.inoremap("<c-f>", [[<c-o><cmd>lua require "hop".hint_words()<cr>]])

local find_files_action = {
  function()
    telescope.find_files()
  end,
  "find file"
}

wk.register(
  {
    [" "] = find_files_action,
    f = {
      name = "file",
      f = find_files_action,
      r = {
        function()
          require("telescope.builtin").oldfiles()
        end,
        "find recent files"
      },
      w = {
        function()
          require("telescope.builtin").live_grep()
        end,
        "find match word"
      },
      c = {
        function()
          telescope.commands()
        end,
        "find command"
      }
    },
    q = {
      a = {":qa<cr>", "quit all"},
      w = {"<c-w>c", "quit window"},
      q = {":bdelete<cr>", "quit buffer"}
    },
    g = {},
    y = {'"+y', "yank to clipboard"},
    e = {
      e = {
        ":Fern . -reveal=%<cr>",
        "file explorer"
      },
      t = {
        ":Fern . -drawer -reveal=% -toggle<cr>",
        "file tree"
      }
    },
    b = {
      f = {
        ":NvimTreeToggle<cr>",
        "file-tree bar"
      },
      s = {":SymbolsOutline<cr>", "symbols-outline bar"}
    },
    ["."] = {
      function()
        require("lspsaga.codeaction").code_action()
      end,
      "lsp action"
    }
  },
  {prefix = "<leader>"}
)

wk.register(
  {
    d = {
      function()
        vim.lsp.buf.definition()
      end,
      "go to definition"
    },
    r = {
      function()
        require "lspsaga.provider".lsp_finder()
      end,
      "show reference"
    },
    k = {"gg", "go to top"},
    j = {"G", "go to bottom"}
  },
  {prefix = "g"}
)

vim.api.nvim_exec(
  [[
		augroup fern-settings
		autocmd!
		autocmd FileType fern nmap <silent> <buffer> p <Plug>(fern-action-preview:toggle)
		augroup END
	]],
  false
)

vim.api.nvim_exec(
  [[
		if executable('fcitx')
			 autocmd InsertLeave * :call system('fcitx-remote -c')
			 autocmd CmdlineLeave * :call system('fcitx-remote -c')
		endif
	]],
  false
)
