#!/bin/bash
# ----------------------------------------------------- 
# Corporate & Daily App Installer (Refined)
# ----------------------------------------------------- 

PRIVILEGE_TOOL=$(command -v doas || command -v sudo)
AUR_HELPER=$(command -v paru || command -v yay)

if [ -z "$AUR_HELPER" ]; then
    echo "AUR helper not found. Installing paru..."
    $PRIVILEGE_TOOL pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/paru.git
    cd paru && makepkg -si && cd .. && rm -rf paru
    AUR_HELPER="paru"
fi

echo "Installing Corporate & Daily Apps..."

$AUR_HELPER -S --needed \
    microsoft-teams-bin \
    zoom \
    keepassxc \
    rclone \
    borg \
    vorta \
    trash-cli \
    safe-rm \
    steam \
    virt-manager \
    qemu-desktop \
    libvirt \
    dnsmasq \
    iptables-nft \
    gvfs-google \
    dolphin-plugins \
    lazygit \
    lazydocker \
    tldr \
    go-task

# Enable libvirt for virtualization
$PRIVILEGE_TOOL systemctl enable --now libvirtd
$PRIVILEGE_TOOL usermod -aG libvirt $USER

echo "Installation complete."
