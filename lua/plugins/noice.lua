return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        -- "rcarriga/nvim-notify",
    },
    opts = function(_, opts)
        -- only way to make lsp hover works for me
        opts.presets = opts.presets or {}
        opts.presets.lsp_doc_border = false

        -- style
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
