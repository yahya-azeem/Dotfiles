#!/bin/bash
# ----------------------------------------------------- 
# Borg Backup Setup & Initialization
# ----------------------------------------------------- 

REPO_PATH="/path/to/backup/repo"
PASSPHRASE="YOUR_STRONG_PASSPHRASE"

# Check if Borg is installed
if ! command -v borg &> /dev/null; then
    echo "ERROR: BorgBackup not found. Please install 'borg'."
    exit 1
fi

echo "Initializing Borg repository at $REPO_PATH..."

# Set passphrase for the session
export BORG_PASSPHRASE="$PASSPHRASE"

# Initialize repository with repokey-blake2 encryption
# repokey stores the key in the repo, meaning you only need the passphrase
borg init --encryption=repokey-blake2 "$REPO_PATH"

if [ $? -eq 0 ]; then
    echo "Repository initialized successfully."
    echo "IMPORTANT: Store your passphrase and repo-key backup safely!"
else
    echo "ERROR: Failed to initialize repository. It might already exist."
fi

# Example backup command
echo "To run a backup manually:"
echo "borg create --stats --progress \$REPO_PATH::'backup-{now:%Y-%m-%d}' ~/Documents ~/Pictures"
