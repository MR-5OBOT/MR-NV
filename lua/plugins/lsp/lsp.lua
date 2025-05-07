return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "stevearc/conform.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
  },
  config = function()
    -- Mason setup
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "basedpyright", "ruff", "bashls", "html", "cssls", "ts_ls" },
    })
    require("mason-tool-installer").setup({
      ensure_installed = { "stylua", "ruff" },
      auto_update = true,
      run_on_start = true,
    })

    -- Diagnostics configuration
    vim.diagnostic.config({
      virtual_text = true,
      float = { border = "rounded", source = "always", header = "", prefix = "", focusable = false, scope = "line" },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.INFO] = "",
          [vim.diagnostic.severity.HINT] = "",
        },
      },
    })

    -- LSP capabilities
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Generic on_attach function
    local on_attach = function(client, bufnr)
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
      if client.name == "basedpyright" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      elseif client.name == "ruff" then
        client.server_capabilities.hoverProvider = false
      end
    end

    -- Server-specific settings
    local server_settings = {
      lua_ls = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          hint = { enable = true },
        },
      },
      basedpyright = {
        basedpyright = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "openFilesOnly",
            inlayHints = { variableTypes = true, functionReturnTypes = true, callArgumentNames = true },
            typeCheckingMode = "standard",
            diagnosticSeverityOverrides = {
              reportUnknownParameterType = "warning",
              reportMissingParameterType = "warning",
              reportUnknownArgumentType = "warning",
              reportUnknownLambdaType = "warning",
              reportUnusedFunction = "warning",
              reportUntypedFunctionDecorator = "warning",
              reportDeprecated = "warning",
              reportUninitializedInstanceVariable = "warning",
              reportMissingImports = false,
              reportMissingTypeStubs = false,
              reportUnknownVariableType = false,
              reportUnusedImport = false,
            },
          },
        },
      },
      html = { html = { inlayHints = true } },
      cssls = { css = { lint = { unknownAtRules = "ignore" }, inlayHints = true } },
      ts_ls = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    }

    -- Setup LSP servers
    local lspconfig = require("lspconfig")
    for _, lsp in ipairs({ "lua_ls", "basedpyright", "ruff", "bashls", "html", "cssls", "ts_ls" }) do
      lspconfig[lsp].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = server_settings[lsp] or {},
      })
    end

    -- Keybindings
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", function()
          vim.diagnostic.goto_prev({ float = true })
        end, opts)
        vim.keymap.set("n", "]d", function()
          vim.diagnostic.goto_next({ float = true })
        end, opts)
        vim.keymap.set("n", "<leader>ih", function()
          local bufnr = ev.buf
          local current_state = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
          vim.lsp.inlay_hint.enable(not current_state, { bufnr = bufnr })
        end, opts)
      end,
    })
  end,
}
