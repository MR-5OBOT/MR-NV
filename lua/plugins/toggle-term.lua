return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            open_mapping = [[<C-\>]],
            direction = "float",
            close_on_exit = true,
            start_in_insert = true,
            float_opts = {
                border = "single",
            },
        })
    end,
}
