return {
	{
		"kdheepak/monochrome.nvim",
		priority = 1000, -- Load this first
		lazy = false,
		config = function()
			-- Set monochrome style
			vim.g.monochrome_style = "amplified"

			-- Try to set the colorscheme, with error handling
			local ok, _ = pcall(vim.cmd, "colorscheme monochrome")
			if not ok then
				vim.notify(
					"Monochrome colorscheme not found. Please install it with :Lazy install kdheepak/monochrome.nvim",
					vim.log.levels.WARN
				)
			end
		end,
	},
}
