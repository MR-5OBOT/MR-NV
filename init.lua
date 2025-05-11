---------------------------------------------------------------
-- ██╗███╗   ██╗██╗████████╗           ██╗     ██╗   ██╗ █████╗
-- ██║████╗  ██║██║╚══██╔══╝           ██║     ██║   ██║██╔══██╗
-- ██║██╔██╗ ██║██║   ██║              ██║     ██║   ██║███████║
-- ██║██║╚██╗██║██║   ██║              ██║     ██║   ██║██╔══██║
-- ██║██║ ╚████║██║   ██║       ▄█╗    ███████╗╚██████╔╝██║  ██║
-- ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝       ╚═╝    ╚══════╝ ╚═════╝ ╚═╝  ╚═╝
---------------------------------------------------------------

-- Avoid loading plugings befor mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.lazy")
-- require("config.autocommands")

local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

-- Disable commenting new lines
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.cmd('normal! g`"')
        end
    end,
})

-- Default yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})
