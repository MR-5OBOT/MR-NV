-- ===============================
-- Mason installs language servers; the tool installer handles non-LSP tools.
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
				ensure_installed = { "basedpyright", "ruff", "lua_ls", "bashls", "ts_ls", "tinymist" },

				-- Disable automatic enabling/setup of installed servers
				automatic_enable = false,
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			-- These are formatters/debuggers, not LSP servers.
			ensure_installed = { "stylua", "prettier", "shfmt", "debugpy" },
			auto_update = false,
			run_on_start = true,
			start_delay = 3000,
			debounce_hours = 24,
		},
	},
}
