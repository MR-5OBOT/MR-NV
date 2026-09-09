return {
	"rachartier/tiny-cmdline.nvim",
	init = function()
		vim.o.cmdheight = 0
		require("vim._core.ui2").enable({})
	end,
	opts = {
		width = { value = "25%" },
		border = "single",
		native_types = {},
	},
}
