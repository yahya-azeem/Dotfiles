#!/bin/bash
# ----------------------------------------------------- 
# Cloud Sync Script (Rclone + Google Drive)
# ----------------------------------------------------- 

REMOTE="google-drive:"
LOCAL_DIR="$HOME/Cloud"
LOG_FILE="$HOME/.cache/rclone/sync.log"

# Create local dir if not exists
mkdir -p "$LOCAL_DIR"

echo "[$(date)] Starting Cloud Sync..." | tee -a "$LOG_FILE"

# Run rclone bisync for bidirectional sync or sync for unidirectional
# Bisync is better for "Dropbox-style" behavior
if command -v rclone &> /dev/null; then
    rclone bisync "$LOCAL_DIR" "$REMOTE" \
        --resync-mode newer \
        --verbose \
        --transfers 4 \
        --checkers 8 \
        --drive-chunk-size 128M \
        --log-file "$LOG_FILE"
else
    echo "ERROR: rclone not found." | tee -a "$LOG_FILE"
    exit 1
fi

echo "[$(date)] Cloud Sync Completed." | tee -a "$LOG_FILE"
