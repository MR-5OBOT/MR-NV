return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
		"stevearc/conform.nvim", -- Added for formatting
	},
	config = function()
		-- Mason setup with automatic installation
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				-- LSP Servers
				"lua_ls", -- Lua
				"pylsp", -- Python
			},
			automatic_installation = true,
			handlers = {
				-- This will override the default handler for lua_ls
				lua_ls = function()
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = server_settings.lua_ls.settings,
					})
				end,
				-- Default handler for other servers
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Formatters & Linters
				"stylua", -- Lua formatter
				"luacheck", -- Lua linter
				"ruff", -- Python linter and formatter
			},
			auto_update = true,
			run_on_start = true,
		})

		-- Conform.nvim setup for formatting
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "ruff_organize_imports" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters = {
				ruff_format = {
					command = "ruff",
					args = { "format", "--stdin-filename", "$FILENAME", "-" },
					stdin = true,
				},
				ruff_organize_imports = {
					command = "ruff",
					args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME", "-" },
					stdin = true,
				},
			},
		})

		-- Diagnostics configuration
		vim.diagnostic.config({
			virtual_text = true,
			float = {
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
				focusable = false,
				scope = "line",
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "",
				},
			},
			update_in_insert = false,
			severity_sort = true,
		})

		-- LSP capabilities with nvim-cmp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Generic on_attach function
		local on_attach = function(client, bufnr)
			-- Enable inlay hints if available
			if client.supports_method("textDocument/inlayHint") then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end

		-- Server-specific settings
		local server_settings = {
			-- Lua LSP settings
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							globals = { "vim" },
							disable = { "missing-fields" },
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME .. "/lua",
								"${3rd}/luv/library",
								vim.fn.stdpath("config") .. "/lua",
							},
						},
						telemetry = { enable = false },
						hint = {
							enable = true,
							arrayIndex = "Enable",
							setType = true,
							paramName = "All",
							paramType = true,
							semicolon = "Enable",
						},
					},
				},
			},
			-- Python LSP settings
			pylsp = {
				settings = {
					pylsp = {
						plugins = {
							-- Code completion and intelligence
							jedi = {
								enabled = true,
								completion = { enabled = true },
								diagnostics = { enabled = true },
								hover = { enabled = true },
								references = { enabled = true },
								rename = { enabled = true },
								signature_help = { enabled = true },
								symbols = { enabled = true },
							},
							-- Disable other linters/formatters since we're using ruff
							pylint = { enabled = false },
							pyflakes = { enabled = false },
							pycodestyle = { enabled = false },
							black = { enabled = false },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							-- Imports
							rope_autoimport = { enabled = true },
							rope_completion = { enabled = true },
							-- Ruff for linting
							ruff = {
								enabled = true,
								formatEnabled = false, -- Let conform.nvim handle formatting
								lineLength = 120,
								select = {
									"E",
									"F",
									"W",
									"I",
									"N",
									"D",
									"UP",
									"YTT",
									"AS",
									"B",
									"A",
									"COM",
									"C4",
									"EXE",
									"ISC",
									"INP",
									"PIE",
									"PT",
									"Q",
									"RSE",
									"RET",
									"SLF",
									"SIM",
									"TID",
									"TCH",
									"ARG",
									"PTH",
									"PD",
									"PGH",
									"PL",
									"TRY",
									"NPY",
									"PERF",
								},
								extendSelect = { "C90" },
								ignore = { "D203", "D213" },
							},
						},
					},
				},
			},
		}

		-- Setup LSP servers
		local lspconfig = require("lspconfig")
		for server, config in pairs(server_settings) do
			if server ~= "lua_ls" then -- Skip lua_ls as it's handled by the handler
				lspconfig[server].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = config.settings,
				})
			end
		end

		-- Enhanced keybindings
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
			callback = function(args)
				local opts = { buffer = args.buf, noremap = true, silent = true }

				-- Navigation
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

				-- Documentation
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

				-- Code actions
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>f", function()
					require("conform").format({ async = true, lsp_fallback = true })
				end, opts)

				-- Diagnostics
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "<leader>ds", function()
					vim.diagnostic.setloclist({ open = true })
				end, opts)

				-- Workspace
				vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)

				-- Toggle inlay hints
				vim.keymap.set("n", "<leader>ih", function()
					local bufnr = args.buf
					local current_state = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
					vim.lsp.inlay_hint.enable(not current_state, { bufnr = bufnr })
				end, opts)
			end,
		})
		-- Enable file watching
		vim.lsp.set_log_level("ERROR") -- Optional: for better debugging
		vim.lsp.buf.document_highlight() -- Enable document highlighting
	end,
}
