-- ██╗      █████╗ ███████╗███████╗██╗   ██╗           ███╗   ██╗██╗   ██╗██╗███╗   ███╗
-- ██║     ██╔══██╗╚══███╔╝╚══███╔╝╚██╗ ██╔╝           ████╗  ██║██║   ██║██║████╗ ████║
-- ██║     ███████║  ███╔╝   ███╔╝  ╚████╔╝            ██╔██╗ ██║██║   ██║██║██╔████╔██║
-- ██║     ██╔══██║ ███╔╝   ███╔╝    ╚██╔╝             ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ███████╗██║  ██║███████╗███████╗   ██║       ██╗    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝   ╚═╝       ╚═╝    ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝

-- Lazy.nvim Setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", lazyrepo, "--branch=stable", lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup Lazy.nvim with plugins
require("lazy").setup({
    { import = "plugins" },
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    { "folke/neodev.nvim" },
}, {
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
