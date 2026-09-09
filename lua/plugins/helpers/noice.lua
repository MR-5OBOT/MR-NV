return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		cmdline = { enabled = false },
		messages = { enabled = false },
		popupmenu = { enabled = false },
		presets = { lsp_doc_border = true },
	},
}
