return {
  "neovim/nvim-lspconfig",
  -- event = { "BufReadPre", "BufNewFile" },
  event = { "BufReadPost", "BufWritePost" }, -- Load after buffer is read
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "folke/neodev.nvim",
  },
  config = function()
    require("neodev").setup()

    local lspconfig = require("lspconfig")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_lsp.default_capabilities()

    vim.diagnostic.config({
      virtual_text = { prefix = "●", spacing = 2 },
      float = { border = "rounded", max_width = 80 },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.INFO] = "",
          [vim.diagnostic.severity.HINT] = "󰌵",
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    local function on_attach(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      if client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
      local opts = { buffer = bufnr, silent = true }
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    end

    local servers = {
      pyright = {
        settings = {
          python = {
            analysis = {
              diagnosticSeverityOverrides = {
                reportLineLength = "none",
              },
            },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = {
                -- Only include specific directories you need
                vim.fn.expand("$VIMRUNTIME/lua"),
                vim.fn.stdpath("config") .. "/lua",
              },
              maxPreload = 1000, -- Limit maximum files to preload
              preloadFileSize = 150,
              checkThirdParty = false,
              ignoreDir = {
                "node_modules",
                ".git",
                "target",
                "build",
                "vendor",
              },
            },
            hint = { enable = true },
          },
        },
      },
      ts_ls = {},
      html = {},
      cssls = {},
    }

    require("mason-lspconfig").setup({
      automatic_installation = true,
      handlers = {
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name] and servers[server_name].settings or {},
          })
        end,
      },
    })
  end,
}
