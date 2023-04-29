return {
    {
        "TimUntersberger/neogit",
        config = function()
            require("neogit").setup({integrations = {diffview = true}})
        end
    }, {"tyru/open-browser-github.vim", dependencies = "tyru/open-browser.vim"},
    {"iberianpig/tig-explorer.vim", dependencies = {"rbgrouleff/bclose.vim"}},
    {"emmanueltouzery/agitator.nvim"}, {
        "lewis6991/gitsigns.nvim",
        dependencies = {'nvim-lua/plenary.nvim'},
        config = function() require('gitsigns').setup() end
    }, {"kdheepak/lazygit.nvim"}
}
