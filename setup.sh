#!/bin/bash

echo "#####     OHMYTERMUX E    #####"
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

echo "Configuration de Termux ..."
mkdir -p $HOME/.termux
touch $HOME/.termux/termux.properties
sed -i '21s/^#//' $HOME/.termux/termux.properties
sed -i '128s/^#//' $HOME/.termux/termux.properties
sed -i '160s/^#//' $HOME/.termux/termux.properties
rm -f $PREFIX/etc/motd

COLORS_DIR_TERMUXSTYLE=$HOME/.config/OhMyTermux/color_schemes/termuxstyle
COLORS_DIR_TERMUX=$HOME/.config/OhMyTermux/color_schemes/termux
COLORS_DIR_XFCE4TERMINAL=$HOME/.config/OhMyTermux/color_schemes/xfce4terminal
FONTS_DIR_POWERLINE=$HOME/.config/OhMyTermux/fonts_powerline
FONTS_DIR_TERMUXSTYLE=$HOME/.config/OhMyTermux/fonts_termuxstyle

echo "Création des répertoires COLORS et FONTS"
mkdir -p $COLORS_DIR_TERMUXSTYLE $COLORS_DIR_TERMUX $COLORS_DIR_XFCE4TERMINAL $FONTS_DIR_POWERLINE $FONTS_DIR_TERMUXSTYLE

# Décompression des fichiers ZIP
echo "Décompression des fichiers ZIP ..."
unzip -o "$HOME/OhMyTermux/color_schemes.zip" -d "$HOME/.config/OhMyTermux/color_schemes"
unzip -o "$HOME/OhMyTermux/fonts.zip" -d "$HOME/.config/OhMyTermux"

# Copie des fichiers de couleurs
echo "Copie des fichiers de couleurs ..."
cp -r "$HOME/.config/OhMyTermux/color_schemes/termuxstyle" "$COLORS_DIR_TERMUXSTYLE"
cp -r "$HOME/.config/OhMyTermux/color_schemes/termux" "$COLORS_DIR_TERMUX"
cp -r "$HOME/.config/OhMyTermux/color_schemes/xfce4terminal" "$COLORS_DIR_XFCE4TERMINAL"
echo "Fichiers de couleurs copiés ..."

# Application du thème Tokyonight
echo "Copie du fichier de couleurs Tokyonight ..."
cp "$HOME/.config/OhMyTermux/color_schemes/termuxstyle/tokyonight.properties" "$HOME/.termux/colors.properties"
echo "Fichier de couleurs Tokyonight copié ..."

# Copie des polices
echo "Copie des polices de caractères ..."
cp -r "$HOME/.config/OhMyTermux/fonts_powerline" "$FONTS_DIR_POWERLINE"
cp -r "$HOME/.config/OhMyTermux/fonts_termuxstyle" "$FONTS_DIR_TERMUXSTYLE"
echo "Polices de caractères copiées ..."

# Application de la police DejaVu
echo "Copie de la police DejaVu ..."
cp "$HOME/.config/OhMyTermux/fonts_termuxstyle/DejaVu.ttf" "$HOME/.termux/font.ttf"
echo "Police DejaVu copiée ..."

# Installation de Oh-My-Zsh et des plugins
clear
read -p "Appuyez sur Entrée pour installer Oh-My-Zsh et une sélection de plugins ..."

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

echo "      Configuration terminée !     "
echo "#####     Liste des alias     #####"
bat "$HOME/.oh-my-zsh/custom/aliases.zsh"
read -p "Appuyez sur Entrée pour redémarrer ..."

clear
# Lancer zsh sans remplacer le shell actuel
zsh