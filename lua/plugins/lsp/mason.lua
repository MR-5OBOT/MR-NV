return {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "basedpyright", "lua_ls" },
      automatic_installation = true,
    },
    }
