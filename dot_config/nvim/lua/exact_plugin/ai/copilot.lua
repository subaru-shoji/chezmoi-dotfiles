return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	requires = {
		"copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
	},
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = false, -- 手動呼び出しのみ
				keymap = {
					accept = false, -- サブモードで制御
					accept_word = false,
					accept_line = false,
					next = false,
					prev = false,
					dismiss = false,
				},
			},
			panel = { enabled = false },
		})
	end,
}
