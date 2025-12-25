return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	config = true,
	"williamboman/mason-lspconfig.nvim",
	opts = {
		ensure_installed = { "basedpyright", "ruff", "lua_ls" }, -- changed to basedpyright and added ruff
		automatic_installation = true,
	},
}
