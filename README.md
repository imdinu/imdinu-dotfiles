# dotfiles

macOS dotfiles for Ghostty, zsh, Oh My Posh, tmux (Oh My Tmux), and dircolors.

## Structure

```
.
├── .config/
│   ├── ghostty/
│   │   ├── config.ghostty         # Terminal: font, Sesame theme, opacity, cell height
│   │   └── themes/Sesame          # Sesame brand palette (matches sesame.omp.json)
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
brew install --cask ghostty
```

### Font: OperatorMonoLig Nerd Font

The terminal font is Operator Mono with ligatures ([operator-mono-lig](https://github.com/kiliman/operator-mono-lig)), patched with the [Nerd Fonts](https://www.nerdfonts.com/) glyphs for the prompt's powerline separators and icons. Operator Mono is a commercial font, so the font files are not part of this repo.

Patch the four ligature builds (Book, Book Italic, Light, Light Italic) with the official patcher image:

```bash
mkdir -p in out
cp ~/Library/Fonts/OperatorMonoLig-*.otf in/
docker run --rm -v "$PWD/in:/in" -v "$PWD/out:/out" nerdfonts/patcher --complete --careful
cp out/OperatorMonoLigNerdFont-*.otf ~/Library/Fonts/
```

The patched family is `OperatorMonoLig Nerd Font`. The patcher renames the styles: Book becomes **Regular** and Book Italic becomes **Italic**. Ligatures (`calt`) and stylistic sets carry over unchanged.

## Setup

### 1. Clone the repo

```bash
git clone https://github.com/imdinu/imdinu-dotfiles.git ~/Documents/Dev/imdinu-dotfiles
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

### 6. Set up Ghostty

```bash
mkdir -p ~/.config/ghostty
cp -r .config/ghostty/* ~/.config/ghostty/
```

Ghostty reads `~/.config/ghostty/config.ghostty`. Keep no second config in `~/Library/Application Support/com.mitchellh.ghostty/`: Ghostty loads that one too, after this one, so its values win.

### 7. Restart shell

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

Oh My Posh caches the parsed config. After editing `base.toml`, run `oh-my-posh cache clear` or the old values keep rendering.

The window title comes from `console_title_template` in `base.toml` (plain `{{ .Folder }}`). Ghostty's macOS title bar adds its own folder proxy icon next to it.

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

## Ghostty

`config.ghostty` mirrors the iTerm profile this setup came from:

| Setting | Value | Why |
|---|---|---|
| `font-family` | `OperatorMonoLig Nerd Font` (Regular / Italic) | Ligatures plus prompt glyphs in one font |
| `window-title-font-family` | same | Renders Nerd Font glyphs in the title bar |
| `theme` | `Sesame` | Same hex palette as `sesame.omp.json`, so prompt segments blend with the terminal |
| `font-size` / `adjust-cell-height` | `14` / `12%` | Size and 1.12 line height |
| `background-opacity` | `0.88` | 12% transparency (needs a full restart to apply) |
| `font-thicken` | `true` | Heavier strokes, closer to iTerm's rendering |
| `cursor-style` | block, no blink | |

In Ghostty, paste images into Claude Code with **Ctrl+V**; ⌘V pastes text only.

With the `transparent` title bar, macOS native tabs make the window title always equal the selected tab's title. Use tmux windows instead of Ghostty tabs to keep a single title.

## tmux terminal integration

`.tmux.conf.local` enables what Ghostty and Claude Code need inside tmux:

```tmux
set -g allow-passthrough on                  # escape sequences reach Ghostty (notifications, images, titles)
set -g focus-events on                       # pane focus in/out reported to programs
set -s extended-keys on                      # distinguish Shift+Enter etc.
set -as terminal-features 'xterm*:extkeys'   # Ghostty (xterm-ghostty) supports extended keys
```

Oh My Tmux only turns on `extended-keys` when the server starts from iTerm or mintty, so it is set explicitly here.
