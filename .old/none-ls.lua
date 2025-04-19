return {
  "nvimtools/none-ls.nvim",
  event = "BufWritePre",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    local function skip_large_files()
      return vim.fn.getfsize(vim.api.nvim_buf_get_name(0)) < 100000 -- 100KB
    end

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier.with({
          condition = skip_large_files,
        }),
        null_ls.builtins.formatting.black.with({
          condition = skip_large_files,
          extra_args = { "--line-length", "120" },
        }),
        null_ls.builtins.formatting.isort.with({
          condition = skip_large_files,
          extra_args = { "--profile", "black" },
        }),
        null_ls.builtins.formatting.stylua.with({
          condition = skip_large_files,
          extra_args = {
            "--indent-type", "Spaces",
            "--indent-width", "2",
            "--line-endings", "Unix",
            "--quote-style", "AutoPreferDouble",
            "--call-parentheses", "Always",
            "--collapse-simple-statement", "Always",
            "--indent-table", "Auto",
            "--indent-conditional", "AlignThen",
            "--sort-requires",
            "--column-width", "100",
          },
        }),
        null_ls.builtins.formatting.shfmt.with({
          condition = skip_large_files,
        }),
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          local group = vim.api.nvim_create_augroup("LspFormatting", { clear = false })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = group,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, filter = function(c) return c.name == "null-ls" end })
            end,
          })
        end
      end,
    })
  end,
}
