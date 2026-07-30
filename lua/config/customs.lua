------- CUSTOM -------

local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd
local custom_autocmds = ag("user_customs", { clear = true })

-- Python convention: use four spaces unless the project defines its own style.
local python_options = ag("user_python_options", { clear = true })
au("FileType", {
	group = python_options,
	pattern = "python",
	callback = function(args)
		local filename = vim.api.nvim_buf_get_name(args.buf)
		local directory = filename ~= "" and vim.fs.dirname(filename) or vim.fn.getcwd()
		if vim.fs.find(".editorconfig", { path = directory, upward = true })[1] then
			return
		end

		vim.bo[args.buf].expandtab = true
		vim.bo[args.buf].shiftwidth = 4
		vim.bo[args.buf].tabstop = 4
		vim.bo[args.buf].softtabstop = 4
	end,
})

-- diagnostics
vim.diagnostic.config({
	virtual_text = {
		prefix = function(diagnostic)
			local icons = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.HINT] = "󰌵 ",
				[vim.diagnostic.severity.INFO] = " ",
			}
			return icons[diagnostic.severity]
		end,
		source = "if_many",
	},
	signs = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		header = "",
		prefix = "-> ",
	},
})

-- Disable commenting new lines
au("BufEnter", {
	group = custom_autocmds,
	callback = function()
		vim.opt_local.formatoptions:remove("c")
		vim.opt_local.formatoptions:remove("r")
		vim.opt_local.formatoptions:remove("o")
	end,
})

-- return to last edit position when opening files
au("BufReadPost", {
	group = custom_autocmds,
	callback = function()
		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.cmd('normal! g`"')
		end
	end,
})

-- Default yank highlight
au("TextYankPost", {
	group = custom_autocmds,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Open help in a right split window
au("FileType", {
	group = custom_autocmds,
	pattern = "help",
	command = "wincmd L",
})
