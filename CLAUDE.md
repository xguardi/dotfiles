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
| `nvim/` | Neovim (LazyVim) | `.config/nvim/lua/` |
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

### Neovim Configuration (LazyVim-based)
Entry point: `nvim/.config/nvim/init.lua` → bootstraps LazyVim via `lua/config/lazy.lua`

Custom files layered on top of LazyVim:
- `lua/config/keymaps.lua` — custom keybindings (e.g., Markdown→PDF export via pandoc/weasyprint)
- `lua/config/options.lua` — option overrides
- `lua/plugins/custom.lua` — plugin additions/overrides (disables bufferline, noice, markdown-lint)

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
