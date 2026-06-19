return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				javascript = { "prettier", stop_after_first = true },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			notify_on_error = true,
		})
	end,
}
