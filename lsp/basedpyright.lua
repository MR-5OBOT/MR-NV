-- npm install -g basedpyright
return {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_dir = function(bufnr, on_dir)
		local markers = { { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile" }, ".git" }
		on_dir(vim.fs.root(bufnr, markers) or vim.fn.getcwd())
	end,
	settings = {
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
				typeCheckingMode = "basic",
				autoImportCompletions = true,
				autoFormatStrings = true,
				inlayHints = {
					variableTypes = true,
					callArgumentNames = true,
					functionReturnTypes = true,
					genericTypes = true,
				},
			},
		},
	},
}
