return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	  requires = {
    "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
  },
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = { enabled = false },
			panel = { enabled = false },
		})
	end,
}
