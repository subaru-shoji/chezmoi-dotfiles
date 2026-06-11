return {
	-- AI CLI (Claude Code etc.) integration.
	-- With the tmux mux backend, AI sessions run as tmux sessions: they survive
	-- closing neovim, and can be attached from plain tmux as well.
	{
		"folke/sidekick.nvim",
		opts = {
			-- NES (next edit suggestions) needs the Copilot LSP server
			nes = { enabled = false },
			cli = {
				mux = {
					backend = "tmux",
					enabled = true,
				},
			},
		},
		-- stylua: ignore
		keys = {
			{ "<leader>a", function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end, desc = "Claude (toggle)" },
			{ "<leader>a", function() require("sidekick.cli").send({ msg = "{selection}" }) end, mode = "x", desc = "Send Selection to AI" },
			{ "<c-.>", function() require("sidekick.cli").focus() end, mode = { "n", "t", "i", "x" }, desc = "Sidekick Focus" },
			{ ",aa", function() require("sidekick.cli").toggle({ focus = true }) end, desc = "Toggle CLI" },
			{ ",as", function() require("sidekick.cli").select() end, desc = "Select CLI" },
			{ ",ad", function() require("sidekick.cli").close() end, desc = "Detach CLI Session" },
			{ ",at", function() require("sidekick.cli").send({ msg = "{this}" }) end, mode = { "n", "x" }, desc = "Send This (function/word)" },
			{ ",af", function() require("sidekick.cli").send({ msg = "{file}" }) end, desc = "Send File" },
			{ ",av", function() require("sidekick.cli").send({ msg = "{selection}" }) end, mode = "x", desc = "Send Selection" },
			{ ",ap", function() require("sidekick.cli").prompt() end, mode = { "n", "x" }, desc = "Select Prompt" },
		},
	},

	-- send picked files to the AI CLI with <a-a> inside snacks pickers
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				actions = {
					sidekick_send = function(...)
						return require("sidekick.cli.picker.snacks").send(...)
					end,
				},
				win = {
					input = {
						keys = {
							["<a-a>"] = { "sidekick_send", mode = { "n", "i" } },
						},
					},
				},
			},
		},
	},
}
