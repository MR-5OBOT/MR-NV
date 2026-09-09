return {
	"catgoose/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("colorizer").setup({
			filetypes = {
				"css",
				"scss",
				"sass",
				"html",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"lua",
			},
		})
	end,
}
