return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "BufNewFile" },
  dependencies = { "williamboman/mason.nvim" },
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      python = { "isort", "black" }, -- Ensure isort runs before black
      lua = { "stylua" },
      sh = { "shfmt" },
      ["*"] = { "trim_whitespace" },
    },
    format_on_save = {
      timeout_ms = 2000,
      lsp_format = "fallback", -- Changed to fallback for safety
    },
    formatters = {
      black = {
        prepend_args = { "--line-length", "120" },
      },
      isort = {
        prepend_args = { "--profile", "black" },
      },
      stylua = {
        prepend_args = {
          "--indent-type",
          "Spaces",
          "--indent-width",
          "2",
          "--column-width",
          "100",
        },
      },
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
  end,
}
