return {
	{
		"vim-skk/skkeleton",
		config = function()
			function Skkeleton_init()
				vim.fn["skkeleton#config"]({ eggLikeNewline = true })
			end
			vim.cmd([[ autocmd User skkeleton-initialize-pre lua Skkeleton_init() ]])
		end,
	},
}
