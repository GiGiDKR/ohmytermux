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
read -p "Appuyez sur Entrée pour lancer la mise à jour de Termux ..."
pkg update -y && pkg upgrade -y

# Installation des packages Termux
clear
read -p "Appuyez sur Entrée pour installer les packages Termux ..."
pkg install -y wget git zsh curl nala eza lf fzf bat unzip

# Téléchargement des thèmes Termux
clear
read -p "Appuyez sur Entrée pour configurer graphiquement Termux ..."

echo "Création des répertoires utilisateur ..."
#mkdir $HOME/Desktop
mkdir $HOME/Downloads
#mkdir $HOME/Pictures
#mkdir $HOME/Videos
ln -s $HOME/storage/music Music 
ln -s $HOME/storage/documents Documents

COLORS_DIR_TERMUXSTYLE=$HOME/.termux/colors/termuxstyle
COLORS_DIR_TERMUX=$HOME/.termux/colors/termux
COLORS_DIR_XFCE4TERMINAL=$HOME/.termux/colors/xfce4terminal

mkdir $HOME/.termux/fonts
FONTS_DIR_POWERLINE=$HOME/.termux/fonts/fonts_powerline
FONTS_DIR_TERMUXSTYLE=$HOME/.termux/fonts/fonts_termuxstyle

# Décompression du fichier ZIP
echo "Décompression du fichier ZIP ..."
unzip -o "$HOME/OhMyTermux/src/colors.zip" -d "$HOME/.termux"
unzip -o "$HOME/OhMyTermux/src/fonts_termuxstyle.zip'" -d "$HOME/.termux/fonts"

# Installation de Oh-My-Zsh et des plugins
clear
read -p "Appuyez sur Entrée pour installer Oh-My-Zsh et des plugins ..."

echo "Installation de Oh-My-Zsh ..."
git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"

echo "Installation du thème powerlevel10k ..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"

echo "Installation des plugins ..."
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-completions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-completions"
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
git clone https://github.com/olets/zsh-abbr ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-abbr
git clone https://github.com/akash329d/zsh-alias-finder ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-alias-finder

echo "Configuration de Oh-My-Zsh ..."
cp -f "$HOME/OhMyTermux/zshrc" "$HOME/.zshrc"
cp -f "$HOME/OhMyTermux/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"

echo "Configuration du thème powerlevel10k ..."
cp -f "$HOME/OhMyTermux/p10k.zsh" "$HOME/.p10k.zsh"

echo "Oh-My-Zsh installé !"
termux-reload-settings

echo "Définition de zsh comme shell par défaut ..."
chsh -s zsh

source ~/.zshrc

clear
echo "      Configuration terminée !     "
echo "#####     Liste des alias     #####"
écho ""
bat "$HOME/.oh-my-zsh/custom/aliases.zsh"
echo ""
read -p "Appuyez sur Entrée pour redémarrer ..."

clear
exec zsh