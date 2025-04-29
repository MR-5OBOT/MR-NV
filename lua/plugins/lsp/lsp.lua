-- LSP Configuration
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- LSP Support
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- Formatting
    "stevearc/conform.nvim",
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
  },
  config = function()
    -- Mason setup for managing LSP servers
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "basedpyright", -- Replaced pyright with basedpyright
        "ruff", -- Added for linting and formatting
        "bashls",
        "html",
        "cssls",
        "ts_ls",
      },
    })
    -- Ensure formatters and linters are installed
    require("mason-tool-installer").setup({
      ensure_installed = {
        "stylua",
        "ruff", -- Replaced black, isort, shfmt, prettier
      },
      auto_update = true,
      run_on_start = true,
    })

    -- LSP capabilities for autocompletion
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Floating diagnostics configuration
    vim.diagnostic.config({
      virtual_text = true,
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
        focusable = false,
        scope = "cursor",
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.INFO] = "",
          [vim.diagnostic.severity.HINT] = "",
        },
      },
    })

    -- LSP server configurations
    local lspconfig = require("lspconfig")
    local servers = { "lua_ls", "basedpyright", "ruff", "bashls", "html", "cssls", "ts_ls" }
    for _, lsp in ipairs(servers) do
      local lsp_settings = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Enable inlay hints if supported
          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
          -- Disable formatting for basedpyright to avoid conflicts with ruff
          if lsp == "basedpyright" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
        end,
      }

      if lsp == "lua_ls" then
        lsp_settings.settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            hint = { enable = true },
          },
        }
      elseif lsp == "basedpyright" then
        lsp_settings.settings = {
          basedpyright = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly", -- Faster for large projects
              inlayHints = {
                variableTypes = true,
                functionReturnTypes = true,
                callArgumentNames = true,
              },
              typeCheckingMode = "standard", -- Balanced type checking
            },
          },
        }
      elseif lsp == "ruff" then
        lsp_settings.on_attach = function(client, bufnr)
          -- Disable hover to defer to basedpyright
          client.server_capabilities.hoverProvider = false
          -- Enable inlay hints if supported
          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end
      elseif lsp == "html" then
        lsp_settings.settings = {
          html = { inlayHints = true },
        }
      elseif lsp == "cssls" then
        lsp_settings.settings = {
          css = { lint = { unknownAtRules = "ignore" }, inlayHints = true },
        }
      elseif lsp == "ts_ls" then
        lsp_settings.settings = {
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
        }
      end

      lspconfig[lsp].setup(lsp_settings)
    end

    -- Keybindings for LSP
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
      end,
    })
  end,
}
