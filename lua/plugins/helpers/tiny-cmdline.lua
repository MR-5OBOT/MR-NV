return {
	"rachartier/tiny-cmdline.nvim",
	init = function()
		vim.o.cmdheight = 0
		-- Neovim's experimental UI layer. It is a private module, so tolerate
		-- builds where it is absent instead of blowing up at startup.
		pcall(function()
			require("vim._core.ui2").enable({})
		end)
	end,
	opts = {
		width = { value = "25%" },
		border = "single",
		native_types = {},
	},
}
