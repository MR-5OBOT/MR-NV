-- ██╗      █████╗ ███████╗███████╗██╗   ██╗           ███╗   ██╗██╗   ██╗██╗███╗   ███╗
-- ██║     ██╔══██╗╚══███╔╝╚══███╔╝╚██╗ ██╔╝           ████╗  ██║██║   ██║██║████╗ ████║
-- ██║     ███████║  ███╔╝   ███╔╝  ╚████╔╝            ██╔██╗ ██║██║   ██║██║██╔████╔██║
-- ██║     ██╔══██║ ███╔╝   ███╔╝    ╚██╔╝             ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ███████╗██║  ██║███████╗███████╗   ██║       ██╗    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝   ╚═╝       ╚═╝    ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝

-- Lazy.nvim Setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
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
	{ import = "plugins.lsp" },
	{ import = "plugins.helpers" },
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	{
		"folke/lazydev.nvim",
		ft = "lua", -- lazy-load on Lua files
		opts = {
			library = {
				-- Type definitions for the `vim.uv` (libuv) async API
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}, {
	-- Fresh install: show the local colorscheme while plugins download, and
	-- fall back to a built-in one if it has not been sourced yet.
	install = { colorscheme = { "mr5obot-theme", "habamax" } },
	-- No plugin here needs luarocks; skipping it avoids a hererocks
	-- bootstrap (and its warnings) on a machine without lua/luarocks.
	rocks = { enabled = false },
	change_detection = { notify = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"spellfile",
				"tarPlugin",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
