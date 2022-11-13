return {
    {
        "vim-skk/skkeleton",
        config = function()
            function Skkeleton_init()
                local handle = io.popen(
                                   "ps aux | grep yaskkserv2 | grep -v grep")
                local result = handle:read("*a")
                handle:close()

                if result == "" then
                    os.execute("yaskkserv2 /usr/share/skk/dictionary.yaskkserv2")
                end

                vim.fn["skkeleton#config"]({
                    eggLikeNewline = true,
                    useSkkServer = true
                })
            end
            vim.cmd(
                [[ autocmd User skkeleton-initialize-pre lua Skkeleton_init() ]])

        end

    }
}
