return {
	"stevearc/conform.nvim",
	config = function()
		vim.g.disable_autoformat = false
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua", stop_after_first = true },
				python = { "black" },
				javascript = { "prettier", stop_after_first = true },
				html = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
				css = { "prettier", stop_after_first = true },
			},
			formatters = {
				black = {
					args = { "--line-length", "130", "$FILENAME" },
					stdin = false, -- Pass filename instead of stdin
				},
			},
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat then
					return
				end
				return {
					timeout_ms = 500,
					lsp_format = "fallback",
				}
			end,
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				if vim.g.disable_autoformat then
					return
				end
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
