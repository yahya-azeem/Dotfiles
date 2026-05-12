#!/bin/bash
# ----------------------------------------------------- 
# Manual Nix Shell Launcher
# ----------------------------------------------------- 

echo "Entering Manual Nix Shell..."
echo "Host files are accessible in $(pwd)"

# Use the technical-env.nix for a rich set of tools
nix-shell ~/dotfiles/nix/technical-env.nix
