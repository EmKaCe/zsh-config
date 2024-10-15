#!/bin/bash

function install_pkg() {
  /usr/bin/paru -S "$@" --noconfirm --sudoloop
}

# This script is used to install software for endeavourOS running on KDE.

# Update system
sudo pacman -Syu --noconfirm

# Remove yay and replace it with paru
sudo pacman -R yay --noconfirm
sudo pacman -S paru --noconfirm

# Docker
## Docker: Install
install_pkg docker docker-compose oxker
## Docker: Permissions
sudo groupadd docker
sudo usermod -aG docker $USER

# ZSH
## ZSH: P10K Font
install_pkg ttf-meslo-nerd-font-powerlevel10k
## ZSH: Antidote
install_pkg zsh-antidote
## ZSH: P10K
install_pkg zsh-theme-powerlevel10k-git
## ZSH: Install plugin dependencies
install_pkg pyenv pyenv-virtualenv tk pnpm bat bat-extras eza go python-poetry thefuck wl-clipboard

# Flatpak
## Flatpak: install
install_pkg flatpak

## Flatpak: Enable auto updates
systemctl --user enable --now update-user-flatpaks.timer
sudo systemctl --system enable --now update-system-flatpaks.timer

# ZSH:
## ZSH: Add config files
ln -s $PWD/zshrc $HOME/.zshrc
ln -s $PWD/p10k.zsh $HOME/.p10k.zsh
ln -s $PWD/zsh_plugins.txt $HOME/.zsh_plugins.txt

# Git
## Git: Add gitconfig
ln -s gitconfig $HOME/.gitconfig

## ZSH: Set default shell to ZSH
sudo chsh -s /usr/bin/zsh $USER
