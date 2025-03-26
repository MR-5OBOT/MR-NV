-- return {
--     "akinsho/toggleterm.nvim",
--     version = "*",
--     config = function()
--         require("toggleterm").setup({
--             size = function(term)
--                 if term.direction == "horizontal" then
--                     return 15
--                 elseif term.direction == "vertical" then
--                     return vim.o.columns * 0.5
--                 end
--             end,
--
--             open_mapping = [[<C-\>]],
--             autochdir = true,
--             close_on_exit = true,
--             start_in_insert = true,
--             auto_scroll = true,
--             direction = "float",
--
--             float_opts = {
--                 border = "single",
--                 -- width = 80,
--                 -- height = 30,
--                 highlights = {
--                     border = "Normal",
--                     background = "Normal",
--                 },
--             },
--         })
--     end,
-- }
--
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 25, -- Height of the terminal pane (adjust as needed)
			open_mapping = [[<C-\>]], -- Keymap to toggle the terminal (Ctrl-t here)
			direction = "horizontal", -- Opens as a horizontal split (pane) below
			shade_terminals = false, -- No shading to keep it looking plain
			hide_numbers = true, -- Hide line numbers for a cleaner look
			start_in_insert = true, -- Start in insert mode like a normal terminal
			persist_size = true, -- Keep the size consistent
			close_on_exit = true, -- Close the pane when the terminal process exits
			shell = vim.o.shell, -- Use your default shell (e.g., bash, zsh)
		})
	end,
}
