return {
    {
        "https://gitlab.com/yorickpeterse/nvim-window.git",
        config = function()
            -- firtst char is dummy for adjust.
            require('nvim-window').setup {
                chars = {'a', 's', 'd', 'f', 'z', 'x', 'c', 'v', 'b', 'n'}
            }
        end
    }
}
