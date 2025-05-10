return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "lua_ls",
                    "html",
                    "cssls",
                    "pylsp",
                },
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        -- dependencies = { "j-hui/fidget.nvim" },
        config = function()
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
                keymap("n", "<leader>e", vim.diagnostic.open_float, opts)
                keymap("n", "<leader>q", vim.diagnostic.setloclist, opts)
            end

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

            for _, server in ipairs({ "bashls", "cssls", "html", "pylsp" }) do
                lspconfig[server].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                float = { border = "rounded" },
            })
        end,
    },
}
