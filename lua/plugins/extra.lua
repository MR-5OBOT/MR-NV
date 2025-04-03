return {

    {
        "echasnovski/mini.nvim",
        version = false,
        config = function()
            -- require('mini.nvim').setup()
            -- require("mini.files").setup()
            -- require("mini.animate").setup()
            require("mini.indentscope").setup()
            require("mini.pairs").setup()
            -- require("mini.notify").setup()
        end,
    },

    -- nvim colorizer
    {
        "NvChad/nvim-colorizer.lua",
        lazy = false,
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("colorizer").setup({
                filetypes = { "*" },
                user_default_options = {
                    RGB = true,
                    RRGGBB = true,
                    names = true,
                    RRGGBBAA = true,
                    AARRGGBB = true,
                    rgb_fn = true,
                    hsl_fn = true,
                    css = true,
                    css_fn = true,
                    mode = "background", -- Set the display mode.
                    tailwind = true,
                    sass = { enable = true, parsers = { "css" } },
                    virtualtext = "■",
                    always_update = false,
                },
                buftypes = { "*" },
            })
        end,
    },
    -- nvim-tmux-navigation
    {
        "alexghergh/nvim-tmux-navigation",
        config = function()
            local nvim_tmux_nav = require("nvim-tmux-navigation")

            nvim_tmux_nav.setup({
                disable_when_zoomed = true, -- defaults to false
            })

            vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
            vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
            vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
            vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
            -- vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
            -- vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
        end,
    },
}
