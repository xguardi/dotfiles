#!/usr/bin/env bash
# Bootstrap a new Mac from this dotfiles repo. Safe to re-run.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES=(zsh nvim tmux starship wezterm ssh)

# 1. Xcode Command Line Tools (git, make, compilers)
if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
  echo "Re-run this script once the Command Line Tools finish installing."
  exit 1
fi

# 2. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# 3. Packages
brew bundle --file="$DOTFILES/Brewfile"

# 4. uv (installed outside Homebrew; provides ~/.local/bin/env sourced by .zshrc)
command -v uv >/dev/null 2>&1 || curl -LsSf https://astral.sh/uv/install.sh | sh

# 5. Real directories so stow links files inside them instead of folding the
#    whole directory into the repo (keeps SSH keys/sockets out of the repo).
mkdir -p "$HOME/.config" "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# 6. Symlinks
stow --dir="$DOTFILES" --target="$HOME" --restow "${PACKAGES[@]}"

# 7. tmux plugins via tpm
TPM="$HOME/.config/tmux/plugins/tpm"
if [ ! -d "$TPM" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM"
fi
# tpm needs a running tmux server with ~/.tmux.conf loaded
tmux new-session -d -s __bootstrap
"$TPM/bin/install_plugins"
tmux kill-session -t __bootstrap

# 8. Neovim plugins (lazy.nvim, pinned by lazy-lock.json)
nvim --headless "+Lazy! restore" +qa

# 9. SSH key for GitHub
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  echo "No SSH key found. Create one and add it to GitHub:"
  echo "  ssh-keygen -t ed25519 -C \"you@example.com\""
  echo "  ssh-add --apple-use-keychain ~/.ssh/id_ed25519"
  echo "  gh auth login && gh ssh-key add ~/.ssh/id_ed25519.pub"
fi

echo "Done. Put machine-specific secrets in ~/.zshrc.local and open a new shell."
