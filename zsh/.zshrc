# zsh completion system loads completion functions from the directories listed in $fpath variable
fpath=($HOME/.zsh-completions $fpath)
# initialize autocomplete
autoload -U compinit; compinit

# uv autocomplete
command -v uv >/dev/null && eval "$(uv generate-shell-completion zsh)"

# History (set here, not in .zshenv: macOS /etc/zshrc would override it)
HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_DUPS

# Activate vi mode!
bindkey -v
export KEYTIMEOUT=1

# GnuPG: let gpg find the current terminal (also inside tmux)
export GPG_TTY=$(tty)
command -v gpg-connect-agent >/dev/null && gpg-connect-agent updatestartuptty /bye >/dev/null

# aliases ===
alias vi="nvim"
alias r=". ranger"
alias ls="eza"
alias ll="eza -l"
alias la="eza --all"
alias l="ll"
alias lg="lazygit"

# Google Cloud SDK (Homebrew cask)
GCLOUD_SDK="/opt/homebrew/share/google-cloud-sdk"
[ -f "$GCLOUD_SDK/path.zsh.inc" ] && source "$GCLOUD_SDK/path.zsh.inc"
[ -f "$GCLOUD_SDK/completion.zsh.inc" ] && source "$GCLOUD_SDK/completion.zsh.inc"
unset GCLOUD_SDK

# Starship
command -v starship >/dev/null && eval "$(starship init zsh)"

# Activate syntax highlighting
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  # Disable underline
  (( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
  ZSH_HIGHLIGHT_STYLES[path]=none
  ZSH_HIGHLIGHT_STYLES[path_prefix]=none
fi

# Activate autosuggestions
[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# uv env
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Windsurf
[ -d "$HOME/.codeium/windsurf/bin" ] && export PATH="$HOME/.codeium/windsurf/bin:$PATH"

# >>> conda initialize >>>
# Cached output of 'conda shell.zsh hook' -- regenerate with:
#   conda shell.zsh hook > ~/.cache/zsh/conda-hook.zsh
# after any conda upgrade. Avoids spawning a Python interpreter on every shell startup.
if [ -f "$HOME/.cache/zsh/conda-hook.zsh" ]; then
    source "$HOME/.cache/zsh/conda-hook.zsh"
elif [ -x /opt/homebrew/Caskroom/miniconda/base/bin/conda ]; then
    __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    elif [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
    unset __conda_setup
fi
# <<< conda initialize <<<

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# Machine-local secrets, not tracked by git
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
