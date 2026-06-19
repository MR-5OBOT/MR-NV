return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- 1. GLOBAL ATTACH HANDLER
			-- Instead of passing on_attach to every server, we use an autocommand.
			-- This is the modern, more efficient way to handle keymaps and logic.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local bufnr = ev.buf
					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					-- Shared Keymaps
					local bufmap = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
					end

					bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
					bufmap("n", "gr", vim.lsp.buf.references, "Go to references")
					bufmap("n", "K", vim.lsp.buf.hover, "Hover documentation")
					bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
					bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")

					-- Enable Inlay Hints if supported
					if client and client:supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end

					-- Specific logic for Ruff: Disable hover to let Pyright handle it
					if client and client.name == "ruff" then
						client.server_capabilities.hoverProvider = false
					end
				end,
			})

			-- Lua LSP
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
					},
				},
			})
			vim.lsp.enable("lua_ls")

			-- BasedPyright
			vim.lsp.config("basedpyright", {
				settings = {
					basedpyright = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							typeCheckingMode = "basic",
							autoImportCompletions = true,
							autoFormatStrings = true,
							disableOrganizeImports = true,
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
							},
						},
					},
				},
			})
			vim.lsp.enable("basedpyright")

			-- Ruff
			vim.lsp.enable("ruff")
		end,
	},
}
