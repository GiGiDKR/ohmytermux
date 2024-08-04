#!/bin/bash

# Pour éviter un bug de dépôt
termux-change-repo

# Installer le x11-repo et mettre à jour tous les paquets
yes | pkg install x11-repo
yes | pkg update

# Accorder l'accès au stockage - (ne peut pas être exécuté avant d'installer x11-repo)
termux-setup-storage

# Installer l'accélération matérielle, l'interface graphique xfce4, le son et firefox
pkg install dbus pulseaudio virglrenderer-android -y
pkg install pavucontrol-qt firefox xfce4 -y

# Activer le son
echo "
pulseaudio --start --exit-idle-time=-1
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1
" > $HOME/.sound

# Déterminer le shell et ajouter les commandes appropriées au fichier de configuration
if [ "$SHELL" = "/bin/bash" ]; then
    echo "source $HOME/.sound" >> $HOME/.bashrc
    echo 'alias termux="am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity >/dev/null 2>&1 && sleep 1 && termux-x11 :3 -xstartup '\''dbus-launch --exit-with-session xfce4-session'\'' && startxfce4"' >> $HOME/.bashrc
    source $HOME/.bashrc
elif [ "$SHELL" = "/bin/zsh" ]; then
    echo "source $HOME/.sound" >> $HOME/.zshrc
    echo 'alias termux="am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity >/dev/null 2>&1 && sleep 1 && termux-x11 :3 -xstartup '\''dbus-launch --exit-with-session xfce4-session'\'' && startxfce4"' >> $HOME/.zshrc
    source $HOME/.zshrc
else
    echo "Shell non supporté : $SHELL"
    exit 1
fi

# Configurer termux pour autoriser les applications x11
pkg install termux-x11-nightly -y
sleep 3

TERMUX_PROPERTIES="$HOME/.termux/termux.properties"

if [ ! -f "$TERMUX_PROPERTIES" ]; then
  mkdir -p "$(dirname "$TERMUX_PROPERTIES")"
  touch "$TERMUX_PROPERTIES"
fi

if grep -q '^#\s*allow-external-apps\s*=\s*true' "$TERMUX_PROPERTIES"; then
  sed -i 's/^#\s*allow-external-apps\s*=\s*true/allow-external-apps = true/' "$TERMUX_PROPERTIES"
elif ! grep -q '^allow-external-apps\s*=\s*true' "$TERMUX_PROPERTIES"; then
  echo "allow-external-apps = true" >> "$TERMUX_PROPERTIES"
fi

# Activer PulseAudio sur le réseau
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

# Préparer la session termux-x11
export XDG_RUNTIME_DIR=${TMPDIR}

# Définir l'affichage sur :2 car Ubuntu utilise :0 et Debian utilise :1
termux-x11 :2 >/dev/null &

# Attendre un peu jusqu'à ce que termux-x11 démarre
sleep 3

# Se connecter à l'environnement
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1 && sleep 1 && termux-x11 :3 -xstartup "dbus-launch --exit-with-session xfce4-session" && startxfce4

exit 0