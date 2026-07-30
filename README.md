# Neovim configuration

A compact Neovim setup focused on Python, Bash, Lua, and occasional TypeScript.

## Requirements

- Neovim 0.12+
- `git`, `make`, and a C compiler for native Telescope FZF
- A Nerd Font for icons (recommended)
- `spf` for the `<leader>n` file browser
- tmux only if you use the tmux-navigation mappings

## First start

Start Neovim normally. Lazy installs the pinned plugins from `lazy-lock.json`.
Mason installs the configured language servers, formatters, and Python debug adapter.

Useful commands:

- `:Lazy` — inspect or update plugins
- `:Mason` — inspect installed tools
- `:MasonToolsInstall` — install missing formatters/debug tools immediately
- `:TSUpdate` — update Tree-sitter parsers
- `:checkhealth` — inspect Neovim health
- `make check` — parse every Lua configuration file

## Upgrades

Update intentionally: run `:Lazy update`, review the `lazy-lock.json` changes,
then restart Neovim. Use `:MasonUpdate` separately when you want refreshed
tool metadata; tools themselves do not auto-update.
