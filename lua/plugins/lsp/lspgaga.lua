return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("lspsaga").setup({
      ui = { border = "rounded", code_action = "💡" },
      lightbulb = { enable = true, virtual_text = false },
      symbol_in_winbar = { enable = true, separator = " > " },
      finder = { keys = { toggle_or_open = "o", quit = "q" } },
      rename = { in_select = false },
    })
  end,
}
