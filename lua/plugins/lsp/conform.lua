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
        python = { "black", "isort" },
        lua = { "stylua" },
        sh = { "shfmt" },
        ["*"] = { "trim_whitespace" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = false,
      },
      formatters = {
        black = { prepend_args = { "--line-length", "120" } },
        isort = { prepend_args = { "--profile", "black" } },
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
