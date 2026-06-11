return {
	-- multiple cursors: <c-d> starts hydra-based multicursor mode with key hints
	-- (n/N add match, q/Q skip, <c-a> all, i/a/c/e edit modes, <esc> quit)
	{
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = { "nvimtools/hydra.nvim" },
		opts = {},
		cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
		keys = {
			{
				mode = { "v", "n" },
				"<c-d>",
				"<cmd>MCstart<cr>",
				desc = "Multicursor (word/selection)",
			},
		},
	},
}
