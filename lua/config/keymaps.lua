---------------------------------------------------------------
-- ██╗  ██╗███████╗██╗   ██╗███╗   ███╗ █████╗ ██████╗ ███████╗
-- ██║ ██╔╝██╔════╝╚██╗ ██╔╝████╗ ████║██╔══██╗██╔══██╗██╔════╝
-- █████╔╝ █████╗   ╚████╔╝ ██╔████╔██║███████║██████╔╝███████╗
-- ██╔═██╗ ██╔══╝    ╚██╔╝  ██║╚██╔╝██║██╔══██║██╔═══╝ ╚════██║
-- ██║  ██╗███████╗   ██║   ██║ ╚═╝ ██║██║  ██║██║     ███████║
-- ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝

-----------------------------------------------
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
-- local map = vim.api.nvim_set_keymap

vim.keymap.set("n", "<space><space>", "<cmd>source %<CR>")

vim.keymap.set("i", "jk", "<ESC>", opts) -- Press jk fast to exit insert mode
vim.keymap.set("n", "<Enter>", "<cmd>nohlsearch<CR>", opts) -- Clear search
vim.keymap.set("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-TAB>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<leader>mx", "<cmd>!chmod +x %<CR>", { desc = "Chmod +x without leaving document", silent = true })

vim.keymap.set("n", "<leader>ms", ":%s/", { desc = "multi select & replace" }) -- Easier multi select and remove
vim.keymap.set(
	"v",
	"<leader>ms",
	[[:s//g<Left><Left>]],
	{ desc = "Multi-select & replace", noremap = true, silent = true }
)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move selected lines DOWN
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move selected lines UP

vim.keymap.set("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true }) -- Allow moving the cursor through wrapped lines
vim.keymap.set("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true }) -- Allow moving the cursor through wrapped lines

-- colorscheme picker
vim.keymap.set("n", "<C-n>", ":Telescope colorscheme<CR>")
