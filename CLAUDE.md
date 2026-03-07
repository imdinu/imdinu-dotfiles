# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

macOS dotfiles repository for zsh shell configuration, Oh My Posh prompt themes, and dircolors (ls color schemes). Targets macOS with Homebrew, GNU coreutils, and a Nerd Font-compatible terminal.

## Syncing Dotfiles

This repo uses **manual copy** (not symlinks). Files are copied from `$HOME` into the repo:

```bash
./update.sh    # copies ~/.zshrc, ~/.config/oh-my-posh/, ~/.dircolors/ into the repo
```

To apply changes to the live system, manually copy files back to `$HOME` (reverse of what `update.sh` does).

## Repository Structure

- `.zshrc` — Main shell config. Sets up GNU coreutils PATH, aliases (`ls`, `vim`/`nvim`), zsh completions, dircolors, and Oh My Posh prompt init.
- `.config/oh-my-posh/` — Prompt themes in TOML and JSON (Oh My Posh v3). `sesame.omp.json` is the active theme loaded by `.zshrc`. `base.toml` and `default.toml` are alternate/base themes.
- `.dircolors/` — `one-dark.dircolors` defines One Dark-themed LS_COLORS. `ls_colors.sh` is the pre-compiled export used as a fallback.

## Key Dependencies

- **Homebrew**: `coreutils`, `python`, `oh-my-posh`, `neovim`
- GNU `dircolors` (from coreutils) is used to compile `.dircolors` themes
- Oh My Posh prompt templates use Go template syntax with Nerd Font glyphs

## Conventions

- Oh My Posh themes use a shared color palette (black, blue, green, orange, red, white, yellow) — keep palette consistent when editing TOML themes.
- The `.config/oh-my-posh/oh-my-posh/` subdirectory is a duplicate of `.config/oh-my-posh/` (artifact of the copy script's `cp -r` behavior) — not intentional, can be ignored or cleaned up.
