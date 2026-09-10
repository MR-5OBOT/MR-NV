-- Parsers to keep installed. The `main` branch has no `ensure_installed`,
-- so we install them explicitly (a no-op when they are already present).
local parsers = {
	"bash",
	"css",
	"html",
	"hyprlang",
	"javascript",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"toml",
	"typescript",
	"tsx",
	"typst",
	"vim",
	"vimdoc",
	"yaml",
}

-- The `main` branch shells out to the `tree-sitter` CLI to generate and build
-- every parser. Without it each install fails with
-- `ENOENT: no such file or directory (cmd): 'tree-sitter'`, which is what a
-- fresh machine hits. Mason ships it as a prebuilt binary, so bootstrap it
-- here rather than making the user install it by hand.
local CLI_PACKAGE = "tree-sitter-cli"

local function have_cli()
	return vim.fn.executable("tree-sitter") == 1
end

local function enable(buf)
	if pcall(vim.treesitter.start, buf) then
		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
end

-- Parsers that land after a buffer is already open need highlighting kicked
-- off by hand. On a normal start everything is installed before any file is
-- read and this is a no-op.
local function enable_open_buffers()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= "" then
			enable(buf)
		end
	end
end

local function install_parsers()
	local task = require("nvim-treesitter").install(parsers)
	-- `install` is async; `await` is nvim-treesitter's own task handle, so
	-- guard it rather than depend on an internal shape staying put.
	pcall(function()
		task:await(function()
			vim.schedule(enable_open_buffers)
		end)
	end)
end

local function manual_hint()
	vim.notify(
		("Could not install the tree-sitter CLI. Run `:MasonInstall %s`, or install it "):format(CLI_PACKAGE)
			.. "from your package manager, then run `:TSUpdate`.",
		vim.log.levels.WARN
	)
end

-- Ask Mason for the CLI, then install the parsers once it is on PATH.
-- Deliberately not routed through mason-tool-installer: that runs on a 24h
-- debounce, so a failed or skipped first run would leave parsers broken
-- until the next day.
local function bootstrap_cli()
	local ok, registry = pcall(require, "mason-registry")
	if not ok then
		return manual_hint()
	end

	vim.notify("Installing the tree-sitter CLI with Mason; parsers will build once it lands.", vim.log.levels.INFO)

	registry.refresh(vim.schedule_wrap(function()
		if not registry.has_package(CLI_PACKAGE) then
			return manual_hint()
		end

		local pkg = registry.get_package(CLI_PACKAGE)
		if pkg:is_installed() then
			-- Present but not on PATH (mason.setup() not run yet, say).
			return have_cli() and install_parsers() or manual_hint()
		end
		if pkg:is_installing() then
			return
		end

		pkg:install(nil, vim.schedule_wrap(function(success)
			if success and have_cli() then
				install_parsers()
			else
				manual_hint()
			end
		end))
	end))
end

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main", -- new rewrite (incompatible with the old `master` config)
	lazy = false, -- main branch does not support lazy-loading
	-- Mason provides the `tree-sitter` binary and puts it on Neovim's PATH,
	-- so it has to be set up before this plugin's config runs.
	dependencies = { "williamboman/mason.nvim" },
	build = function()
		-- On a fresh machine the CLI arrives from Mason a moment later and
		-- config() installs the parsers then; failing here only spams errors.
		if have_cli() then
			vim.cmd("TSUpdate")
		end
	end,
	config = function()
		-- Hyprland *.conf -> hyprlang
		vim.filetype.add({
			pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
		})

		-- Enable highlight + indent per-buffer (only when a parser exists).
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
			callback = function(args)
				enable(args.buf)
			end,
		})

		if have_cli() then
			install_parsers()
		else
			bootstrap_cli()
		end
	end,
}
