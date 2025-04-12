---------------------------------------------------------------
-- ██╗███╗   ██╗██╗████████╗           ██╗     ██╗   ██╗ █████╗
-- ██║████╗  ██║██║╚══██╔══╝           ██║     ██║   ██║██╔══██╗
-- ██║██╔██╗ ██║██║   ██║              ██║     ██║   ██║███████║
-- ██║██║╚██╗██║██║   ██║              ██║     ██║   ██║██╔══██║
-- ██║██║ ╚████║██║   ██║       ▄█╗    ███████╗╚██████╔╝██║  ██║
-- ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝       ╚═╝    ╚══════╝ ╚═════╝ ╚═╝  ╚═╝
---------------------------------------------------------------

-- Avoid loading plugings befor mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load options first (basic Neovim settings)
require("config.options")

-- Initialize lazy.nvim and load plugins
require("config.lazy-cfg")

-- Load keymaps after plugins (so plugin keymaps don't override custom ones)
require("config.keymaps")

-- Load autocommands last
require("config.autocommands")
