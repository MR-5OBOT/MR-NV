return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    keys = {
        { "<leader>e", ":Neotree toggle float<CR>", desc = "Toggle Float File Explorer", silent = true },
    },
    config = function()
        require("nvim-web-devicons").setup()

        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "single",
            enable_git_status = true,
            enable_diagnostics = true,
            sort_case_insensitive = true,
            default_component_configs = {
                indent = {
                    with_markers = true,
                    with_expanders = true,
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "",
                    folder_empty_open = "",
                    default = "",
                    highlight = "NeoTreeFileIcon",
                },
                modified = {
                    symbol = "●",
                    highlight = "NeoTreeModified",
                },
                git_status = {
                    symbols = {
                        added = "✚",
                        deleted = "✖",
                        modified = "✎",
                        renamed = "➜",
                        untracked = "★",
                        ignored = "◌",
                        unstaged = "✗",
                        staged = "✓",
                        conflict = "⚠",
                    },
                },
            },
            window = {
                position = "float",
                width = 35,
                mappings = {
                    ["<space>"] = "toggle_node",
                    ["<cr>"] = "open",
                    ["o"] = "open",
                    ["a"] = "add",
                    ["d"] = "delete",
                    ["r"] = "rename",
                    ["c"] = "copy",
                    ["x"] = "cut",
                    ["p"] = "paste",
                    ["q"] = "close_window",
                },
            },
            filesystem = {
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = { "node_modules" },
                    hide_by_pattern = { "*.pyc", "__pycache__" },
                    never_show = { ".DS_Store", "thumbs.db" },
                },
            },
            buffers = {
                follow_current_file = true,
                group_empty_dirs = true,
            },
            git_status = {
                window = {
                    position = "float",
                },
            },
            event_handlers = {
                {
                    event = "neo_tree_window_after_open",
                    handler = function(args)
                        if args.position == "left" or args.position == "right" then
                            vim.cmd("wincmd =")
                        end
                    end,
                },
                {
                    event = "neo_tree_window_after_close",
                    handler = function(args)
                        if args.position == "left" or args.position == "right" then
                            vim.cmd("wincmd =")
                        end
                    end,
                },
            },
        })
    end,
}
