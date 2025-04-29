return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "kdheepak/lazygit.nvim" },
  },
  config = function()
    local actions = require("telescope.actions")
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "^.git/",
          "^node_modules/",
          "^.DS_Store",
          "%.lock",
          "^env/",
          "^.env/",
        },
        hidden = true,
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            width = 0.6,
            height = 0.8,
            preview_width = 0.5,
          },
        },
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = "  ",
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
        results_title = false,
        preview_title = false,
        winblend = 0,
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<esc>"] = actions.close,
            ["<C-c>"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          hidden = true,
          previewer = true,
          layout_config = {
            width = 0.5,
            height = 0.4,
          },
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
          sort_lastused = true,
          layout_config = {
            width = 0.4,
            height = 0.4,
          },
        },
        help_tags = {
          theme = "ivy",
          previewer = true,
          layout_config = {
            width = 0.85,
            height = 0.6,
            prompt_position = "top",
          },
        },
        keymaps = {
          theme = "ivy",
          previewer = false,
        },
        commands = {
          theme = "ivy",
          previewer = false,
        },
        live_grep = {
          theme = "ivy",
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob",
            "!{.git,node_modules,dist,build,.venv}/*",
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    -- Load extensions
    telescope.load_extension("fzf")

    -- Keymaps
    local builtin = require("telescope.builtin")
    local map = vim.keymap.set

    map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    map("n", "<leader>,", builtin.buffers, { desc = "List Buffers" })
    map("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
    map("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
    map("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
    map("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy Find in Buffer" })
    map("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
    map("n", "<leader>fc", builtin.commands, { desc = "Commands" })

    -- LazyGit shortcut (optional)
    -- map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

    -- Clean UI colors for Monochrome
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#5c6370", bg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#5c6370", bg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#999999", bold = true })
    vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#666666" })
    vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#444444" })
  end,
}
