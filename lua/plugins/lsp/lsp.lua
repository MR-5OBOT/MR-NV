return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- "j-hui/fidget.nvim", -- Optional: Uncomment if you want LSP status
			"hrsh7th/cmp-nvim-lsp", -- for capabilities
		},
		lazy = false,
		config = function()
			-- Mason setup
			require("mason").setup()

			-- Formatter & tool installer
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"black",
					"prettier",
				},
				auto_update = false,
				run_on_start = true,
				start_delay = 3000,
			})

			-- LSP servers to install
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"lua_ls",
					"html",
					"cssls",
					-- "pylsp",
					"basedpyright",
				},
			})

			-- Optional: status display
			-- require("fidget").setup({})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			local function on_attach(_, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				local keymap = vim.keymap.set

				keymap("n", "gd", vim.lsp.buf.definition, opts)
				keymap("n", "gD", vim.lsp.buf.declaration, opts)
				keymap("n", "gi", vim.lsp.buf.implementation, opts)
				keymap("n", "gr", vim.lsp.buf.references, opts)
				keymap("n", "K", vim.lsp.buf.hover, opts)
				keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
				keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap("n", "[d", vim.diagnostic.goto_prev, opts)
				keymap("n", "]d", vim.diagnostic.goto_next, opts)
				keymap("n", "<leader>q", vim.diagnostic.setloclist, opts)
			end

			-- Lua LS
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			-- Other LSPs
			for _, server in ipairs({ "bashls", "cssls", "html", "basedpyright" }) do
				lspconfig[server].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end

			-- Diagnostics UI
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				float = { border = "rounded" },
			})
		end,
	},
}
