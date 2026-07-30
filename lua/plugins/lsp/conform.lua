return {
	"stevearc/conform.nvim",
	config = function()
		local prettier = { "prettier", stop_after_first = true }

		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				zsh = { "shfmt" },
				javascript = prettier,
				javascriptreact = prettier,
				typescript = prettier,
				typescriptreact = prettier,
				html = prettier,
				css = prettier,
				json = prettier,
				jsonc = prettier,
				yaml = prettier,
				markdown = prettier,
			},
			format_on_save = {
				timeout_ms = 1000,
				lsp_format = "fallback",
			},
			notify_on_error = true,
		})

		vim.keymap.set("n", "<leader>cf", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, { desc = "Format buffer" })
	end,
}
