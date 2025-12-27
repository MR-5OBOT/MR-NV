return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config["luals"] = {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
					},
					diagnostics = { globals = { "vim" } },
				},
			}
			-- python setup
			vim.lsp.config["basedpyright"] = {
				cmd = { "basedpyright-langserver", "--stdio" },
				filetypes = { "python" },
				root_markers = {
					"pyproject.toml",
					"setup.py",
					"setup.cfg",
					"requirements.txt",
					"Pipfile",
					"pyrightconfig.json",
					".git",
				},
				settings = {
					basedpyright = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "workspace",
							typeCheckingMode = "standard",
							useLibraryCodeForTypes = true,
							inlayHints = {
								callArgumentNames = true,
								variableTypes = true,
								functionReturnTypes = true,
								genericTypes = true,
							},
						},
					},
				},
			}
			-- enable the lsp servers
			vim.lsp.enable("luals")
			vim.lsp.enable("basedpyright")
		end,
	},
}
