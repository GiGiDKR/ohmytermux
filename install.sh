#!/bin/bash

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RESET='\033[0m' # No Color

# Variable pour la bannière
banner=$(cat << 'EOF'
  ____  __     __  ___       ______                       
 / __ \/ /    /  |/  /_ __  /_  __/__ ______ _  __ ____ __
/ /_/ / _ \  / /|_/ / // /   / / / -_) __/  ' \/ // /\ \ /
\____/_//_/ /_/  /_/\_, /   /_/  \__/_/ /_/_/_/\_,_//_\_\ 
                   /___/                                  
EOF
)

# Fonction pour centrer et colorer une ligne de texte
center_color_text() {
    local text="$1"
    local color="$2"
    local width=$(( (COLUMNS - ${#text}) / 2 ))
    printf "%*s${color}%s${RESET}\n" $width '' "$text"
}

# Fonction pour afficher la bannière
display_banner() {
    # Obtenir la largeur du terminal
    COLUMNS=$(tput cols)
    while IFS= read -r line; do
        center_color_text "$line" "$BLUE"
    done <<< "$banner"
}

# Afficher la bannière centrée et colorée au début du script
display_banner

# Ne pas arrêter le script en cas d'erreur
# set -e

echo ""
# Demande d'accès au stockage externe
read -p "Appuyez sur Entrée pour accorder l'accès au stockage externe ..."
termux-setup-storage

# Afficher la bannière avant la sélection du répertoire de sources Termux
clear
display_banner
read -p "Appuyez sur Entrée pour sélectionner un repository ..."
termux-change-repo

# Mise à jour de Termux
clear
display_banner
read -p "Appuyez sur Entrée pour exécuter l'installation de Termux ..."
pkg update -y && pkg upgrade -y

# Installation des packages Termux
clear
display_banner
pkg install -y wget git zsh curl nala eza lf fzf bat unzip lsd

clear
echo -e "${BLUE}Termux à jour et packages installés !${RESET}"
echo ""
read -p "Appuyez sur Entrée pour configurer Termux ..."

cd ~/
clear
display_banner
echo -e "${YELLOW}Création des répertoires utilisateur ...${RESET}"
ln -s $HOME/storage/downloads "📂 Téléchargement"
ln -s $HOME/storage/pictures "🖼️ Images"
ln -s $HOME/storage/dcim "📸 Photos"
ln -s $HOME/storage/movies "🎥 Vidéos"
ln -s $HOME/storage/music "🎵 Musique"
ln -s $HOME/storage/documents "📄 Documents"
ln -s $HOME/storage/shared "📁 Stockage Interne"

# Suppression du message de bienvenue par défaut de Termux
rm -f $PREFIX/etc/motd

# Copier les fichiers de configuration personnalisés
cp -r $HOME/OhMyTermux/src/* $HOME/.termux/

# Définir les répertoires de couleurs et de polices
COLORS_DIR_TERMUXSTYLE=$HOME/.termux/colors/termuxstyle
COLORS_DIR_TERMUX=$HOME/.termux/colors/termux
COLORS_DIR_XFCE4TERMINAL=$HOME/.termux/colors/xfce4terminal

mkdir -p $HOME/.termux/fonts
FONTS_DIR_POWERLINE=$HOME/.termux/fonts/fonts_powerline
FONTS_DIR_TERMUXSTYLE=$HOME/.termux/fonts/fonts_termuxstyle

# Décompression des fichiers ZIP
clear
display_banner
echo -e "${GREEN}Décompression des archives ...${RESET}"
unzip -o "$HOME/.termux/fonts_termuxstyle.zip" -d "$HOME/.termux/fonts"
unzip -o "$HOME/.termux/colors.zip" -d "$HOME/.termux/"

# Installation de Oh-My-Zsh et des plugins
clear
display_banner
read -p "Appuyez sur Entrée pour installer Oh-My-Zsh et des plugins ..."

# Vérifier et supprimer les répertoires existants
for dir in "$HOME/.oh-my-zsh" \
           "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" \
           "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" \
           "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" \
           "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" \
           "$HOME/.oh-my-zsh/custom/plugins/you-should-use" \
           "$HOME/.oh-my-zsh/custom/plugins/zsh-abbr" \
           "$HOME/.oh-my-zsh/custom/plugins/zsh-alias-finder"; do
    if [ -d "$dir" ]; then
        echo -e "${RED}Le répertoire $(basename $dir) existe déjà. Suppression...${RESET}"
        rm -rf "$dir"
    fi
done

echo -e "${BLUE}Installation de Oh-My-Zsh ...${RESET}"
git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh" || true

echo -e "${YELLOW}Installation du thème powerlevel10k ...${RESET}"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" || true

echo -e "${GREEN}Installation des plugins ...${RESET}"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" || true
git clone https://github.com/zsh-users/zsh-completions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" || true
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use || true
git clone https://github.com/olets/zsh-abbr ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-abbr || true
git clone https://github.com/akash329d/zsh-alias-finder ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-alias-finder || true

echo -e "${BLUE}Configuration de Oh-My-Zsh ...${RESET}"
cp -f "$HOME/OhMyTermux/zshrc" "$HOME/.zshrc"
cp -f "$HOME/OhMyTermux/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"

echo -e "${YELLOW}Configuration du thème powerlevel10k ...${RESET}"
cp -f "$HOME/OhMyTermux/p10k.zsh" "$HOME/.p10k.zsh"

clear