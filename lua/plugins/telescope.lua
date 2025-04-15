return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { 'kdheepak/lazygit.nvim' }, -- Added LazyGit dependency
    },
    config = function()
        local actions = require('telescope.actions')
        require('telescope').setup({
            defaults = {
                file_ignore_patterns = { '^.git/', '^node_modules/', '^.DS_Store', '%.lock', '^env/', '^.env/' },
                sorting_strategy = 'ascending',
                layout_strategy = 'horizontal',
                layout_config = {
                    horizontal = {
                        prompt_position = 'top',
                        width = 0.9,
                        height = 0.8,
                        preview_width = 0.5, -- Equal width for search and preview
                    },
                },
                borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                prompt_prefix = ' ',
                selection_caret = '➤ ',
                mappings = {
                    i = {
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<esc>'] = actions.close,
                        ['<C-c>'] = actions.close,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    find_command = {
                        'rg',
                        '--files',
                        '--hidden',
                        '--no-ignore-vcs',
                        '--glob',
                        '!{.git,node_modules,dist,build,.venv}/*',
                    },
                },
                live_grep = {
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case',
                        '--hidden',
                        '--glob',
                        '!{.git,node_modules,dist,build,.venv}/*',
                    },
                },
                buffers = {
                    sort_lastused = true,
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = 'smart_case',
                },
            },
        })

        require('telescope').load_extension('fzf')

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help Tags' })
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Diagnostics' })
        vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Fuzzy Find in Buffer' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })
        vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Commands' })

        -- LazyGit keymaps
        vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'Open LazyGit' })
    end,
}
