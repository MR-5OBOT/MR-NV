return {
  "williamboman/mason.nvim",
  dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  config = function()
    -- Standard Mason settings with required fields
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      install_root_dir = vim.fn.stdpath("data") .. "/mason",
      PATH = "prepend",
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    })

    -- Install LSP servers and formatters
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- LSP servers
        -- "pyright",
        -- "lua_ls",
        -- "ts_ls",
        -- "html",
        -- "cssls",
        -- Formatters
        "prettier",
        "black",
        "isort",
        "stylua",
        "shfmt",
      },
      auto_update = true,
      run_on_start = true,
    })
  end,
}
