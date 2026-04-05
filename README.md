# dotfiles

Managed with [chezmoi](https://www.chezmoi.io/).

## Setup on a new machine

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply DamChan0 --source dot_file
```

## What's included

- **Shell**: zsh (oh-my-zsh + powerlevel10k), bash
- **Editor**: neovim (LazyVim)
- **Terminal**: zellij, starship
- **Tools**: btop, flameshot, fcitx5
- **Git**: credential helper via gh
