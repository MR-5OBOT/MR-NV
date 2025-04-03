return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        -- dashboard = { enabled = true },
        picker = { enabled = true },
        scroll = { enabled = true },
    },
    keys = {
        { "<leader>,",  function() Snacks.picker.buffers() end,        desc = "List Buffers" },
        { "<leader>gg", function() Snacks.lazygit() end,               desc = "Lazygit" },
        { "<leader>si", function() Snacks.picker.icons() end,          desc = "Icons" },
        { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
        { "<leader>R",  function() Snacks.rename.rename_file() end,    desc = "Rename File" },

        -- { "<leader>gl", function() Snacks.picker.git_log() end,            desc = "Git Log" },
        -- { "<leader>gs", function() Snacks.picker.git_status() end,         desc = "Git Status" },
        -- { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
        -- { "<leader>ff", function() Snacks.picker.files() end,              desc = "Find Files" },
        -- { "<leader>fs", function() Snacks.picker.smart() end,              desc = "Smart Find Files" },
        -- { "<leader>fh", function() Snacks.picker.help() end,               desc = "Help Pages" },
        -- { "<leader>fp", function() Snacks.picker.projects() end,           desc = "Projects" },
        -- { "<leader>z",  function() Snacks.zen() end,                       desc = "Toggle Zen Mode" },
        -- { "<leader>Z",  function() Snacks.zen.zoom() end,                  desc = "Toggle Zoom" },
        -- { "<c-\\>",     function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
    },
}
