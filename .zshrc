# Aliases
alias ls='ls --color=auto'
alias vim='nvim'
alias vimtex='nvim --listen /tmp/nvim'

# Export .env variables function
dotenv() {
  local file="${1:-.env}"
  [[ -f "$file" ]] || { echo "No $file found"; return 1 }
  set -a
  source "$file"
  set +a
}

# Deterministic password from service name: service-password <name>
service-password() {
    [[ -z "$1" ]] && { echo "Usage: service-password <service-name>"; return 1 }
    echo "$1" | shasum -a 256 | xxd -r -p | base64 | cut -c8-20
}

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Shell behavior
setopt AUTO_CD

# Incremental history search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Apply dircolors theme
eval "$(dircolors ~/.dircolors/one-dark.dircolors)"

# Autocomplete configuration
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Case insensitive matching
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# Prompt
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/sesame.omp.json)"

