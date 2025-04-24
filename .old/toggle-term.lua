return {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = false, -- Ensure it loads on startup
    config = function()
        require("toggleterm").setup({
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<C-\>]],
            insert_mappings = true,
            terminal_mappings = true,
            direction = "float", -- Change to 'horizontal' or 'vertical' if needed
            close_on_exit = true,
            start_in_insert = true,
            persist_size = true,
            persist_mode = true,
            shade_terminals = false,
            float_opts = {
                border = "curved",
                -- winblend = 10,
                -- zindex = 50,
                title_pos = "center",
            },
            winbar = {
                enabled = false,
            },
            responsiveness = {
                horizontal_breakpoint = 135,
            },
        })
    end,
}
