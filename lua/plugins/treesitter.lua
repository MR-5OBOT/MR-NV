return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main", -- new rewrite (incompatible with the old `master` config)
	lazy = false, -- main branch does not support lazy-loading
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()

		-- Parsers to keep installed. On the `main` branch setup() ignores
		-- `ensure_installed`, so we install them explicitly (no-op if present).
		require("nvim-treesitter").install({
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
		})

		-- Hyprland *.conf -> hyprlang
		vim.filetype.add({
			pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
		})

		-- Enable highlight + indent per-buffer (only when a parser exists).
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
			callback = function(args)
				if pcall(vim.treesitter.start, args.buf) then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
