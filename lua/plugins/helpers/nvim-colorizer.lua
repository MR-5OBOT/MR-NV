return {
  "NvChad/nvim-colorizer.lua",
  lazy = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("colorizer").setup({
      filetypes = { "*" },
    })
  end,
}
