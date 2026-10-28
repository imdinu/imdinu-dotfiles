# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

macOS dotfiles repository for the Ghostty terminal, zsh shell configuration, Oh My Posh prompt themes, tmux (Oh My Tmux), and dircolors (ls color schemes). Targets macOS with Homebrew, GNU coreutils, and the patched `OperatorMonoLig Nerd Font`.

## Syncing Dotfiles

This repo uses **manual copy** (not symlinks). `update.sh` copies live files from `$HOME` into the repo:

```bash
./update.sh    # ~/.zshrc, ~/.zprofile, ~/.gitconfig, ~/.config/{oh-my-posh,ghostty,git,gh}/, ~/.dircolors/, ~/.tmux.conf.local
```

To apply changes to the live system, copy files back to `$HOME` (reverse of what `update.sh` does).

## Repository Structure

- `.zshrc` — Main shell config. Aliases (`ls`, `vim`/`nvim`), history, zsh completions, dircolors, and Oh My Posh prompt init.
- `.config/ghostty/` — `config.ghostty` (font, opacity, cell height, cursor) and `themes/Sesame` (palette). Live path is `~/.config/ghostty/`.
- `.config/oh-my-posh/` — `base.toml` holds all prompt structure (segments, tooltips, `console_title_template`); `sesame.omp.json` extends it and defines the palette; `default.toml` is an alternate theme.
- `.tmux.conf.local` — Oh My Tmux overrides: theme, keybindings, terminal integration (passthrough, extended keys), tpm plugins. Live file is `~/.config/tmux/oh-my-tmux/.tmux.conf.local` (symlinked from `~/.tmux.conf.local`).
- `.dircolors/` — `one-dark.dircolors` defines One Dark-themed LS_COLORS. `ls_colors.sh` is the pre-compiled export used as a fallback.

## Key Dependencies

- **Homebrew**: `coreutils`, `python`, `oh-my-posh`, `neovim`, `tmux`, cask `ghostty`
- GNU `dircolors` (from coreutils) is used to compile `.dircolors` themes
- Oh My Posh prompt templates use Go template syntax with Nerd Font glyphs
- Font files are not in the repo (Operator Mono is commercial); README documents the Nerd Fonts patch

## Conventions

- The Sesame palette is shared by `sesame.omp.json` and Ghostty's `themes/Sesame` (identical hex values); the tmux theme in `.tmux.conf.local` reuses its green, yellow, red, and white. Keep shared values in sync when editing any of them.
- After editing Oh My Posh config, run `oh-my-posh cache clear`; the parsed config is cached.
- Validate Ghostty edits with `ghostty +validate-config`.
