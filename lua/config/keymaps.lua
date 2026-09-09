---------------------------------------------------------------
-- ██╗  ██╗███████╗██╗   ██╗███╗   ███╗ █████╗ ██████╗ ███████╗
-- ██║ ██╔╝██╔════╝╚██╗ ██╔╝████╗ ████║██╔══██╗██╔══██╗██╔════╝
-- █████╔╝ █████╗   ╚████╔╝ ██╔████╔██║███████║██████╔╝███████╗
-- ██╔═██╗ ██╔══╝    ╚██╔╝  ██║╚██╔╝██║██╔══██║██╔═══╝ ╚════██║
-- ██║  ██╗███████╗   ██║   ██║ ╚═╝ ██║██║  ██║██║     ███████║
-- ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝

-----------------------------------------------
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- 1. Navigation & Utility
keymap("i", "jk", "<ESC>", opts)
keymap("n", "<Enter>", "<cmd>nohlsearch<CR>", opts)
keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
keymap("n", "<S-TAB>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" }) -- Fixed description
keymap("n", "<leader>mx", function()
	local filename = vim.api.nvim_buf_get_name(0)
	if filename == "" then
		vim.notify("Cannot make an unnamed buffer executable", vim.log.levels.WARN)
		return
	end

	local result = vim.system({ "chmod", "+x", "--", filename }, { text = true }):wait()
	if result.code ~= 0 then
		local message = vim.trim(result.stderr or "")
		vim.notify(message ~= "" and message or "Failed to make file executable", vim.log.levels.ERROR)
	end
end, { desc = "Make file executable" })
keymap("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic" })
keymap("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- 2. Search and Replace (Enhanced)
-- Normal mode: opens the command line ready to type :%s/
keymap("n", "<leader>ms", ":%s/", { desc = "Global search & replace" })

-- Visual mode: put the literal selection into the search field.
keymap("x", "<leader>ms", function()
	local mode = vim.fn.mode()
	if mode == "\22" then
		vim.notify("Block selections are not supported", vim.log.levels.WARN)
		return
	end

	local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = mode })
	for index, line in ipairs(lines) do
		lines[index] = vim.fn.escape(line, [[\/]])
	end
	local pattern = table.concat(lines, [[\n]])
	if pattern == "" then
		vim.notify("Cannot replace an empty selection", vim.log.levels.WARN)
		return
	end

	local command = ":%s/\\V" .. pattern .. "//g"
	vim.api.nvim_feedkeys(vim.keycode("<Esc>") .. command .. vim.keycode("<Left><Left>"), "n", false)
end, { desc = "Search & replace selection" })

-- 3. Line Bubbling (Move lines up/down)
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- 4. Wrapped Line Navigation
-- This makes 'j' and 'k' move by visual lines unless a count is provided (e.g., 10j)
keymap("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
keymap("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

-- 5. Plugins
keymap("n", "<C-n>", ":Telescope colorscheme<CR>")

-- 6. superfile (replaces yazi.nvim)
keymap("n", "<leader>n", function()
	if vim.fn.executable("spf") == 0 then
		vim.notify("superfile (spf) is not installed", vim.log.levels.ERROR)
		return
	end

	local chooser = vim.fn.tempname()
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = math.floor(vim.o.columns * 0.9),
		height = math.floor(vim.o.lines * 0.9),
		row = math.floor(vim.o.lines * 0.05),
		col = math.floor(vim.o.columns * 0.05),
		border = "none",
	})
	vim.fn.jobstart({ "spf", "--chooser-file", chooser, vim.fn.expand("%:p:h") }, {
		term = true,
		on_exit = function()
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end
			local f = io.open(chooser)
			if not f then
				return
			end
			local path = f:read("*l")
			f:close()
			os.remove(chooser)
			if path and path ~= "" then
				vim.cmd.edit(vim.fn.fnameescape(path))
			end
		end,
	})
	vim.cmd.startinsert()
end, { desc = "Open superfile at current file" })
