#!/bin/bash
# ----------------------------------------------------- 
# Manual Nix Shell Launcher
# ----------------------------------------------------- 

echo "Entering Manual Nix Shell..."
echo "Host files are accessible in $(pwd)"

# Attempt to detect dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    DOTFILES_DIR=$(dirname "$(dirname "$(readlink -f "$0")")")
fi

# Use the technical-env.nix for a rich set of tools
nix-shell "$DOTFILES_DIR/nix/technical-env.nix"
