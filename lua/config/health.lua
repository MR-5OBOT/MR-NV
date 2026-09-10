-- `:checkhealth config` -- external programs this configuration shells out to.
-- Neovim itself keeps working without any of them; this only says what breaks.
local health = vim.health

local M = {}

---@class DepSpec
---@field cmd string|string[] executable name, or alternatives (any one counts)
---@field what string what stops working without it
---@field install string? hint for getting it

---@type DepSpec[]
local required = {
	{ cmd = "git", what = "lazy.nvim clones and updates every plugin" },
	{ cmd = "curl", what = "Mason downloads, Tree-sitter parser tarballs" },
	{ cmd = "tar", what = "Tree-sitter unpacks parser tarballs" },
	{
		cmd = { "cc", "gcc", "clang" },
		what = "compiling Tree-sitter parsers and telescope-fzf-native",
		install = "base-devel (Arch) / build-essential (Debian) / Xcode CLT (macOS)",
	},
	{
		cmd = "tree-sitter",
		what = "nvim-treesitter (main branch) builds every parser with it",
		install = ":MasonInstall tree-sitter-cli",
	},
}

---@type DepSpec[]
local optional = {
	{ cmd = "rg", what = "Telescope live_grep, and the <leader>ff file list", install = "ripgrep" },
	{ cmd = "make", what = "building telescope-fzf-native (the native sorter)" },
	{
		cmd = "node",
		what = "Mason-installed ts_ls, bashls, basedpyright and prettier",
		install = "nodejs + npm",
	},
	{ cmd = "spf", what = "the <leader>n file browser", install = "superfile" },
	{ cmd = "tmux", what = "the <C-h/j/k/l> tmux navigation mappings" },
}

---@param cmd string|string[]
---@return string? found
local function locate(cmd)
	for _, name in ipairs(type(cmd) == "table" and cmd or { cmd }) do
		if vim.fn.executable(name) == 1 then
			return name
		end
	end
end

---@param spec DepSpec
---@param missing fun(msg: string, hint: string[]?)
local function check(spec, missing)
	local names = type(spec.cmd) == "table" and spec.cmd or { spec.cmd }
	local label = table.concat(names, " / ")
	local found = locate(spec.cmd)

	if found then
		health.ok(("%s: found (%s)"):format(label, vim.fn.exepath(found)))
	else
		missing(("%s: not found -- %s"):format(label, spec.what), spec.install and { spec.install } or nil)
	end
end

function M.check()
	health.start("mr5obot config: required tools")
	for _, spec in ipairs(required) do
		check(spec, health.error)
	end

	health.start("mr5obot config: optional tools")
	for _, spec in ipairs(optional) do
		check(spec, health.warn)
	end

	health.start("mr5obot config: Tree-sitter parsers")
	local ok, ts = pcall(require, "nvim-treesitter.config")
	if not ok then
		health.warn("nvim-treesitter is not loaded yet")
	else
		local installed = ts.get_installed("parsers")
		if #installed == 0 then
			health.warn("no parsers installed", { "Install the tree-sitter CLI, restart, then run :TSUpdate" })
		else
			table.sort(installed)
			health.ok(("%d parsers installed: %s"):format(#installed, table.concat(installed, ", ")))
		end
	end

	health.start("mr5obot config: clipboard")
	if vim.fn.has("clipboard") == 1 then
		health.ok("a clipboard provider is available (see :checkhealth vim.provider)")
	else
		health.warn("no clipboard provider -- `clipboard=unnamedplus` is a no-op", {
			"Install wl-clipboard (Wayland) or xclip / xsel (X11)",
		})
	end
end

return M
