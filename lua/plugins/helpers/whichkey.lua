return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        require("which-key").setup {
            opts = {
                operators = { gc = "Comments" },
                key_labels = {
                    ["<space>"] = "SPACE",
                    ["<leader>"] = "SPACE",
                    ["<cr>"] = "RETURN",
                    ["<tab>"] = "TAB",
                },
                icons = {
                    breadcrumb = "",
                    separator = "",
                    group = " ",
                },
                window = {
                    border = "none",
                    position = "bottom",
                    margin = { 1, 0, 1, 0 },
                    padding = { 0, 0, 0, 0 },
                    winblend = 0,
                },
                layout = {
                    height = { min = 3, max = 20 },
                    width = { min = 20, max = 50 },
                    spacing = 15,
                    align = "center",
                },
                ignore_missing = true,
                show_help = true,
                triggers = { "<leader>" },
                triggers_blacklist = {
                    i = { "j", "k" },
                    v = { "j", "k" },
                },
            } }
    end,
}
