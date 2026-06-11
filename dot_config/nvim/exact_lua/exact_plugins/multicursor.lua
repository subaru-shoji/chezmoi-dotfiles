return {
	-- multiple cursors: <c-d> adds a cursor at the next match (VSCode ctrl+d)
	{
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
		event = "VeryLazy",
		config = function()
			local mc = require("multicursor-nvim")
			mc.setup()

			local set = vim.keymap.set

			-- add a cursor at the next match of the cursor word / visual selection
			-- stylua: ignore start
			set({ "n", "x" }, "<c-d>", function() mc.matchAddCursor(1) end, { desc = "Add Cursor at Next Match" })
			set({ "n", "x" }, "<c-up>", function() mc.lineAddCursor(-1) end, { desc = "Add Cursor Above" })
			set({ "n", "x" }, "<c-down>", function() mc.lineAddCursor(1) end, { desc = "Add Cursor Below" })
			-- stylua: ignore end
			set({ "n", "x" }, "<c-q>", mc.toggleCursor, { desc = "Toggle/Disable Cursors" })

			-- add and remove cursors with control + left click
			set("n", "<c-leftmouse>", mc.handleMouse)
			set("n", "<c-leftdrag>", mc.handleMouseDrag)
			set("n", "<c-leftrelease>", mc.handleMouseRelease)

			-- insert/append for each line of visual selections (superset of block I/A)
			set("x", "I", mc.insertVisual, { desc = "Insert at Selection Starts" })
			set("x", "A", mc.appendVisual, { desc = "Append at Selection Ends" })

			-- less frequent actions under the ,m group
			set({ "n", "x" }, ",mA", mc.matchAllAddCursors, { desc = "Add Cursors to All Matches" })
			set("n", ",ma", mc.alignCursors, { desc = "Align Cursor Columns" })
			set("n", ",mr", mc.restoreCursors, { desc = "Restore Cleared Cursors" })
			set("x", ",ms", mc.splitCursors, { desc = "Split Selections by Regex" })
			set("x", ",mm", mc.matchCursors, { desc = "Match Cursors in Selections by Regex" })

			-- these only apply while multiple cursors exist
			mc.addKeymapLayer(function(layerSet)
				-- stylua: ignore
				layerSet({ "n", "x" }, "q", function() mc.matchSkipCursor(1) end, { desc = "Skip Match" })
				layerSet({ "n", "x" }, "<left>", mc.prevCursor, { desc = "Previous Cursor" })
				layerSet({ "n", "x" }, "<right>", mc.nextCursor, { desc = "Next Cursor" })
				layerSet({ "n", "x" }, ",mx", mc.deleteCursor, { desc = "Delete Main Cursor" })
				layerSet("n", "<esc>", function()
					if not mc.cursorsEnabled() then
						mc.enableCursors()
					else
						mc.clearCursors()
					end
				end, { desc = "Enable/Clear Cursors" })
			end)
		end,
	},
}
