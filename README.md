# xguardi dotfiles

macOS configuration for zsh, Neovim, tmux, WezTerm, Starship and SSH, deployed with
[GNU Stow](https://www.gnu.org/software/stow/).

## New Mac setup

```bash
xcode-select --install          # if git is not available yet
git clone https://github.com/xguardi/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

`install.sh` is safe to re-run. It installs Homebrew, every package in the `Brewfile` and `uv`,
symlinks all configs with stow, then installs tmux plugins (tpm) and Neovim plugins (lazy.nvim).

If you clone over HTTPS, switch to SSH once your key is on GitHub:
`git -C ~/dotfiles remote set-url origin git@github.com:xguardi/dotfiles.git`

### Manual steps

- Create an SSH key (the script prints the commands if `~/.ssh/id_ed25519` is missing).
- Put secrets and machine-specific settings in `~/.zshrc.local` (not tracked).
- Git identity: `git config --global user.name "…"` and `git config --global user.email "…"`.
- macOS settings:
  - Keyboard → Modifier Keys: Caps Lock → Control (for the `CTRL-A` prefix).
  - Keyboard Shortcuts → Input Sources: disable `Ctrl+Space`.
  - Set WezTerm as the default terminal and log in to `gh` and `copilot`.

## Updating

```bash
stow --restow zsh nvim tmux starship wezterm ssh   # relink after adding files
brew bundle dump --force --file=~/dotfiles/Brewfile # capture newly installed packages
```

See `how-to.md` for keybinding notes.
