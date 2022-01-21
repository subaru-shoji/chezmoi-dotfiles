return {
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup() end
    }, {"mg979/vim-visual-multi"}, {"machakann/vim-sandwich"}, {

        "lukas-reineke/indent-blankline.nvim",
        config = function()
            vim.g.indent_blankline_filetype_exclude = {"dashboard", "help"}
            vim.opt.list = true
            vim.opt.listchars:append("eol:↴")
            require("indent_blankline").setup({
                show_end_of_line = true,
                space_char_blankline = " "
            })
        end
    }, {
        "luukvbaal/stabilize.nvim",
        config = function() require("stabilize").setup() end
    },
    {
        "numToStr/Comment.nvim",
        config = function() require('Comment').setup() end
    }, {
        "yamatsum/nvim-cursorline",
        config = function() vim.g.cursorline_timeout = 5000 end
    }, {
        "petertriho/nvim-scrollbar",
        config = function()
            local colors = require("tokyonight.colors").setup()

            require("scrollbar").setup({
                handle = {color = colors.bg_highlight},
                marks = {
                    Search = {color = colors.orange},
                    Error = {color = colors.error},
                    Warn = {color = colors.warning},
                    Info = {color = colors.info},
                    Hint = {color = colors.hint},
                    Misc = {color = colors.purple}
                }
            })

        end
    }
}
