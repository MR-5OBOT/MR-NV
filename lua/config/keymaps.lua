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

keymap("n", "<leader>e", ":Explore<CR>", { noremap = true, silent = true })

-- Keymap to run the current file (e.g., for a Python script)
-- keymap("n", "<leader>r", ":botright split | resize 10 | terminal python %<CR>i", { noremap = true, silent = true })

keymap("n", "<leader>r", function()
	-- Access your existing toggleterm configuration
	local Terminal = require("toggleterm.terminal").Terminal

	-- Create a new terminal instance with your custom settings
	local python_term = Terminal:new({
		cmd = "python " .. vim.fn.expand("%"), -- Run the current file
		dir = vim.fn.expand("%:p:h"), -- Run in the directory of the current file
		direction = "float", -- Use floating mode
		hidden = true, -- Hide the terminal instead of closing it
		on_open = function()
			vim.cmd("startinsert!") -- Automatically enter insert mode
		end,
		on_close = function()
			vim.cmd("stopinsert!") -- Exit insert mode when the terminal closes
		end,
	})

	-- Toggle the terminal
	python_term:toggle()
end, { noremap = true, silent = true })
