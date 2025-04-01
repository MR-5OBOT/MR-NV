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
                file_ignore_patterns = { ".git/", "node_modules/", ".DS_Store" }, -- Patterns to ignore
                layout_config = {
                    horizontal = {
                        prompt_position = "top", -- Position of the prompt
                        preview_width = 0.6,     -- Width of the preview window
                        -- results_width = 0.2, -- Width of the results window
                    },
                },
                -- prompt_prefix = "   ", -- Custom prompt prefix
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,     -- Move down in insert mode
                        ["<C-k>"] = actions.move_selection_previous, -- Move up in insert mode
                        ["<esc>"] = actions.close,                   -- Close the picker
                    },
                }
            },
            pickers = {
                find_files = {
                    -- theme = "ivy",
                    hidden = true,                                                                  -- Allow searching hidden files
                    find_command = { 'rg', '--files', '--hidden', '--ignore', '--glob', '!.git/*' } -- Exclude .git files
                },
            },
            extensions = {
                fzf = {}
            },
        }

        -- keymaps
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set("n", "<space>fb", builtin.buffers, { desc = 'Telescope Buffers' })
        vim.keymap.set("n", "<space>fh", builtin.help_tags)

        -- live grep with cursor style
        vim.keymap.set("n", "<space>fg", function()
            local opts = require("telescope.themes").get_cursor()
            require("telescope.builtin").live_grep(opts)
        end)

        -- nvim config dir
        -- vim.keymap.set("n", "<space>fc", function()
        --     local opts = require("telescope.themes").get_ivy({
        --         cwd = vim.fn.stdpath("config")
        --     })
        --     require("telescope.builtin").find_files(opts)
        -- end)
    end,
}
