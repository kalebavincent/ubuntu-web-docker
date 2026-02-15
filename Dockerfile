# Utiliser Ubuntu 20.04 comme base (correspond au projet Ubuntu Web original)
FROM ubuntu:20.04

# Éviter les invites interactives pendant l'installation
ENV DEBIAN_FRONTEND=noninteractive

# Installer les dépendances système, le bureau et les outils de construction d'ISO
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies \
    vnc4server novnc python3-websockify python3-numpy \
    wget curl make mtools xorriso squashfs-tools \
    git neofetch \
    sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configurer l'utilisateur principal avec sudo sans mot de passe
RUN useradd -m -s /bin/bash ubuntuweb && \
    echo "ubuntuweb:ubuntuweb" | chpasswd && \
    adduser ubuntuweb sudo && \
    echo "ubuntuweb ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Préparer noVNC
RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# Copier le script de branding
COPY setup_branding.sh /usr/local/bin/setup_branding.sh
RUN chmod +x /usr/local/bin/setup_branding.sh && /usr/local/bin/setup_branding.sh

# Configurer l'environnement de travail
WORKDIR /home/ubuntuweb/iso-builder
RUN chown ubuntuweb:ubuntuweb /home/ubuntuweb/iso-builder

# Copier et configurer le script d'entrée
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Exposer les ports VNC et noVNC
EXPOSE 5901 6080

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
