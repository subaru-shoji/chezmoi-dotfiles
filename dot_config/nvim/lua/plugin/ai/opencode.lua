return {
	"NickvanDyke/opencode.nvim",
	dependencies = {
		-- Recommended for better prompt input, and required to use opencode.nvim's embedded terminal — otherwise optional
		{ "folke/snacks.nvim", opts = { input = { enabled = true } } },
	},
	---@type opencode.Opts
	opts = {
		-- Your configuration, if any — see lua/opencode/config.lua
	},
	keys = {
		-- Recommended keymaps
		{
			",oA",
			function()
				require("opencode").ask()
			end,
			desc = "Ask opencode",
		},
		{
			",oa",
			function()
				require("opencode").ask("@cursor: ")
			end,
			desc = "Ask opencode about this",
			mode = "n",
		},
		{
			",oa",
			function()
				require("opencode").ask("@selection: ")
			end,
			desc = "Ask opencode about selection",
			mode = "v",
		},
		{
			",ot",
			function()
				require("opencode").toggle()
			end,
			desc = "Toggle embedded opencode",
		},
		{
			",on",
			function()
				require("opencode").command("session_new")
			end,
			desc = "New session",
		},
		{
			",oy",
			function()
				require("opencode").command("messages_copy")
			end,
			desc = "Copy last message",
		},
		{
			"<S-C-u>",
			function()
				require("opencode").command("messages_half_page_up")
			end,
			desc = "Scroll messages up",
		},
		{
			"<S-C-d>",
			function()
				require("opencode").command("messages_half_page_down")
			end,
			desc = "Scroll messages down",
		},
		{
			",op",
			function()
				require("opencode").select_prompt()
			end,
			desc = "Select prompt",
			mode = { "n", "v" },
		},
		-- Example: keymap for custom prompt
		{
			",oe",
			function()
				require("opencode").prompt("Explain @cursor and its context")
			end,
			desc = "Explain code near cursor",
		},
	},
}
