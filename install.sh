#!/bin/bash

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonction pour afficher la bannière
banner() {
    echo -e "${YELLOW}========================================${NC}"
    echo -e "${GREEN}|              OHMYTERMUX              |${NC}"
    echo -e "${YELLOW}========================================${NC}"
    echo ""
}

# Arrêter le script en cas d'erreur
set -e

# Afficher la bannière
banner

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
pkg install -y wget git zsh curl nala eza lf fzf bat unzip lsd

clear
echo -e "${BLUE}Termux à jour et packages installés !${NC}"
echo ""
read -p "Appuyez sur Entrée pour configurer Termux ..."

cd ~/
clear
echo -e "${YELLOW}Création des répertoires utilisateur ...${NC}"
ln -s $HOME/storage/downloads "📂 Téléchargement"
ln -s $HOME/storage/pictures "🖼️ Images"
ln -s $HOME/storage/dcim "📸 Photos"
ln -s $HOME/storage/movies "🎥 Vidéos"
ln -s $HOME/storage/music "🎵 Musique"
ln -s $HOME/storage/documents "📄 Documents"
ln -s $HOME/storage/shared "📁 Stockage Interne"

rm -f $PREFIX/etc/motd

cp -r $HOME/OhMyTermux/src/* $HOME/.termux/

COLORS_DIR_TERMUXSTYLE=$HOME/.termux/colors/termuxstyle
COLORS_DIR_TERMUX=$HOME/.termux/colors/termux
COLORS_DIR_XFCE4TERMINAL=$HOME/.termux/colors/xfce4terminal

mkdir -p $HOME/.termux/fonts
FONTS_DIR_POWERLINE=$HOME/.termux/fonts/fonts_powerline
FONTS_DIR_TERMUXSTYLE=$HOME/.termux/fonts/fonts_termuxstyle

# Décompression des fichiers ZIP
clear
echo -e "${GREEN}Décompression des archives ...${NC}"
unzip -o "$HOME/.termux/fonts_termuxstyle.zip" -d "$HOME/.termux/fonts"
unzip -o "$HOME/.termux/colors.zip" -d "$HOME/.termux/"

# Installation de Oh-My-Zsh et des plugins
clear
read -p "Appuyez sur Entrée pour installer Oh-My-Zsh et des plugins ..."

# Vérifier et supprimer les répertoires existants
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${RED}Le répertoire .oh-my-zsh existe déjà. Suppression...${NC}"
    rm -rf "$HOME/.oh-my-zsh"
fi

if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo -e "${RED}Le répertoire powerlevel10k existe déjà. Suppression...${NC}"
    rm -rf "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    echo -e "${RED}Le répertoire zsh-autosuggestions existe déjà. Suppression...${NC}"
    rm -rf "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    echo -e "${RED}Le répertoire zsh-syntax-highlighting existe déjà. Suppression...${NC}"
    rm -rf "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
fi

if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" ]; then
    echo -e "${RED}Le répertoire zsh-completions existe déjà. Suppression...${NC}"
    rm -rf "$HOME/.oh-my-zsh/custom/plugins/zsh-completions"
fi

if [ -d "$HOME/.oh-my-zsh/custom/plugins/you-should-use" ]; then
    echo -e "${RED}Le répertoire you-should-use existe déjà. Suppression...${NC}"
    rm -rf "$HOME/.oh-my-zsh/custom/plugins/you-should-use"
fi

if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-abbr" ]; then
    echo -e "${RED}Le répertoire zsh-abbr existe déjà. Suppression...${NC}"
    rm -rf "$HOME/.oh-my-zsh/custom/plugins/zsh-abbr"
fi

if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-alias-finder" ]; then
    echo -e "${RED}Le répertoire zsh-alias-finder existe déjà. Suppression...${NC}"
    rm -rf "$HOME/.oh-my-zsh/custom/plugins/zsh-alias-finder"
fi

echo -e "${BLUE}Installation de Oh-My-Zsh ...${NC}"
git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh" || true

echo -e "${YELLOW}Installation du thème powerlevel10k ...${NC}"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" || true

echo -e "${GREEN}Installation des plugins ...${NC}"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" || true
git clone https://github.com/zsh-users/zsh-completions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" || true
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use || true
git clone https://github.com/olets/zsh-abbr ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-abbr || true
git clone https://github.com/akash329d/zsh-alias-finder ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-alias-finder || true

echo -e "${BLUE}Configuration de Oh-My-Zsh ...${NC}"
cp -f "$HOME/OhMyTermux/zshrc" "$HOME/.zshrc"
cp -f "$HOME/OhMyTermux/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"

echo -e "${YELLOW}Configuration du thème powerlevel10k ...${NC}"
cp -f "$HOME/OhMyTermux/p10k.zsh" "$HOME/.p10k.zsh"

clear
echo -e "${GREEN}Oh-My-Zsh installé !${NC}"
termux-reload-settings

echo -e "${BLUE}Définition de zsh comme shell par défaut ...${NC}"
chsh -s zsh

source ~/.zshrc

clear
echo -e "${GREEN} Installation de OhMyTermux terminée !${NC}"
echo ""
echo -e "${YELLOW}(⁠*⁠_⁠*⁠) Saisir 'help' pour des informations sur la configuration${NC}"
echo ""
read -p "Appuyez sur Entrée pour redémarrer ..."

rm -rf $HOME/OhMyTermux

clear
exec zsh