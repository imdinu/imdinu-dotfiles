# Add GNU coreutils and python symlinks to PATH
export PATH="$(brew --prefix python)/libexec/bin:$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export PATH="$PATH:/Users/idinu/.local/bin"

# Alias ls to use GNU ls with color support
alias ls='ls --color=auto'
alias vim='nvim'
alias nvimtex='nvim --listen /tmp/nvim'

# Incremental history search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Autocomplete configuration
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Case insensitive matching
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# Apply dircolors theme
eval "$(dircolors ~/.dircolors/one-dark.dircolors)"

#eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/capr4n.omp.json)"
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/sesame.omp.json)"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/idinu/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
