-- return {
--     "folke/which-key.nvim",
--     event = "VeryLazy",
--     init = function()
--         vim.o.timeout = true
--         vim.o.timeoutlen = 300
--     end,
--     config = function()
--         require("which-key").setup {
--             opts = {
--                 operators = { gc = "Comments" },
--                 key_labels = {
--                     ["<space>"] = "SPACE",
--                     ["<leader>"] = "SPACE",
--                     ["<cr>"] = "RETURN",
--                     ["<tab>"] = "TAB",
--                 },
--                 icons = {
--                     breadcrumb = "",
--                     separator = "",
--                     group = " ",
--                 },
--                 window = {
--                     border = "none",
--                     position = "bottom",
--                     margin = { 1, 0, 1, 0 },
--                     padding = { 0, 0, 0, 0 },
--                     winblend = 0,
--                 },
--                 layout = {
--                     height = { min = 3, max = 20 },
--                     width = { min = 20, max = 50 },
--                     spacing = 15,
--                     align = "center",
--                 },
--                 ignore_missing = true,
--                 show_help = true,
--                 triggers = { "<leader>" },
--                 triggers_blacklist = {
--                     i = { "j", "k" },
--                     v = { "j", "k" },
--                 },
--             } }
--     end,
-- }
--
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    plugins = {
      marks = false,
      operators = false,
      windows = false,
      nav = false,
    },
    win = {
      padding = { 0, 1 },
      title = false,
      border = "none",
    },
    icons = {
      breadcrumb = ">>=",
      separator = ":: ",
      group = " ++ ",
      keys = {},
    },
  },
  config = function(_, opts)
    require("which-key").setup(opts)
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
