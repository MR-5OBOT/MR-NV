-- options for Neovim
local opt = vim.opt

-- Performance optimizations
opt.updatetime = 100 -- Faster completion
opt.timeoutlen = 300 -- Faster key sequence completion
opt.redrawtime = 1500 -- Allow more time for loading syntax
opt.synmaxcol = 240 -- Only highlight first 240 columns (performance)
opt.maxmempattern = 2000 -- Increase max memory for pattern matching

-- Folding (optional, but lightweight)
opt.foldmethod = "manual"
opt.foldlevel = 99
opt.foldenable = false

vim.opt.breakindent = true -- Better wrapping visuals (very cheap)

-- Essential UI and behavior
opt.clipboard = "unnamedplus" -- System clipboard
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.autoindent = true
opt.smartindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Window behavior
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Files
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.history = 50
opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"

-- UI niceties
opt.cursorline = true
opt.signcolumn = "yes"
opt.mouse = "a"

-- Completion
opt.completeopt = { "menuone", "noselect" }
opt.pumheight = 8

-- Command-line experience
opt.wildmode = "longest:full,full"
opt.wildmenu = true
opt.wildignorecase = true

-- Disable built-in plugins (important for speed)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_zip = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_vimball = 1
