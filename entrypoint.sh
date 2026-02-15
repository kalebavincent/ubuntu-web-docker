#!/bin/bash
export USER=ubuntuweb
export HOME=/home/ubuntuweb

# Initialisation du dossier .vnc
mkdir -p $HOME/.vnc
echo "ubuntuweb" | vncpasswd -f > $HOME/.vnc/passwd
chmod 600 $HOME/.vnc/passwd

# Configuration du fichier xstartup pour XFCE4
cat <<EOF > $HOME/.vnc/xstartup
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
/usr/bin/startxfce4 &
EOF
chmod +x $HOME/.vnc/xstartup

# Nettoyage des anciens fichiers de lock (utile au redémarrage dans Codespaces)
vncserver -kill :1 || true
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1

# Démarrer le serveur VNC
vncserver :1 -geometry 1280x720 -depth 24

# Attendre que VNC soit prêt
sleep 2

# Démarrer noVNC sur le port 6080
/usr/share/novnc/utils/launch.sh --vnc localhost:5901 --listen 6080 &

tail -f /dev/null
