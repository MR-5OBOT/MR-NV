return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- (optional) auto-update parsers on install
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "css",
                "python",
                -- "tsx",
                -- "typescript",
                "vim",
                "yaml",
                "hyprlang",
                "toml",
                "vimdoc",
            },
            sync_install = true,
            auto_install = true,
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = { "markdown" },
            },
            indent = { enable = true },
        })

        -- hyprlang filetype
        vim.filetype.add({
            pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
        })
    end,
}
