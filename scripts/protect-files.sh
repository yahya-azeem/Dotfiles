#!/bin/bash
# ----------------------------------------------------- 
# Immutable File Protection Script (Refined)
# Uses chattr +i to prevent modification/deletion
# ----------------------------------------------------- 

PRIVILEGE_TOOL=$(command -v doas || command -v sudo)

# Attempt to detect dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    # Fallback to current script location if not symlinked to ~/dotfiles
    DOTFILES_DIR=$(dirname "$(dirname "$(readlink -f "$0")")")
fi

# List of critical configuration files to lock
CRITICAL_FILES=(
    "$HOME/.bashrc"
    "$HOME/.zshrc"
    "$HOME/.config/hypr/hyprland.conf"
    "$HOME/.config/hypr/conf/custom.conf"
    "/etc/doas.conf"
    "/etc/fstab"
    "$DOTFILES_DIR/nix/technical-env.nix"
)

lock_files() {
    echo "Locking critical files (Immutability ON)..."
    for file in "${CRITICAL_FILES[@]}"; do
        if [ -f "$file" ]; then
            $PRIVILEGE_TOOL chattr +i "$file"
            echo "[LOCKED] $file"
        fi
    done
}

unlock_files() {
    echo "Unlocking critical files (Immutability OFF)..."
    for file in "${CRITICAL_FILES[@]}"; do
        if [ -f "$file" ]; then
            $PRIVILEGE_TOOL chattr -i "$file"
            echo "[UNLOCKED] $file"
        fi
    done
}

case "$1" in
    lock) lock_files ;;
    unlock) unlock_files ;;
    *) echo "Usage: $0 {lock|unlock}" ;;
esac
