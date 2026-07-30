return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true, -- show signs in the sign column (left)
		numhl = false, -- no number highlight
		linehl = false, -- no line highlight
		word_diff = false, -- no word diff
		current_line_blame = false,
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")
			local map = function(lhs, rhs, desc)
				vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
			end

			map("]h", gitsigns.next_hunk, "Next Git hunk")
			map("[h", gitsigns.prev_hunk, "Previous Git hunk")
			map("<leader>hp", gitsigns.preview_hunk, "Preview Git hunk")
			map("<leader>hb", function()
				gitsigns.blame_line({ full = true })
			end, "Blame line")
		end,
	},
}
