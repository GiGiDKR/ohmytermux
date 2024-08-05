#!/bin/bash

echo "#####     OHMYTERMUX     #####"
echo ""

# Demande d'accès au stockage externe
read -p "Appuyez sur Entrée pour accorder l'accès au stockage externe ..."
termux-setup-storage

# Sélection du répertoire de sources Termux
clear
read -p "Appuyez sur Entrée pour sélectionner un repository ..."
termux-change-repo

# Mise à jour de Termux
clear
read -p "Appuyez sur Entrée pour exécuter l'installation de Termux ..."
pkg update -y && pkg upgrade -y

# Installation des packages Termux
clear
pkg install -y wget git zsh curl nala eza lf fzf bat unzip

clear
écho "Termux à jour et packages installés !"
read -p "Appuyez sur Entrée pour configurer Termux ..."

cd ~/
clear
echo "Création des répertoires utilisateur ..."
#mkdir $HOME/Desktop
ln -s $HOME/storage/downloads "Téléchargement"
ln -s $HOME/storage/pictures "Images"
ln -s $HOME/storage/dcim "Photos"
ln -s $HOME/storage/movies "Vidéos"
ln -s $HOME/storage/music "Musique"
ln -s $HOME/storage/documents "Documents"
ln -s $HOME/storage/shared "Stockage Interne"

rm -f $PREFIX/etc/motd

cp -r $HOME/OhMyTermux/src/* $HOME/.termux/

COLORS_DIR_TERMUXSTYLE=$HOME/.termux/colors/termuxstyle
COLORS_DIR_TERMUX=$HOME/.termux/colors/termux
COLORS_DIR_XFCE4TERMINAL=$HOME/.termux/colors/xfce4terminal

mkdir $HOME/.termux/fonts
FONTS_DIR_POWERLINE=$HOME/.termux/fonts/fonts_powerline
FONTS_DIR_TERMUXSTYLE=$HOME/.termux/fonts/fonts_termuxstyle

# Décompression des fichiers ZIP
clear
echo "Décompression des archives ..."
unzip -o "$HOME/.termux/fonts_termuxstyle.zip" -d "$HOME/.termux/fonts"
unzip -o "$HOME/.termux/colors.zip" -d "$HOME/.termux/"

# Installation de Oh-My-Zsh et des plugins
clear
read -p "Appuyez sur Entrée pour installer Oh-My-Zsh et des plugins ..."

echo "Installation de Oh-My-Zsh ..."
git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"

clear
echo "Installation du thème powerlevel10k ..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"

clear
echo "Installation des plugins ..."
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-completions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-completions"
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
git clone https://github.com/olets/zsh-abbr ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-abbr
git clone https://github.com/akash329d/zsh-alias-finder ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-alias-finder

clear
echo "Configuration de Oh-My-Zsh ..."
cp -f "$HOME/OhMyTermux/zshrc" "$HOME/.zshrc"
cp -f "$HOME/OhMyTermux/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"

clear
echo "Configuration du thème powerlevel10k ..."
cp -f "$HOME/OhMyTermux/p10k.zsh" "$HOME/.p10k.zsh"

clear
echo "Oh-My-Zsh installé !"
termux-reload-settings

echo "Définition de zsh comme shell par défaut ..."
chsh -s zsh

source ~/.zshrc

clear
echo "(⁠^⁠^⁠) Installation de OhMyTermux terminée !"
echo ""
echo ("⁠*⁠_⁠*⁠) Saisir 'help' pour obtenir les informations sur la configuration"
écho ""
read -p "Appuyez sur Entrée pour redémarrer ..."

rm -rf $HOME/OhMyTermux

clear
exec zsh
