local install_path = vim.fn.stdpath("data") ..
                         "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path
    })
end

local tbl = {
    {"wbthomason/packer.nvim"}, {"nvim-lua/plenary.nvim"},
    {"vim-denops/denops.vim"}, {"svermeulen/vimpeccable"}
}

function merge(tbl1, tbl2) for _, t in ipairs(tbl2) do table.insert(tbl1, t) end end

function get_lua_plugin_list()
    local handle = io.popen(
                       "find ~/.config/nvim/lua/plugin -type f -name '*.lua' -printf '%P\n' | xargs -I{} basename {} .lua")
    local result = handle:read("*a")
    handle:close()
    local find_list = vim.split(result, '\n')
    -- remove blank item.
    table.remove(find_list, #find_list)
    return find_list
end

local plugin_list = get_lua_plugin_list()

for _, v in ipairs(plugin_list) do merge(tbl, require("plugin." .. v)) end

require("packer").startup({
    tbl, config = {
        compile_path = vim.fn.stdpath('data') .. '/site/plugin/packer_compiled.lua'
    }
})

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
