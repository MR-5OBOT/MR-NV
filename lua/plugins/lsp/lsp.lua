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

				-- Enable Inlay Hints if the server supports them
				if client.supports_method("textDocument/inlayHint") then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
			end

			-- Lua LSP
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			lspconfig.basedpyright.setup({
				on_attach = on_attach,
				settings = {
					basedpyright = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace", -- or "openFilesOnly" for large projects
							typeCheckingMode = "basic", -- change to "strict" if you want more rigor
							autoImportCompletions = true,
							autoFormatStrings = true,
							disableOrganizeImports = true,

							-- If you want to disable specific reports:
							diagnosticSeverityOverrides = {
								reportAssignmentType = false,
								reportUnusedVariable = false,
								reportArgumentType = false,
								reportUnusedImport = false,
							},

							inlayHints = {
								variableTypes = true,
								callArgumentNames = true,
								functionReturnTypes = true,
								genericTypes = true,
								callArgumentNamesMatching = true,
							},
						},
					},
				},
			})

			lspconfig.ruff.setup({
				on_attach = function(client, bufnr)
					-- Optional: disable Ruff hover if you prefer basedpyright's
					client.server_capabilities.hoverProvider = false
					on_attach(client, bufnr) -- keep your shared keymaps
				end,
			})
		end,
	},
}
