return {
    -- Set the default style for monochrome
    {
        "kdheepak/monochrome.nvim",
        config = function()
            vim.g.monochrome_style = "amplified"
            vim.cmd("colorscheme monochrome")
        end,
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        lazy = true,
        config = function()
            -- vim.cmd.colorscheme("oxocarbon") -- Set oxocarbon as default
            vim.opt.background = "dark" -- Ensure dark mode
        end,
    },
}
