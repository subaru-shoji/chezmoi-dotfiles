return {
	{
		"akinsho/nvim-bufferline.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					custom_filter = function(buf_number)
						-- doesn't work
						local filetypes = { "qf", "NvimTree" }
						for filetype in pairs(filetypes) do
							if vim.bo[buf_number].filetype ~= filetype then
								return true
							end
						end
					end,
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "center",
						},
					},
				},
			})
		end,
	},
}
