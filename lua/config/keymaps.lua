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

-- 1. Sourcing (Pick one or keep both, but fixed the description)
keymap("n", "<leader>o", "<Cmd>source %<CR>", { desc = "Source current file" })
keymap("n", "<space><space>", "<cmd>source %<CR>", { desc = "Source current file" })

-- 2. Navigation & Utility
keymap("i", "jk", "<ESC>", opts)
keymap("n", "<Enter>", "<cmd>nohlsearch<CR>", opts)
keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
keymap("n", "<S-TAB>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" }) -- Fixed description
keymap("n", "<leader>mx", "<cmd>!chmod +x %<CR>", { desc = "Make file executable", silent = true })

-- 3. Search and Replace (Enhanced)
-- Normal mode: opens the command line ready to type :%s/
keymap("n", "<leader>ms", ":%s/", { desc = "Global search & replace" })

-- Visual mode: This version automatically escapes and puts your selection into the search field
keymap("v", "<leader>ms", '"qy:%s/<C-r>q//g<Left><Left>', { desc = "Search & replace selection" })

-- 4. Line Bubbling (Move lines up/down)
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- 5. Wrapped Line Navigation
-- This makes 'j' and 'k' move by visual lines unless a count is provided (e.g., 10j)
keymap("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
keymap("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
keymap("n", "<leader>wl", "<cmd>set wrap!<CR>", { desc = "Toggle line wrap" })

-- 6. Plugins
keymap("n", "<C-n>", ":Telescope colorscheme<CR>")
