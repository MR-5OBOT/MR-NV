return {
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            local mason_tool_installer = require("mason-tool-installer")

            -- Configure Mason
            mason.setup({
                pip = {
                    upgrade_pip = true,
                },
            })

            -- ✅ Only LSP servers should be here
            mason_lspconfig.setup({
                ensure_installed = {
                    "ts_ls",
                    "html",
                    "ruff", -- ✅ Corrected from "ruff-lsp"
                    "cssls",
                    "pyright",
                    "lua_ls",
                },
                automatic_installation = true,
            })

            -- ✅ Formatters & linters belong here, NOT in mason-lspconfig
            mason_tool_installer.setup({
                ensure_installed = {
                    "prettier",
                    "stylua",
                    "black",
                    "isort",
                    "eslint_d",
                    "flake8",
                    "debugpy", -- Ensuring debugpy is installed
                },
                auto_update = true,
                run_on_start = true,
            })
        end,
    },
}
