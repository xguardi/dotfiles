#!/usr/bin/env zsh

# ========================================================
# EXPORT ENVIRONMENT VARIABLES
# Keep this file clean and you'll become a prosperous man!
# Aliases and interactive settings live in .zshrc.
# ========================================================

# PATH ===
# base path is build from /etc/paths
#
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"  # homebrew packages
export PATH="$PATH:$HOME/bin"                             # Custom scripts
export PATH="$PATH:$HOME/.local/bin"                      # uv, pipx
export PATH="$PATH:/Library/TeX/texbin"                   # Latex stuff

# editor
export EDITOR=nvim
