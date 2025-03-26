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

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("i", "jk", "<ESC>", opts)                    -- Press jk fast to exit insert mode
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

keymap("v", "J", ":m '>+1<CR>gv=gv")                                              -- move selected lines DOWN
keymap("v", "K", ":m '<-2<CR>gv=gv")                                              -- move selected lines UP

keymap("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true }) -- Allow moving the cursor through wrapped lines
keymap("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true }) -- Allow moving the cursor through wrapped lines

keymap("n", "<leader>e", ":Explore<CR>", { noremap = true, silent = true })

-- reload config
keymap("n", "<leader>r", ":source $MYVIMRC<CR>", { noremap = true, silent = true })

-- Define a function to run the Python file in a tmux pane on the right
local function run_python_in_tmux()
    -- Get the current file path
    local file = vim.fn.expand("%:p")
    -- Command to split tmux vertically and run python on the file
    local tmux_cmd = string.format("tmux split-window -h 'python3 %s; read -p \"Press enter to exit...\"'", file)
    -- Execute the tmux command silently
    vim.fn.system(tmux_cmd)
end

-- Set the keymap
vim.keymap.set("n", "<leader>rp", run_python_in_tmux, { desc = "Run Python in tmux pane (right)" })
