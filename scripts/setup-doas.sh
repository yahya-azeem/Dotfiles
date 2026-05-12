#!/bin/bash
# ----------------------------------------------------- 
# Doas Configuration & Sudo Alias
# ----------------------------------------------------- 

# Install opendoas if not present
if ! command -v doas &> /dev/null; then
    echo "Installing opendoas..."
    sudo pacman -S --needed opendoas
fi

# Create /etc/doas.conf
# permit setenv { PATH } :wheel -> allows members of wheel group to use doas
# persist -> remembers password for a while
DOAS_CONF="/etc/doas.conf"

echo "Configuring $DOAS_CONF..."
echo "permit persist setenv { PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin } :wheel" | sudo tee "$DOAS_CONF"

# Set permissions
sudo chown root:root "$DOAS_CONF"
sudo chmod 0400 "$DOAS_CONF"

# Create sudo alias for compatibility
BASHRC="$HOME/.bashrc"
if ! grep -q "alias sudo='doas'" "$BASHRC"; then
    echo "Adding sudo alias to $BASHRC..."
    echo "alias sudo='doas'" >> "$BASHRC"
fi

echo "Doas setup complete. Please restart your terminal."
