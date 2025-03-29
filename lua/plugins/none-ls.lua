return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "williamboman/mason.nvim",
            "jay-babu/mason-null-ls.nvim",
        },
        config = function()
            local null_ls = require("null-ls")
            local mason_null_ls = require("mason-null-ls")

            mason_null_ls.setup({
                ensure_installed = {
                    "prettier", -- ✅ Formatter
                    "black", -- ✅ Python formatter
                    "stylua", -- ✅ Lua formatter
                    "shfmt", -- ✅ Shell formatter
                    "eslint_d", -- ✅ Linter for JavaScript & TypeScript
                    "flake8", -- ✅ Python linter
                },
            })

            local function skip_large_files()
                local file_path = vim.api.nvim_buf_get_name(0)
                return vim.fn.getfsize(file_path) < 100000 -- Skip files larger than 100KB
            end

            null_ls.setup({
                sources = {
                    -- ✅ Formatters
                    null_ls.builtins.formatting.prettier.with({
                        condition = skip_large_files,
                    }),
                    null_ls.builtins.formatting.black.with({
                        condition = skip_large_files,
                        extra_args = { "--line-length", "135" },
                    }),
                    null_ls.builtins.formatting.stylua.with({
                        condition = skip_large_files,
                        extra_args = { "--line-length", "140" },
                    }),
                    null_ls.builtins.formatting.shfmt.with({
                        condition = skip_large_files,
                    }),
                    null_ls.builtins.formatting.isort.with({
                        condition = skip_large_files,
                    }),
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({
                                    async = false,
                                    filter = function(c)
                                        return c.name == "null-ls"
                                    end,
                                })
                            end,
                        })
                    end
                end,
            })
        end,
    },
}
