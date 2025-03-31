return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        -- "rcarriga/nvim-notify",
    },
    opts = function(_, opts)
        -- Add custom route to filter LSP messages
        -- opts.presets = opts.presets or {}
        -- opts.presets.lsp_doc_border = true

        -- Assign views properly
        opts.views = {
            cmdline_popup = {
                border = {
                    style = "none",
                    padding = { 1, 1 },
                },
                filter_options = {},
                win_options = {
                    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                },
            },
        }
    end,
}
