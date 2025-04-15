return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
            local lspconfig = require("lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            vim.diagnostic.config({
                virtual_text = { prefix = "●", source = "if_many" },
                float = { source = "always", border = "rounded" },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            local function set_keymaps(bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                local keymaps = {
                    ["K"] = vim.lsp.buf.hover,
                    ["[d"] = function() vim.diagnostic.goto_prev({ float = { border = "rounded" } }) end,
                    ["]d"] = function() vim.diagnostic.goto_next({ float = { border = "rounded" } }) end,
                }

                local diagnostics_enabled = true
                vim.keymap.set("n", "<leader>dx", function()
                    diagnostics_enabled = not diagnostics_enabled
                    if diagnostics_enabled then
                        vim.diagnostic.enable()
                        print("🔔 Diagnostics Enabled")
                    else
                        vim.diagnostic.disable()
                        print("🔕 Diagnostics Disabled")
                    end
                end, { desc = "Toggle LSP Diagnostics" })

                for k, v in pairs(keymaps) do
                    vim.keymap.set("n", k, v, opts)
                end
            end

            local function on_attach(client, bufnr)
                set_keymaps(bufnr)

                -- Disable formatting from LSPs we let null-ls handle
                if client.name == "pyright" or client.name == "tsserver" then
                    client.server_capabilities.documentFormattingProvider = false
                end

                if client.server_capabilities.documentFormattingProvider then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = true })
                        end,
                    })
                end
            end

            local capabilities = cmp_nvim_lsp.default_capabilities()

            local servers = {
                pyright = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            diagnostics = { globals = { "vim" } },
                            workspace = { library = { vim.fn.stdpath("config") .. "/lua" } },
                        },
                    },
                },
                tsserver = {},
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
    },
}
