-- ===============================
-- Mason + LSP auto-install
-- ===============================
return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "pyright", "ruff", "lua_ls", "bashls" },
				automatic_installation = true,
			})
		end,
	},
}
