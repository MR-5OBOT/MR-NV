return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local actions = require('telescope.actions')
        require('telescope').setup({
            defaults = {
                file_ignore_patterns = { '.git/', 'node_modules/', '.DS_Store' },
                layout_config = {
                    horizontal = {
                        prompt_position = 'top',
                        preview_width = 0.6,
                    },
                },
                mappings = {
                    i = {
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<esc>'] = actions.close,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    find_command = { 'rg', '--files', '--hidden', '--ignore', '--glob', '!.git/*' },
                },
            },
            extensions = {
                fzf = {},
            },
        })

        -- Load fzf extension
        require('telescope').load_extension('fzf')

        -- Keymaps
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<space>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        -- vim.keymap.set('n', '<space>fb', builtin.buffers, { desc = 'Telescope buffers' })

        vim.keymap.set('n', '<space>fg', function()
            local opts = require('telescope.themes').get_cursor()
            builtin.live_grep(opts)
        end, { desc = 'Telescope live grep' })

        -- vim.keymap.set('n', '<space>fd', builtin.diagnostics, { desc = 'Telescope diagnostics' })
        -- vim.keymap.set('n', '<space>fr', builtin.oldfiles, { desc = 'Telescope recent files' })
        -- vim.keymap.set('n', '<space>ft', builtin.treesitter, { desc = 'Telescope treesitter' })
        vim.keymap.set('n', '<space>,', builtin.buffers, { desc = 'Telescope buffers' })

        -- Git-related pickers
        -- vim.keymap.set('n', '<space>fgb', builtin.git_branches, { desc = 'Telescope git branches' })
        -- vim.keymap.set('n', '<space>fgc', builtin.git_commits, { desc = 'Telescope git commits' })
        -- vim.keymap.set('n', '<space>fgs', builtin.git_status, { desc = 'Telescope git status' })
    end,
}
