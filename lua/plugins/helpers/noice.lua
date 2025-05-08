return {
  -- this noice plugin make my float windows looks good IDK why LOL also notifications...
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = function(_, opts)
    opts.presets = opts.presets or {}
    opts.presets.lsp_doc_border = true

    opts.views = opts.views or {}
    opts.views.cmdline_popup = {
      border = {
        style = "none",
        padding = { 1, 1 },
      },
      filter_options = {},
      win_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },
    }
  end,
}
