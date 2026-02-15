#!/bin/bash
export USER=ubuntuweb
mkdir -p /home/ubuntuweb/.vnc
echo "ubuntuweb" | vncpasswd -f > /home/ubuntuweb/.vnc/passwd
chmod 600 /home/ubuntuweb/.vnc/passwd

# Démarrer le serveur VNC
vncserver :1 -geometry 1280x720 -depth 24
# Démarrer noVNC sur le port 6080
/usr/share/novnc/utils/launch.sh --vnc localhost:5901 --listen 6080 &

tail -f /dev/null
