return {
	-- Set the default style for monochrome
	{
		"kdheepak/monochrome.nvim",
		config = function()
			vim.g.monochrome_style = "amplified"
			vim.cmd("colorscheme monochrome")
		end,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		-- lazy = false,
		-- priority = 999, -- Load before other plugins
		config = function()
			-- vim.cmd.colorscheme("oxocarbon") -- Set oxocarbon as default
			vim.opt.background = "dark" -- Ensure dark mode
		end,
	},
	{
		"Mofiqul/adwaita.nvim",
		lazy = false,
		priority = 1000,

		-- configure and set on startup
		config = function()
			vim.g.adwaita_darker = true -- for darker version
			vim.g.adwaita_disable_cursorline = false -- to disable cursorline
			vim.g.adwaita_transparent = true -- makes the background transparent
			-- vim.cmd("colorscheme adwaita")
		end,
	},
}
