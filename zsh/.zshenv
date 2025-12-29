#!/usr/bin/env zsh

# ========================================================
# EXPORT ENVIRONMENT VARIABLES
# Keep this file clean and you'll become a prosperous man!
# ========================================================

# PATH ===
# base path is build from /etc/paths
#
export PATH="$PATH:$HOME/bin"             # Custom scripts
export PATH="$PATH:/Library/TeX/texbin"   # Latex stuff
homebrew=/opt/homebrew/bin/
export PATH=$homebrew:$PATH               # PATH: homebrew packages
export PATH="$PATH:$HOME/.local/bin"      # PATH: uv 

# editor
export EDITOR=vim

# zsh
export HISTFILE="$ZDOTDIR/.zhistory"      # History filepath
export HISTSIZE=10000                     # Maximum events for internal history
export SAVEHIST=10000                     # Maximum events in history file

# aliases ===

# editor
alias vi="nvim"

# ranger
alias r=". ranger"

# eza, a better ls
alias ls="eza"
alias ll="eza -l"
alias la="eza --all"
alias l="ll"

# lazygit
alias lg="lazygit"
