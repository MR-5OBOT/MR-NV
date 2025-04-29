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
        python = { "ruff_format", "ruff_organize_imports" }, -- Replaced black, isort with ruff
        lua = { "stylua" },
        sh = { "shfmt" },
        ["*"] = { "trim_whitespace" },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = false,
        sync = true, -- Ensure synchronous formatting to avoid interruptions
      },
      formatters = {
        ruff_format = {
          prepend_args = { "--quiet" },
        },
        ruff_organize_imports = {},
        stylua = {
          prepend_args = {
            "--indent-type",
            "Spaces",
            "--indent-width",
            "2",
            "--column-width",
            "120",
          },
        },
      },
    })
  end,
}
