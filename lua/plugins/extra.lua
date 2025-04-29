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
      require("mini.statusline").setup({ use_icons = true })
      -- require("mini.notify").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true, -- show signs in the sign column (left)
      numhl = false, -- no number highlight
      linehl = false, -- no line highlight
      word_diff = false, -- no word diff
      current_line_blame = false,
    },
  },
  -- nvim colorizer
  {
    "NvChad/nvim-colorizer.lua",
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
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
    end,
  },
}
