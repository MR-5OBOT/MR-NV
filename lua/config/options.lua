-- options for Neovim
local opt = vim.opt

opt.clipboard = "unnamedplus" -- Use system clipboard
opt.number = true             -- Show absolute line numbers
opt.relativenumber = true     -- Show relative line numbers
opt.termguicolors = true      -- Enable true colors
opt.autoindent = true         -- Auto-indent new lines
opt.shiftwidth = 4            -- Indentation level
opt.tabstop = 4               -- Tab width
opt.expandtab = true          -- Use spaces instead of tabs
opt.showtabline = 2           -- display tab line
opt.ignorecase = true         -- Ignore case in search
opt.smartcase = true          -- Enable smart case search
opt.hlsearch = true           -- Highlight search matches
opt.splitbelow = true         -- Horizontal splits go below
opt.splitright = true         -- Vertical splits go right
opt.scrolloff = 8             -- Lines to keep above/below the cursor
opt.sidescrolloff = 8         -- Columns to keep left/right of the cursor
opt.updatetime = 300          -- Update time for CursorHold
opt.backup = false            -- Disable backups
opt.undofile = true           -- Enable persistent undo
opt.swapfile = false
opt.history = 50              -- Command history size
opt.linebreak = true          -- Don't split words when wrapping
opt.wrap = false              -- Disable line wrapping
-- opt.cmdheight = 2             -- Command line height
opt.cursorline = true         -- Highlight current line
opt.fileencoding = "utf-8"    -- File encoding
-- opt.laststatus = 0            -- Disable status line
opt.showtabline = 0           -- Disable tabline
opt.smartindent = true        -- Enable smart indentation
-- opt.winborder = "rounded"       -- Defines the default border style of floating windows.

-- Disable built-in plugins
vim.g.loaded_netrw = 1       -- Disable Netrw
vim.g.loaded_netrwPlugin = 1 -- Disable Netrw plugin
vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_zip = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_vimball = 1
