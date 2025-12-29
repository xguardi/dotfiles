zmodload zsh/zprof

# zsh completion system loads completion functions from the directories listed in $fpath variable
fpath=($HOME/.zsh-completions $fpath)
# initialize autocomplete
autoload -U compinit; compinit

# uv autcomplete
eval "$(uv generate-shell-completion zsh)"

# Activate vi mode!
bindkey -v
export KEYTIMEOUT=1

# for tmux to find gpg
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
# GNUPG
GPG_TTY=`tty`
export GPG_TTY

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/xavier.guardiola/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/xavier.guardiola/Downloads/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/xavier.guardiola/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/xavier.guardiola/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Starship
eval "$(starship init zsh)"

# Activate syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# # Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Activate autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

. "$HOME/.local/bin/env"

# Added by Windsurf
export PATH="/Users/xavier.guardiola/.codeium/windsurf/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# OSBC libs
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
