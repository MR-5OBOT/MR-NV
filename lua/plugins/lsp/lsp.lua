return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- Shared on_attach for common keymaps + Ruff-specific hover disable
			local on_attach = function(client, bufnr)
				-- Example keymaps (customize or remove as needed)
				local bufmap = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
				bufmap("n", "gr", vim.lsp.buf.references, "Go to references")
				bufmap("n", "K", vim.lsp.buf.hover, "Hover documentation")
				bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
				bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
				bufmap("n", "<leader>f", function()
					vim.lsp.buf.format({ async = true })
				end, "Format")

				-- Disable hover for Ruff to avoid conflict with basedpyright
				if client.name == "ruff" then
					client.server_capabilities.hoverProvider = false
				end
			end

			-- Lua LSP (unchanged)
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			-- Basedpyright (primary LSP)
			lspconfig.basedpyright.setup({
				on_attach = on_attach,
				settings = {
					basedpyright = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace", -- or "openFilesOnly" for large projects
							typeCheckingMode = "recommended", -- change to "strict" if you want more rigor
							autoImportCompletions = true,
							inlayHints = {
								callArgumentNames = true,
								variableTypes = true,
								functionReturnTypes = true,
								genericTypes = true,
							},
						},
					},
				},
			})

			-- Ruff (linter/formatter only)
			lspconfig.ruff.setup({
				on_attach = on_attach,
			})

			-- Bash (unchanged)
			lspconfig.bashls.setup({
				on_attach = on_attach,
			})
		end,
	},
}
