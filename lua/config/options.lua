local opt = vim.opt

-- Performance
opt.updatetime = 250 -- Faster updates (LSP diagnostics, CursorHold)
opt.timeoutlen = 300 -- Quick key sequence completion
opt.redrawtime = 1500 -- Allow time for syntax redraw
opt.synmaxcol = 240 -- Limit syntax highlighting to 240 columns

-- UI Essentials
opt.number = true -- Line numbers
opt.relativenumber = true -- Relative line numbers
opt.termguicolors = true -- True color support
opt.cursorline = true -- Highlight current line
opt.signcolumn = "yes" -- Always show sign column for LSP diagnostics
opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor
opt.mouse = "nv" -- Mouse in normal/visual modes (avoids lspsaga.nvim conflicts)
opt.wrap = false
opt.laststatus = 0

-- Editing
opt.autoindent = true -- Auto-indent new lines
opt.smartindent = true -- Smart indenting for code
opt.shiftwidth = 4 -- 4 spaces for indentation
opt.tabstop = 4 -- 4 spaces for tabs
opt.expandtab = true -- Use spaces instead of tabs
opt.clipboard = "unnamedplus" -- System clipboard integration

-- Search
opt.ignorecase = true -- Case-insensitive search
opt.smartcase = true -- Case-sensitive if uppercase
opt.hlsearch = true -- Highlight search matches

-- Completion
opt.completeopt = { "menuone", "noselect" } -- For nvim-cmp
opt.pumheight = 8 -- Limit completion menu height

-- Files
opt.swapfile = false -- Disable swap files
opt.undofile = true -- Persistent undo
opt.fileencoding = "utf-8" -- UTF-8 encoding for files

-- Window Behavior
opt.splitbelow = true -- Horizontal splits below
opt.splitright = true -- Vertical splits to the right

-- Command-line
opt.wildmode = "longest:full,full" -- Command-line completion
opt.wildignorecase = true -- Case-insensitive completion

-- Disable unused built-in plugins for speed
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_zip = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_vimball = 1
