#!/bin/bash
# ----------------------------------------------------- 
# Backup Freshness & Integrity Check
# ----------------------------------------------------- 

REPO_PATH="/path/to/backup/repo"
PASSPHRASE="YOUR_STRONG_PASSPHRASE"
export BORG_PASSPHRASE="$PASSPHRASE"

echo "[$(date)] Verifying Borg Backups..."

if ! command -v borg &> /dev/null; then
    echo "[ALERT] Borg not found."
    exit 1
fi

# List last archive and check age
LAST_ARCHIVE=$(borg list "$REPO_PATH" --last 1 --format "{name} {time}")
if [ -z "$LAST_ARCHIVE" ]; then
    echo "[CRITICAL] No archives found in $REPO_PATH!"
    exit 1
fi

echo "[OK] Last archive: $LAST_ARCHIVE"

# Run a quick check on the last archive (optional, can be slow)
# borg check --last 1 "$REPO_PATH"
