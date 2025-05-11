return {
  {
    "echasnovski/mini.nvim",
    -- version = false,
    config = function()
      -- require('mini.nvim').setup()
      -- require("mini.files").setup()
      -- require("mini.animate").setup()
      require("mini.indentscope").setup()
      require("mini.pairs").setup()
      require("mini.statusline").setup({ use_icons = true })
      -- require("mini.notify").setup()
    end,
  },
}
