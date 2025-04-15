return {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("lspsaga").setup({
            ui = {
                border = "rounded",
                code_action = "💡",
                colors = {
                    normal_bg = "#1e222a",
                },
            },
            lightbulb = {
                enable = true,
                sign = true,
                virtual_text = true,
            },
            outline = {
                win_position = "right",
                win_width = 30,
                auto_preview = true,
                auto_refresh = true,
            },
            symbol_in_winbar = {
                enable = false,
            },
        })
    end,
}
