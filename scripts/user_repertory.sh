#!/bin/bash

# Couleurs pour le texte
YELLOW='\033[0;33m'
RESET='\033[0m' # No Color

# Fonction pour centrer et colorer une ligne de texte
center_color_text() {
    local text="$1"
    local color="$2"
    local width=$(stty size | awk '{print $2}')
    local padding=$(( (width - ${#text}) / 2 ))
    printf "%*s${color}%s${RESET}\n" $padding '' "$text"
}

# Fonction pour afficher la bannière
display_banner() {
    banner=$(cat << 'EOF'
  ____  __     __  ___       ______                       
 / __ \/ /    /  |/  /_ __  /_  __/__ ______ _  __ ____ __
/ /_/ / _ \  / /|_/ / // /   / / / -_) __/  ' \/ // /\ \ /
\____/_//_/ /_/  /_/\_, /   /_/  \__/_/ /_/_/_/\_,_//_\_\ 
                   /___/                                  
EOF
)
    while IFS= read -r line; do
        center_color_text "$line" "$YELLOW"
    done <<< "$banner"
}

# Fonction pour créer les liens symboliques
create_symlinks() {
    center_color_text "Création des répertoires utilisateur ..." "$YELLOW"
    cd $HOME
    ln -s $HOME/storage/downloads "📂 Téléchargement"
    ln -s $HOME/storage/pictures "🖼️ Images"
    ln -s $HOME/storage/dcim "📸 Photos"
    ln -s $HOME/storage/movies "🎥 Vidéos"
    ln -s $HOME/storage/music "🎵 Musique"
    ln -s $HOME/storage/documents "📄 Documents"
    ln -s $HOME/storage/shared "📁 Stockage Interne"
    center_color_text "Répertoires utilisateur créés avec succès !" "$YELLOW"
}

# Fonction pour supprimer les liens symboliques
remove_symlinks() {
    center_color_text "Suppression des liens symboliques des répertoires utilisateur ..." "$YELLOW"
    cd $HOME
    rm "📂 Téléchargement"
    rm "🖼️ Images"
    rm "📸 Photos"
    rm "🎥 Vidéos"
    rm "🎵 Musique"
    rm "📄 Documents"
    rm "📁 Stockage Interne"
    center_color_text "Liens symboliques supprimés avec succès !" "$YELLOW"
}

# Afficher la bannière
clear
display_banner

# Vérifier le paramètre --uninstall
if [[ "$1" == "--uninstall" ]]; then
    remove_symlinks
else
    create_symlinks
fi