#!/bin/bash
# ----------------------------------------------------- 
# AI Agent Session Launcher (Refined)
# ----------------------------------------------------- 

# Ensure Nix is available
if ! command -v nix-shell &> /dev/null; then
    echo "Nix not found. Please install Nix to use the technical agent."
    read -p "Press enter to continue without Nix..."
fi

# Define the custom prompt for the AI session
# Monochrome, sharp look
export PS1="\[\e[1;37m\][AI-AGENT] \[\e[1;30m\]\w \[\e[0m\]$ "

cat << "EOF"
-----------------------------------------------------
  AI AGENT SESSION : TECHNICAL EXECUTION MODE
-----------------------------------------------------
  Domain: Vibecoding / Pentesting / Debugging
  Backend: Nix (Reproducible Environment)
-----------------------------------------------------
EOF

# Attempt to detect dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    DOTFILES_DIR=$(dirname "$(dirname "$(readlink -f "$0")")")
fi

# Launch the session
nix-shell "$DOTFILES_DIR/nix/technical-env.nix" --run "bash --rcfile <(echo \"export PS1='[AI-AGENT] \w $ '\")"

# Fallback if nix-shell fails
if [ $? -ne 0 ]; then
    echo "Launching fallback local agent session..."
    bash
fi
