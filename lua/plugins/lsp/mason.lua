-- ===============================
-- Mason + LSP auto-install ONLY (no setup)
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
				ensure_installed = { "basedpyright", "ruff", "lua_ls", "bashls" },

				-- Disable automatic enabling/setup of installed servers
				automatic_enable = false,
			})
		end,
	},
}
