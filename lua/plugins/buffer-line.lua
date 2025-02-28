return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level)
				local icon = level:match("error") and "🔴" or "🟡"
				return " " .. icon .. count
			end,
			mode = "buffers",
			-- indicator = {
			-- 	style = "underline",
			-- },
			-- separator_style = "slant", -- padded_slant, slant, slope, padded_slope, thick, thin
			-- show_buffer_close_icons = false, -- Optional: Show close icons
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					highlight = "Directory",
					separator = true,
					padding = 1,
				},
			},
		},
	},
}
