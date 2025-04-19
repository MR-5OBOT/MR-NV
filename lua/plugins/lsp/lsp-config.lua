return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_lsp.default_capabilities()

    -- Diagnostics configuration
    vim.diagnostic.config({
      virtual_text = { prefix = "●", spacing = 2 },
      float = { border = "rounded", max_width = 80 },
      signs = { text = { "", "", "", "󰌵" } },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- Shared on_attach
    local function on_attach(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      local opts = { buffer = bufnr }
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    end

    -- LSP servers with minimal settings
    local servers = {
      pyright = {
        settings = {
          python = { analysis = { diagnosticSeverityOverrides = { reportLineLength = "none" } } },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = { vim.fn.stdpath("config") .. "/lua" },
              checkThirdParty = false,
            },
            hint = { enable = true },
          },
        },
      },
      ts_ls = {},
      html = {},
      cssls = {},
    }

    -- Setup servers via mason-lspconfig
    require("mason-lspconfig").setup({
      ensure_installed = { "pyright", "lua_ls", "ts_ls", "html", "cssls" },
      handlers = {
        function(server)
          lspconfig[server].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server] and servers[server].settings or {},
          })
        end,
      },
    })
  end,
}
