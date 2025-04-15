return {
	"nvimdev/lspsaga.nvim",
	event = "LspAttach",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("lspsaga").setup({
			ui = { border = "rounded", code_action = "💡" },
			lightbulb = { enable = true, sign = true, virtual_text = true },
			outline = { win_position = "right", win_width = 30, auto_preview = true },
			symbol_in_winbar = {
				enable = true, -- Enable winbar breadcrumbs
				separator = " > ", -- Separator like barbecue
				hide_keyword = true, -- Hide redundant keywords
				show_file = false, -- Don't show filename
				color_mode = true, -- Use colors for icons
				respect_root = true, -- Respect LSP root
			},
		})
	end,
}
