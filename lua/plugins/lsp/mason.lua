-- ===============================
-- Mason installs language servers; the tool installer handles non-LSP tools.
-- ===============================
local function has(exe)
	return function()
		return vim.fn.executable(exe) == 1
	end
end

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
			-- Formatters, not LSP servers. (`tree-sitter-cli` is deliberately
			-- not here -- lua/plugins/treesitter.lua installs it itself, so it
			-- is not held back by the debounce below.)
			ensure_installed = {
				"stylua",
				"shfmt",
				{ "prettier", condition = has("node") },
			},
			auto_update = false,
			run_on_start = true,
			start_delay = 3000,
			debounce_hours = 24,
		},
	},
}
