return {
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
}
