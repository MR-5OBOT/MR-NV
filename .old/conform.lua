return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        python = { "ruff_format", "ruff_organize_imports" },
        lua = { "stylua" },
        sh = { "shfmt" },
        ["*"] = { "trim_whitespace" },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = false,
        sync = true,
      },
      formatters = {
        ruff_format = {
          prepend_args = {
            "--quiet",
            "format",
            "--line-length",
            "120",
          },
        },
        ruff_organize_imports = {
          prepend_args = {
            "--quiet",
          },
        },
        stylua = {
          prepend_args = {
            "--indent-type",
            "Spaces",
            "--indent-width",
            "4",
            "--column-width",
            "130",
          },
        },
      },
    })
  end,
}
