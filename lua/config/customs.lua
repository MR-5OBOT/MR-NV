
------- CUSTOM -------

local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

-- diagnostics settings
vim.diagnostic.config({
    virtual_text = {
        prefix = '●',
        source = 'if_many',
    },
    update_in_insert = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = 'minimal',
        border = 'single',
        header = '',
        prefix = '●',
    },
})

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

-- Open help in a right split window
vim.cmd([[
  autocmd FileType help wincmd L
]])

