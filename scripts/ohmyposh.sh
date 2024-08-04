#!/bin/bash

## Author : GiGiDKR
## Date   : 21/07/2024
## Rev    : 1.0.0

## A script to install oh-my-posh with a Nerd Font in Termux terminal emulator

clear

pkg update -y

clear
echo "Installation Nerd Font "

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf
cp ~/.local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf ~/.termux/font.ttf

clear
echo "Installation oh-my-posh "
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d  /data/data/com.termux/files/usr/bin

if [ ! -f ~/.bashrc ]; then
    echo "Création du fichier .bashrc"
    touch ~/.bashrc
fi

if ! grep -q 'eval "$(./oh-my-posh init bash)"' ~/.bashrc; then
    echo 'eval "$(./oh-my-posh init bash)"' >> ~/.bashrc
fi

if [ ! -f ~/.zshrc ]; then
    echo "Création du fichier .zshrc"
    touch ~/.zshrc
fi

if ! grep -q 'eval "$(./oh-my-posh init zsh)"' ~/.zshrc; then
    echo 'eval "$(./oh-my-posh init zsh)"' >> ~/.zshrc
fi

echo "Configuration terminée !"
termux-reload-settings