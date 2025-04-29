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

-- now it's used on init.lua
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

keymap("i", "jk", "<ESC>", opts) -- Press jk fast to exit insert mode
keymap("n", "<Enter>", "<cmd>nohlsearch<CR>", opts) -- Clear search
keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
keymap("n", "<S-TAB>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Next buffer" })
keymap("n", "<leader>mx", "<cmd>!chmod +x %<CR>", { desc = "Chmod +x without leaving document", silent = true })

keymap("n", "<leader>ms", ":%s/", { desc = "multi select & replace" }) -- Easier multi select and remove
vim.keymap.set(
  "v",
  "<leader>ms",
  [[:s//g<Left><Left>]],
  { desc = "Multi-select & replace", noremap = true, silent = true }
)

keymap("v", "J", ":m '>+1<CR>gv=gv") -- move selected lines DOWN
keymap("v", "K", ":m '<-2<CR>gv=gv") -- move selected lines UP

keymap("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true }) -- Allow moving the cursor through wrapped lines
keymap("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true }) -- Allow moving the cursor through wrapped lines

keymap("n", "<leader>z", ":Td<CR>", { silent = true })

-- run pthon files
local function run_python_in_tmux()
  local file = vim.fn.expand("%:p")
  local cmd =
    string.format("tmux split-window -h 'clear; python3 \"%s\"; echo; echo Press enter to exit...; read'", file)
  vim.fn.system(cmd)
end
keymap("n", "<leader>rp", run_python_in_tmux, { desc = "Run current Python file in right tmux split" })

-- easy float term
local terminal = require("custom-plugins.floatTerm")
vim.keymap.set("n", "<C-\\>", terminal.toggle_terminal, { desc = "Toggle floating terminal" })
