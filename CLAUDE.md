# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository managed with **GNU Stow**. Stow creates symlinks from the repo into the home directory, deploying each tool's configuration to its proper location.

## Installation

Deploy all configs at once or individually:

```bash
stow nvim tmux zsh starship wezterm ssh
# or individually:
stow zsh
stow nvim
```

Each top-level directory corresponds to a tool (e.g., `nvim/.config/nvim/` → `~/.config/nvim/`).

## Repository Structure

| Directory | Tool | Key Files |
|-----------|------|-----------|
| `zsh/` | Z Shell | `.zshrc`, `.zshenv` |
| `nvim/` | Neovim (hand-configured lazy.nvim) | `.config/nvim/lua/` |
| `tmux/` | Tmux | `.tmux.conf`, `.config/tmux/` |
| `wezterm/` | Wezterm terminal | `.config/wezterm/wezterm.lua` |
| `starship/` | Shell prompt | `.config/starship.toml` |
| `ssh/` | SSH client | `.ssh/config` |
| `styles/` | PDF export CSS | `pdf_styles.css` |

## Architecture

### Design Principles
- **Nord color scheme** is used consistently across all tools (tmux, starship, wezterm, neovim)
- **CTRL-A prefix** is shared between wezterm and tmux for consistent muscle memory
- **Vi/vim keybindings** are enabled in zsh, tmux, and wezterm
- **Session persistence** is configured in both wezterm (plugin) and tmux (tmux-resurrect + tmux-continuum, saves every 15 min)
- **Seamless navigation** between neovim panes and tmux panes via vim-tmux-navigator

### Neovim Configuration (hand-configured lazy.nvim, not LazyVim)
Entry point: `nvim/.config/nvim/init.lua` → bootstraps lazy.nvim via `lua/config/lazy.lua`, which loads
`lua/config/options.lua`, then every spec under `lua/plugins/*.lua` (one file per plugin/concern), then
`lua/config/keymaps.lua` and `lua/config/autocmds.lua`.

- `lua/config/keymaps.lua` — leader-based keybindings (e.g., Markdown→PDF export via pandoc/weasyprint, date insert)
- `lua/config/options.lua` — core `vim.opt` settings, leader key, spelllang (en/es/ca)
- `lua/config/autocmds.lua` — yank highlight, prose wrap/spell, trailing-whitespace trim
- `lua/plugins/lsp.lua` — nvim-lspconfig + mason for lua, python, ts/js, bash, go, rust, markdown
- `lua/plugins/treesitter.lua`, `completion.lua` (blink.cmp), `formatting.lua` (conform.nvim)
- `lua/plugins/telescope.lua` + `oil.lua` — finding/editing files
- `lua/plugins/gitsigns.lua`, `statusline.lua` (lualine), `which-key.lua`, `colorscheme.lua` (catppuccin)
- `lua/plugins/tmux-navigator.lua` — vim-tmux-navigator, since LazyVim no longer provides it implicitly

### Tmux Configuration
- Plugin manager: **tpm** (`~/.tmux/plugins/tpm`)
- Plugins: vim-tmux-navigator, tmux-resurrect, tmux-continuum, tmux-cpu-mem-monitor
- Theme: `~/.config/tmux/nord-theme.conf` with CPU/memory/disk stats in status bar

### Wezterm Configuration
Single Lua file: `wezterm/.config/wezterm/wezterm.lua`
- Font: JetBrains Mono
- Session resurrection via built-in plugin
- Tab/pane management with CTRL-A prefix (mirrors tmux muscle memory)

### SSH
`ssh/.ssh/config` uses macOS Keychain (`UseKeychain yes`, `AddKeysToAgent yes`). Private keys are gitignored.

## Sensitive Files

The following are gitignored and must never be committed:
- `ssh/.ssh/id_*` (private and public keys)
- `ssh/.ssh/known_hosts`
- `ssh/.ssh/authorized_keys`
