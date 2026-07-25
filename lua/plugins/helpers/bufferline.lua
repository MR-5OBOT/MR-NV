return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	config = function()
		local bufferline = require("bufferline")

		bufferline.setup({
			options = {
				mode = "buffers",
				style_preset = bufferline.style_preset.minimal, -- Keep it clean
				separator_style = "thin", -- Minimalist thin vertical lines
				show_buffer_close_icons = false,
				show_close_icon = false,
				diagnostics = "nvim_lsp", -- Use built-in LSP diagnostics

				-- Performance: Only show diagnostics if there's an error
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or (level:match("warning") and " " or "")
					return " " .. icon .. count
				end,
			},
		})

		-- MONOCHROME HIGHLIGHTS (Matches your Telescope colors)
		local bg_color = "NONE"
		local active_fg = "#FFFFFF"
		local inactive_fg = "#666666"
		local border_color = "#444444"

		vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = active_fg, bg = bg_color, bold = true })
		vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { fg = inactive_fg, bg = bg_color })
		vim.api.nvim_set_hl(0, "BufferLineSeparator", { fg = border_color, bg = bg_color })
		vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { fg = border_color, bg = bg_color })
		vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { fg = active_fg, bg = bg_color })
	end,
}
