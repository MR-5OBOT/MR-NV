return {
    -- Mason: Manage LSP servers, formatters, and tools
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "nvimtools/none-ls.nvim",
            "jay-babu/mason-null-ls.nvim",
        },
        config = function()
            require("mason").setup({
                pip = { upgrade_pip = true },
            })

            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "lua_ls", "ts_ls", "html", "cssls" },
                automatic_installation = true,
            })

            require("mason-null-ls").setup({
                ensure_installed = { "prettier", "black", "stylua", "shfmt" },
                automatic_installation = true,
            })
        end,
    },

}
