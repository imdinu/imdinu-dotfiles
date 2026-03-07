
eval "$(/opt/homebrew/bin/brew shellenv)"

# Source secrets (API keys, tokens)
source ~/.secrets 2>/dev/null || :

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Go
export GOPATH="$HOME/.go"

# Disable less history file
export LESSHISTFILE=-

# NLTK data
export NLTK_DATA="$HOME/.nltk_data"

# Use .venv.nosync for uv so iCloud Drive ignores virtualenvs
export UV_PROJECT_ENVIRONMENT=".venv.nosync"

# GNU coreutils and python
export PATH="/opt/homebrew/opt/python@3/libexec/bin:/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Added by Obsidian
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"
