#!/bin/bash
# ----------------------------------------------------- 
# Monochrome AI-Managed Dotfiles - Installer
# ----------------------------------------------------- 

set -e

DOTFILES_DIR=$(cd "$(dirname "$0")" && pwd)
CONFIG_DIR="$HOME/.config"
SCRIPTS_DIR="$HOME/dotfiles/scripts"

echo "-----------------------------------------------------"
echo " 🌑 DEPLOYING MONOCHROME AI-MANAGED WORKSTATION 🌑 "
echo "-----------------------------------------------------"

# 1. Create target directories
mkdir -p "$CONFIG_DIR"
mkdir -p "$HOME/dotfiles"

# 2. Deploy .config files (Symlinking)
echo "[1/4] Symlinking configuration files..."
for folder in "$DOTFILES_DIR/dotfiles/.config/"*; do
    target="$CONFIG_DIR/$(basename "$folder")"
    if [ -e "$target" ]; then
        echo "  - Backing up existing $(basename "$folder")..."
        mv "$target" "${target}.bak_$(date +%Y%m%d_%H%M%S)"
    fi
    ln -s "$folder" "$target"
    echo "  [OK] Linked $(basename "$folder")"
done

# 3. Deploy Scripts & Extras
echo "[2/4] Deploying automation scripts..."
if [ -d "$HOME/dotfiles/scripts" ]; then
    mv "$HOME/dotfiles/scripts" "$HOME/dotfiles/scripts.bak_$(date +%Y%m%d_%H%M%S)"
fi
ln -s "$DOTFILES_DIR/scripts" "$HOME/dotfiles/scripts"
chmod +x "$HOME/dotfiles/scripts/"*.sh

# 4. Deploy Nix & Root Folders
echo "[3/4] Deploying Nix & System components..."
for root_folder in "nix" "systemd" "etc" "rclone" "keepassxc" "wallpaper"; do
    if [ -d "$DOTFILES_DIR/$root_folder" ]; then
        ln -snf "$DOTFILES_DIR/$root_folder" "$HOME/dotfiles/$root_folder"
    fi
done

# 5. Set up Systemd Timers
echo "[4/4] Setting up daily health checks..."
mkdir -p "$HOME/.config/systemd/user"
cp "$DOTFILES_DIR/systemd/daily-health-check.service" "$HOME/.config/systemd/user/"
cp "$DOTFILES_DIR/systemd/daily-health-check.timer" "$HOME/.config/systemd/user/"

# Fix the path in the user service file to be absolute
sed -i "s|/home/%u/dotfiles/scripts/|$HOME/dotfiles/scripts/|g" "$HOME/.config/systemd/user/daily-health-check.service"

systemctl --user daemon-reload
systemctl --user enable --now daily-health-check.timer

echo "-----------------------------------------------------"
echo " ✅ DEPLOYMENT COMPLETE"
echo "-----------------------------------------------------"
echo " Next steps:"
echo " 1. Reload Hyprland (Super+Shift+C or log out)"
echo " 2. Select 'Monochrome' in Waybar settings"
echo " 3. Run '~/dotfiles/scripts/install-apps.sh' to install dependencies"
echo "-----------------------------------------------------"
