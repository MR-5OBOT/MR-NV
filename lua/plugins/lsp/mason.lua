return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  config = function()
    require("mason").setup({
      ui = { border = "rounded" },
    })
  end,
}
