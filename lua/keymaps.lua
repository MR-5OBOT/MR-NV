-- Swap between split buffers
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { silent = true, desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { silent = true, desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { silent = true, desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { silent = true, desc = "Move to right split" })
