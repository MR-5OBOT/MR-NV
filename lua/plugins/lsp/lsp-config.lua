return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"nvimdev/lspsaga.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Diagnostics configuration
		vim.diagnostic.config({
			virtual_text = { prefix = "●", source = "if_many" },
			float = { source = "always", border = "rounded" },
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		-- Shared on_attach and keymaps
		local function on_attach(client, bufnr)
			-- Disable LSP formatting; none-ls handles it
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false

			-- Enable inlay hints (Neovim 0.10+)
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

			-- Keymaps
			local opts = { buffer = bufnr, silent = true }
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- Default LSP hover
			vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
			vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
			vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)
			-- vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
			vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
			vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
		end

		-- Capabilities for autocompletion
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- LSP server configurations
		local servers = {
			pyright = {
				settings = {
					python = {
						analysis = {
							diagnosticSeverityOverrides = {
								reportLineLength = "none", -- Ignore line length issues
							},
						},
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = { vim.fn.stdpath("config") .. "/lua" } },
						hint = { enable = true },
					},
				},
			},
			ts_ls = {},
			html = {},
			cssls = {},
		}

		for server, config in pairs(servers) do
			lspconfig[server].setup(vim.tbl_deep_extend("force", {
				on_attach = on_attach,
				capabilities = capabilities,
			}, config))
		end
	end,
}
