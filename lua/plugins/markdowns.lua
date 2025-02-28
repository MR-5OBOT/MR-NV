return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		---@module 'render-markdown'
		opts = {},
	},
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	-- 	ft = { "markdown" },
	-- 	build = function()
	-- 		vim.fn["mkdp#util#install"]()
	-- 	end,
	-- 	config = function()
	-- 		-- Set options for markdown-preview.nvim
	-- 		vim.g.vim_markdown_folding_disabled = 1
	-- 		vim.g.vim_markdown_conceal = 0
	-- 		vim.g.vim_markdown_conceal_code_blocks = 0
	-- 		vim.g.vim_markdown_new_list_item_indent = 2
	-- 		vim.g.mkdp_theme = "dark"
	-- 		vim.g.mkdp_filetypes = { "markdown" }
	-- 	end,
	-- },
}
