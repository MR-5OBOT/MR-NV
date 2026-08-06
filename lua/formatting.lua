local M = {}

-- User-configurable: filetype -> command arguments (stdin/stdout)
M.formatters = {
	lua = { "stylua", "-" },
	javascript = { "prettier", "--stdin-filepath", "%" },
	typescript = { "prettier", "--stdin-filepath", "%" },
	typescriptreact = { "prettier", "--stdin-filepath", "%" },
	json = { "prettier", "--stdin-filepath", "%" },
}

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		local bufnr = args.buf
		local ft = vim.bo[bufnr].filetype
		local formatter = M.formatters[ft]

		if formatter then
			-- Replace % with actual buffer path for tools that need it
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			local cmd = vim.tbl_map(function(arg)
				return arg == "%" and bufname or arg
			end, formatter)

			local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
			local input = table.concat(lines, "\n")

			local output = vim.system(cmd, { stdin = input, text = true }):wait()

			if output.code == 0 then
				local formatted = vim.split(output.stdout, "\n", { plain = true })
				-- Remove trailing empty line that shell commands often append
				if formatted[#formatted] == "" then
					table.remove(formatted)
				end
				vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted)
			end
		else
			-- No external formatter: try LSP
			for _, cl in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
				if cl:supports_method("textDocument/formatting") then
					vim.lsp.buf.format({ bufnr = bufnr, async = false })
					break
				end
			end
		end
	end,
})

return M
