return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "stevearc/conform.nvim",
    },
    config = function()
        -- Define server-specific settings
        local server_settings = {
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
            basedpyright = {
                settings = {
                    basedpyright = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "openFilesOnly",
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            },
            ruff = {
                settings = {
                    lineLength = 120,
                    lint = {
                        select = {
                            "E", "F", "W", "I", "N", "D", "UP", "YTT", "AS", "B", "A",
                            "COM", "C4", "EXE", "ISC", "INP", "PIE", "PT", "Q", "RSE",
                            "RET", "SLF", "SIM", "TID", "TCH", "ARG", "PTH", "PD", "PGH",
                            "PL", "TRY", "NPY", "PERF",
                        },
                        extendSelect = { "C90" },
                        ignore = { "D203", "D213" },
                    },
                },
            },
        }

        -- Mason setup
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        -- LSP capabilities with nvim-cmp
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Generic on_attach function
        local on_attach = function(client, bufnr)
            if client.supports_method("textDocument/inlayHint") then
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
        end

        -- Mason-lspconfig setup
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "basedpyright", "ruff" }, -- Removed pylsp
            automatic_installation = false,
            handlers = {
                lua_ls = function()
                    require("lspconfig").lua_ls.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = server_settings.lua_ls.settings,
                        root_dir = vim.fn.getcwd(),
                    })
                end,
                basedpyright = function()
                    require("lspconfig").basedpyright.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = server_settings.basedpyright.settings,
                        root_dir = vim.fn.getcwd(),
                    })
                end,
                ruff = function()
                    require("lspconfig").ruff.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = server_settings.ruff.settings,
                        root_dir = vim.fn.getcwd(),
                    })
                end,
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        root_dir = vim.fn.getcwd(),
                    })
                end,
            },
        })

        -- Mason-tool-installer setup
        require("mason-tool-installer").setup({
            ensure_installed = {
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

        -- Debugging: Set log level to DEBUG temporarily
        vim.lsp.set_log_level("DEBUG")
        vim.lsp.buf.document_highlight() -- Enable document highlighting
    end,
}
