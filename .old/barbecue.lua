return {
	"utilyre/barbecue.nvim",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		exclude_filetypes = {
			"dashboard",
			"neo-tree",
			"TelescopePrompt",
			"NvimTree",
			"help",
			"lazy",
			"sh",
			"bash",
			"zsh",
			"fish", -- Shell scripts
			"markdown",
			"md", -- Markdown files
			"text",
			"txt", -- Plain text files
			"gitcommit",
			"gitrebase", -- Git-related buffers
			"json",
			"yaml", -- Data files
			"csv",
			"xml", -- Markup/data files
			"git",
			"hg", -- Version control
			"qf",
			"loclist", -- Quickfix and location list
			"packer", -- Packer buffers
			"fugitive", -- Fugitive buffers (if you're using fugitive plugin)
			"NvimTree",
			"mason", -- Mason and NvimTree
			"conf", -- Configuration files
			"startify", -- Startify buffers
		},
	},
}
