return {
    {
        "sheerun/vim-polyglot",
        setup = function()
            vim.g.polyglot_disabled = {"rs", "elm", "ts", "dart"}
        end
    }
}

