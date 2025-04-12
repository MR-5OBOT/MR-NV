-- options for Neovim
local opt = vim.opt

-- Performance optimizations
opt.updatetime = 100                                                         -- Faster completion
opt.timeoutlen = 300                                                         -- Faster key sequence completion
opt.redrawtime = 1500                                                        -- Allow more time for loading syntax
opt.synmaxcol = 240                                                          -- Only highlight the first 240 columns
opt.maxmempattern = 2000                                                     -- Increase the max memory for pattern matching
opt.foldmethod = "indent"                                                    -- Faster folding
opt.foldlevelstart = 99                                                      -- Don't fold by default
opt.foldenable = false                                                       -- Disable folding by default
opt.foldcolumn = "0"                                                         -- Don't show fold column
opt.foldlevel = 99                                                           -- Don't fold by default
opt.foldopen = "block,hor,insert,jump,mark,percent,quickfix,search,tag,undo" -- Don't fold when opening
opt.foldclose = "all"                                                        -- Fold when closing
opt.foldminlines = 1                                                         -- Fold even single line
opt.foldnestmax = 20                                                         -- Maximum nesting level
opt.foldtext = ""                                                            -- Don't show fold text
opt.foldignore = ""                                                          -- Don't ignore anything when folding

-- Existing options
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
opt.backup = false            -- Disable backups
opt.undofile = true           -- Enable persistent undo
opt.swapfile = false
opt.history = 50              -- Increased command history size
opt.linebreak = true          -- Don't split words when wrapping
opt.wrap = false              -- Disable line wrapping
opt.cursorline = true         -- Highlight current line
opt.fileencoding = "utf-8"    -- File encoding
vim.opt.encoding = "utf-8"
opt.showtabline = 0           -- Disable tabline
opt.smartindent = true        -- Enable smart indentation

-- Modern conveniences
opt.mouse = ""                              -- Enable mouse in all modes
opt.signcolumn = "yes"                      -- Always show sign column
opt.completeopt = { "menuone", "noselect" } -- Better completion experience
opt.wildmode = "longest:full,full"          -- Better command-line completion
opt.wildmenu = true                         -- Enable wild menu
opt.wildignorecase = true                   -- Ignore case in wild menu
opt.pumheight = 8                           -- Maximum number of items in completion menu


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
