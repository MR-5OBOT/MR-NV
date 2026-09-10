# Neovim configuration

A compact Neovim setup focused on Python, Bash, Lua, and occasional TypeScript.

## Requirements

Neovim 0.12+, plus:

| Tool                  | Needed for                                                  |
| --------------------- | ----------------------------------------------------------- |
| `git`, `curl`, `tar`  | lazy.nvim, Mason downloads, Tree-sitter parser tarballs      |
| A C compiler (`cc`)   | Compiling Tree-sitter parsers and telescope-fzf-native       |
| `make`                | Building telescope-fzf-native (skipped if absent)            |
| `ripgrep`             | `<leader>g` live grep, `<leader>ff` file list                |
| `node` + `npm`        | Mason-installed `ts_ls`, `bashls`, `basedpyright`, `prettier`|
| `superfile` (`spf`)   | `<leader>n` file browser                                     |
| A Nerd Font           | Icons in the bufferline, Telescope, diagnostics              |

Everything below the C compiler is optional — the config detects what is
missing and degrades instead of erroring.

On Arch:

```sh
sudo pacman -S --needed neovim git curl base-devel ripgrep nodejs npm superfile wl-clipboard
```

The `tree-sitter` CLI is **not** in that list on purpose: nvim-treesitter's
`main` branch needs it to build parsers, and this config installs it for you
through Mason on first start.

## First start

Just run `nvim`. In order, and without any input from you:

1. lazy.nvim bootstraps itself and installs the plugins pinned in `lazy-lock.json`.
2. Mason installs the `tree-sitter` CLI, then Tree-sitter compiles the parsers.
3. Mason installs the language servers and the formatters.

Steps 2 and 3 run in the background; Neovim's bundled parsers cover editing
until they finish. Restart once when they are done.

Run `make health` (or `:checkhealth config` inside Neovim) to see exactly which
external tools are present and which parsers are installed.

Useful commands:

- `:Lazy` — inspect or update plugins
- `:Mason` — inspect installed tools
- `:MasonToolsInstall` — install missing formatters immediately
- `:TSUpdate` — update Tree-sitter parsers
- `:checkhealth config` — external tools this config depends on
- `:checkhealth` — full Neovim health
- `make check` — parse every Lua configuration file

## Upgrades

Update intentionally: run `:Lazy update`, review the `lazy-lock.json` changes,
then restart Neovim. Use `:MasonUpdate` separately when you want refreshed
tool metadata; tools themselves do not auto-update.
