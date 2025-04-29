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
        "lua_ls", -- Lua
        "pyright", -- Python
        "bashls", -- Bash
        "html", -- HTML
        "cssls", -- CSS
        "ts_ls", -- JavaScript/TypeScript
      },
    })
    -- Ensure formatters are installed via mason-tool-installer
    require("mason-tool-installer").setup({
      ensure_installed = {
        "stylua", -- Lua formatter
        "black", -- Python formatter
        "shfmt", -- Bash formatter
        "prettier", -- HTML, CSS, JavaScript, TypeScript formatter
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
        scope = "cursor", -- Show diagnostics for the current cursor position
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "", -- Nerd Font icon for errors
          [vim.diagnostic.severity.WARN] = "", -- Nerd Font icon for warnings
          [vim.diagnostic.severity.INFO] = "", -- Nerd Font icon for info
          [vim.diagnostic.severity.HINT] = "", -- Nerd Font icon for hints
        },
      },
    })

    -- LSP server configurations
    local lspconfig = require("lspconfig")
    local servers = { "lua_ls", "pyright", "bashls", "html", "cssls", "ts_ls" }
    for _, lsp in ipairs(servers) do
      local lsp_settings = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Ensure inlay hints are enabled for this client
          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end,
      }

      if lsp == "lua_ls" then
        lsp_settings.settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- Explicitly ignore vim
            },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            hint = { enable = true }, -- Inlay hints
          },
        }
      elseif lsp == "pyright" then
        lsp_settings.settings = {
          python = {
            analysis = {
              inlayHints = {
                variableTypes = true,
                functionReturnTypes = true,
                callArgumentTypes = true, -- Show parameter type hints
                parameterNames = true, -- Show parameter names in calls
              },
              typeCheckingMode = "basic",
              -- typeCheckingMode = "strict",
              diagnosticMode = "workspace",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticSeverityOverrides = {
                reportUnusedImport = "information", -- or "none" to suppress
              },
            },
          },
        }
      elseif lsp == "bashls" then
        lsp_settings.settings = {
          bashIde = {
            inlayHints = true,
          },
        }
      elseif lsp == "html" then
        lsp_settings.settings = {
          html = {
            inlayHints = true,
          },
        }
      elseif lsp == "cssls" then
        lsp_settings.settings = {
          css = {
            lint = { unknownAtRules = "ignore" },
            inlayHints = true,
          },
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
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- Manual diagnostics float
      end,
    })
  end,
}
