return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- define a configuration for an LSP client.
      vim.lsp.config['luals'] = {
        -- Command and arguments to start the server.
        cmd = { 'lua-language-server' },
        -- Filetypes to automatically attach to.
        filetypes = { 'lua' },
        -- Sets the "root directory" to the parent directory of the file in the
        -- current buffer that contains either a ".luarc.json" or a
        -- ".luarc.jsonc" file. Files that share a root directory will reuse
        -- the connection to the same LSP server.
        root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
        -- Specific settings to send to the server. The schema for this is
        -- defined by the server. For example the schema for lua-language-server
        -- can be found here https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            }
          },
          diagnostics = { globals = { "vim" } },
        }
      }
      -- python setup
      vim.lsp.config['basedpyright'] = {
        cmd = { "basedpyright-langserver", "--stdio" },
        filetypes = { 'python' },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
        settings = {
          basedpyright = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              typeCheckingMode = "standard",
              useLibraryCodeForTypes = true,
              inlayHints = {
                callArgumentNames = true,
                variableTypes = true,
                functionReturnTypes = true,
                genericTypes = true,

              },
            }
          }
        },
      }
      -- enable the lsp servers
      vim.lsp.enable('luals')
      vim.lsp.enable('basedpyright')
      vim.lsp.enable('bashls')

      -- Attach to lsp
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          if not client then return end -- do nothing if lsp no attached

          -- Auto-format on save.
          if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })
    end,
  }
}
