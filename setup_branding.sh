#!/bin/bash

# Configuration du branding Ubuntu Web
echo "Application du branding Ubuntu Web..."

# 1. Mise à jour de /etc/os-release
cat <<EOF > /etc/os-release
NAME="Ubuntu Web"
VERSION="20.04.1 LTS (Focal Fossa)"
ID=ubuntuweb
ID_LIKE=ubuntu
PRETTY_NAME="Ubuntu Web 20.04.1 LTS"
VERSION_ID="20.04"
HOME_URL="https://ubuntu-web.org/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu-web"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
EOF

# 2. Configuration de neofetch (si présent)
if [ -f /usr/bin/neofetch ]; then
    mkdir -p /root/.config/neofetch
    cat <<EOF > /root/.config/neofetch/config.conf
print_info() {
    info title
    info underline
    info "OS" distro
    info "Host" model
    info "Kernel" kernel
    info "Uptime" uptime
    info "Packages" shell
    info "Resolution" resolution
    info "DE" de
    info "WM" wm
    info "Theme" theme
    info "Icons" icons
    info "Terminal" shell
    info "CPU" cpu
    info "GPU" gpu
    info "Memory" memory
}
distro_shorthand="off"
os_arch="on"
 package_managers="on"
EOF
fi

echo "Branding terminé."
