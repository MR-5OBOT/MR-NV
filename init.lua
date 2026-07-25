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

require("config.options")
require("config.keymaps")
require("config.customs")

-- Colorscheme (local file: colors/mr5obot-theme.lua).
-- Applied before plugins load so plugin highlight overrides layer on top.
pcall(vim.cmd.colorscheme, "mr5obot-theme")

require("config.lazy")
