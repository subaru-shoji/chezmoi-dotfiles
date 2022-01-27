return {
    {
        "akinsho/flutter-tools.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        config = function()
            require("flutter-tools").setup {
                flutter_lookup_cmd = "asdf where flutter"
            }
        end
    }
}
