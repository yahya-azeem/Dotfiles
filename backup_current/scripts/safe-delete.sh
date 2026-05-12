#!/bin/bash
# ----------------------------------------------------- 
# Safe Deletion Wrapper
# ----------------------------------------------------- 

# Protected paths (regex or literal)
PROTECTED_PATHS=(
    "/"
    "/etc"
    "/usr"
    "/boot"
    "/home/$USER"
    "/var"
)

# Function to check if a path is protected
is_protected() {
    local path=$(realpath "$1" 2>/dev/null || echo "$1")
    for protected in "${PROTECTED_PATHS[@]}"; do
        if [[ "$path" == "$protected" ]]; then
            return 0
        fi
    done
    return 1
}

# Main deletion logic
for arg in "$@"; do
    if [[ "$arg" == -* ]]; then
        # Skip flags
        continue
    fi

    if is_protected "$arg"; then
        echo "ERROR: Path '$arg' is PROTECTED. Deletion blocked."
        exit 1
    fi
done

# If trash-cli is installed, use it. Otherwise, use rm with caution.
if command -v trash-put &> /dev/null; then
    trash-put "$@"
else
    echo "WARNING: trash-cli not found. Using raw rm."
    /usr/bin/rm "$@"
fi
