# xguardi dotfiles

My personal configuration files for macOS, kept in one place and deployed with
[GNU Stow](https://www.gnu.org/software/stow/). Every config is edited here and symlinked
into `$HOME`, so changes are versioned and work the same on every machine.

## What's inside

| Package    | Tool                         | Deployed to                            |
|------------|------------------------------|----------------------------------------|
| `zsh`      | Z shell                      | `~/.zshenv`, `~/.zshrc`                |
| `nvim`     | Neovim (lazy.nvim)           | `~/.config/nvim/`                      |
| `tmux`     | tmux + tpm plugins           | `~/.tmux.conf`, `~/.config/tmux/`      |
| `wezterm`  | WezTerm terminal             | `~/.config/wezterm/`                   |
| `starship` | Shell prompt                 | `~/.config/starship.toml`              |
| `ssh`      | SSH client config (no keys)  | `~/.ssh/config`                        |
| `styles`   | CSS for Markdown → PDF export| used in place, not stowed              |

Supporting files:

- `Brewfile` – Homebrew packages, casks and fonts the configs rely on, plus everyday tools.
- `install.sh` – idempotent bootstrap: Homebrew, `Brewfile`, stow, tmux and Neovim plugins.
- `how-to.md` – keybinding and usage cheat sheet.

Shared conventions: Nord colours everywhere, `CTRL-A` as the prefix in both tmux and
WezTerm, vi keybindings in zsh/tmux/WezTerm, and seamless Neovim ↔ tmux pane navigation.

## How it works

Each top-level directory is a stow *package* that mirrors the layout of `$HOME`.
For example `nvim/.config/nvim/init.lua` becomes `~/.config/nvim/init.lua`:

```bash
cd ~/dotfiles
stow nvim            # create the symlinks for one package
stow -R nvim         # re-link after adding or renaming files
stow -D nvim         # remove the symlinks
```

## Setup

On a fresh machine:

```bash
git clone https://github.com/xguardi/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

On a machine that already has the tools, just link what you need:

```bash
cd ~/dotfiles && stow zsh nvim tmux starship wezterm ssh
```

Then, once per machine:

- Put secrets and machine-specific settings in `~/.zshrc.local` (sourced by `.zshrc`, never tracked).
- Set up an SSH key or `gh auth login` for GitHub access.
- macOS: map Caps Lock → Control, and disable the `Ctrl+Space` input-source shortcut.

## Working with this repo

- **Edit a config:** edit the file under `~/dotfiles` (or through its symlink) and commit.
- **Add a new tool:** create `<tool>/` mirroring the path under `$HOME`, move the config in,
  run `stow <tool>`, and add it to `PACKAGES` in `install.sh` and to the table above.
- **Add a Homebrew dependency:** add a `brew`/`cask` line to `Brewfile`, then `brew bundle`.
- **Update plugins:** `prefix + U` in tmux; `:Lazy update` in Neovim (commit `lazy-lock.json`).

## Never commit

SSH keys, `known_hosts`, tokens and anything in `~/.zshrc.local`. `.gitignore` covers the
known cases. Keep `~/.ssh` and `~/.config` as real directories so stow links individual files
instead of pulling whole directories into the repo.
