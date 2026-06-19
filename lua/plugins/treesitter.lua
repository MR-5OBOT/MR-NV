return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = {
				"bash",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"css",
				"python",
				"vim",
				"yaml",
				"hyprlang",
				"toml",
				"vimdoc",
			},
			auto_install = true,
			highlight = {
				enable = true,
				disable = function(lang, buf)
					local max_filesize = 100 * 1024
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
				additional_vim_regex_highlighting = { "markdown" },
			},
			indent = { enable = true },
		})

		vim.filetype.add({
			pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
		})
	end,
}
