#!/bin/bash
# ----------------------------------------------------- 
# Immutable File Protection Script (Refined)
# Uses chattr +i to prevent modification/deletion
# ----------------------------------------------------- 

PRIVILEGE_TOOL=$(command -v doas || command -v sudo)

# List of critical configuration files to lock
CRITICAL_FILES=(
    "$HOME/.bashrc"
    "$HOME/.zshrc"
    "$HOME/dotfiles/hypr/hyprland.conf"
    "$HOME/dotfiles/hypr/conf/custom.conf"
    "/etc/doas.conf"
    "/etc/fstab"
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
