#!/bin/bash
# ----------------------------------------------------- 
# Daily AI Health Check (Refined & Agentic)
# With Safe Auto-Remediation
# ----------------------------------------------------- 

PRIVILEGE_TOOL=$(command -v doas || command -v sudo)
LOG_FILE="$HOME/.cache/ai-health-check.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "--- Health Check Started: $TIMESTAMP ---" >> "$LOG_FILE"

# Function to remediate failed services
remediate_service() {
    local service=$1
    echo "[REMEDIATE] Attempting to restart $service..." >> "$LOG_FILE"
    $PRIVILEGE_TOOL systemctl restart "$service"
}

# 1. Check failed systemd services
FAILED_SERVICES=$(systemctl --failed --no-legend | awk '{print $1}')
if [ ! -z "$FAILED_SERVICES" ]; then
    echo "[ALERT] Failed services detected: $FAILED_SERVICES" >> "$LOG_FILE"
    for svc in $FAILED_SERVICES; do
        # Safe auto-remediation for specific UI components
        case "$svc" in
            waybar.service|mako.service|hyprpaper.service)
                remediate_service "$svc"
                ;;
            *)
                echo "[INFO] Manual intervention required for $svc" >> "$LOG_FILE"
                ;;
        esac
    done
else
    echo "[OK] No failed systemd services." >> "$LOG_FILE"
fi

# 2. Check disk usage (threshold 90%)
DISK_USAGE=$(df / --output=pcent | tail -1 | tr -dc '0-9')
if [ "$DISK_USAGE" -gt 90 ]; then
    echo "[WARNING] High disk usage: ${DISK_USAGE}%" >> "$LOG_FILE"
else
    echo "[OK] Disk usage at ${DISK_USAGE}%" >> "$LOG_FILE"
fi

# 3. Check for kernel errors in dmesg
KERNEL_ERRORS=$($PRIVILEGE_TOOL dmesg | tail -n 100 | grep -Ei "error|fail|critical")
if [ ! -z "$KERNEL_ERRORS" ]; then
    echo "[WARNING] Recent kernel errors detected." >> "$LOG_FILE"
else
    echo "[OK] No critical kernel errors." >> "$LOG_FILE"
fi

# 4. Check Cloud Sync & Backups
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
if command -v rclone &> /dev/null; then
    "$SCRIPT_DIR/cloud-sync.sh" >> "$LOG_FILE" 2>&1
fi

if command -v borg &> /dev/null; then
    "$SCRIPT_DIR/backup-verify.sh" >> "$LOG_FILE" 2>&1
fi

echo "--- Health Check Completed ---" >> "$LOG_FILE"

# Keep log size manageable (last 1000 lines)
tail -n 1000 "$LOG_FILE" > "${LOG_FILE}.tmp" && mv "${LOG_FILE}.tmp" "$LOG_FILE"
