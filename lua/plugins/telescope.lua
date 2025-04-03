return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local actions = require('telescope.actions')
        require('telescope').setup {
            defaults = {
                file_ignore_patterns = { ".git/", "node_modules/", ".DS_Store" },
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.6,
                    },
                },
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<esc>"] = actions.close,
                    },
                }
            },
            pickers = {
                find_files = {
                    hidden = true,
                    find_command = { 'rg', '--files', '--hidden', '--ignore', '--glob', '!.git/*' }
                },
            },
            extensions = {
                fzf = {}
            },
        }

        -- keymaps for built-in actions
        local builtin = require('telescope.builtin')

        -- Find files, buffers, help tags, and more
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set("n", "<space>fh", builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set("n", "<space>fb", builtin.buffers, { desc = 'Telescope Buffers' })

        vim.keymap.set("n", "<space>fg", function()
            local opts = require("telescope.themes").get_cursor()
            require("telescope.builtin").live_grep(opts)
        end, { desc = 'Telescope live grep' })

        vim.keymap.set("n", "<space>fd", builtin.diagnostics, { desc = 'Telescope diagnostics' })
        vim.keymap.set("n", "<space>fr", builtin.recent_files, { desc = 'Telescope recent files' })
        vim.keymap.set("n", "<space>ft", builtin.treesitter, { desc = 'Telescope Treesitter' })
        vim.keymap.set("n", "<space>,", builtin.buffers, { desc = 'Telescope Buffers' })

        -- Git-related pickers
        vim.keymap.set("n", "<space>fgb", builtin.git_branches, { desc = 'Telescope Git branches' })
        vim.keymap.set("n", "<space>fgc", builtin.git_commits, { desc = 'Telescope Git commits' })
        vim.keymap.set("n", "<space>fgs", builtin.git_status, { desc = 'Telescope Git status' })
    end,
}
