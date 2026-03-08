# dotfiles

macOS dotfiles for zsh, Oh My Posh, tmux (Oh My Tmux), and dircolors.

## Structure

```
.
├── .config/
│   └── oh-my-posh/
│       ├── base.toml              # Prompt structure (segments, tooltips, templates)
│       ├── sesame.omp.json        # Active theme (extends base.toml, defines color palette)
│       └── default.toml           # Alternate theme
├── .dircolors/
│   ├── one-dark.dircolors         # One Dark LS_COLORS theme
│   └── ls_colors.sh              # Pre-compiled fallback
├── .gitconfig                     # Git configuration
├── .gitignore                     # Global gitignore
├── .tmux.conf.local              # Tmux customizations (Oh My Tmux overrides)
├── .zprofile                      # Login shell: PATH, env vars, Homebrew
├── .zshrc                         # Interactive shell: aliases, completions, prompt init
├── CLAUDE.md                      # Claude Code project instructions
└── update.sh                      # Sync live config into this repo
```

## Dependencies

Install via Homebrew:

```bash
brew install coreutils python neovim oh-my-posh tmux
```

A [Nerd Font](https://www.nerdfonts.com/) is required for powerline glyphs and icons:

```bash
oh-my-posh font install meslo
```

## Setup

### 1. Clone the repo

```bash
git clone https://github.com/imdinu/dotfiles.git ~/Documents/Dev/imdinu-dotfiles
cd ~/Documents/Dev/imdinu-dotfiles
```

### 2. Copy shell config

```bash
cp .zshrc ~/.zshrc
cp .zprofile ~/.zprofile
cp .gitconfig ~/.gitconfig
cp .gitignore ~/.gitignore
```

### 3. Set up Oh My Posh

```bash
mkdir -p ~/.config/oh-my-posh
cp .config/oh-my-posh/* ~/.config/oh-my-posh/
```

### 4. Set up dircolors

```bash
cp -r .dircolors ~/.dircolors
```

### 5. Set up tmux (Oh My Tmux)

```bash
# Clone Oh My Tmux
mkdir -p ~/.config/tmux
git clone https://github.com/gpakosz/.tmux.git ~/.config/tmux/oh-my-tmux

# Create symlinks
ln -sf ~/.config/tmux/oh-my-tmux/.tmux.conf ~/.tmux.conf
ln -sf ~/.config/tmux/oh-my-tmux/.tmux.conf.local ~/.tmux.conf.local

# Copy customizations over the default .tmux.conf.local
cp .tmux.conf.local ~/.config/tmux/oh-my-tmux/.tmux.conf.local
```

### 6. Restart shell

```bash
exec zsh
```

## Syncing changes

After making changes to your live config, pull them into the repo:

```bash
./update.sh
```

This copies files from `$HOME` into the repo. To apply repo changes back to the live system, reverse the copy steps above.

## Oh My Posh theme architecture

The prompt uses a **base + theme** pattern via Oh My Posh's `extends` feature:

- **`base.toml`** defines all structure: segments, blocks, tooltips, transient/secondary prompts
- **`sesame.omp.json`** extends the base and only defines the color palette

To create a new theme, copy `sesame.omp.json`, change the palette hex values, and point `.zshrc` at it.

### Tooltips

Contextual segments that appear on the right when you type specific commands:

| Command | Shows |
|---------|-------|
| `git`, `g` | Branch, status, stash |
| `docker`, `docker-compose` | Docker context |
| `python`, `pip`, `uv` | Python version + venv |
| `aws` | Profile + region |
| `gcloud`, `gsutil` | GCP project + account |
| `terraform`, `tf` | Workspace + version |
| `lua`, `luarocks` | Lua version |
