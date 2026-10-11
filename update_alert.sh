#!/usr/bin/env bash

# Linux Software Update Alert System
# Checks Ubuntu package updates without installing them.

set -u
set -o pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/update_alert.log"

# Ensure the script is running on a Debian-based system.
if ! command -v apt-get >/dev/null 2>&1; then
    echo "Error: apt-get is not available on this system."
    exit 1
fi

# APT needs administrator privileges to refresh package information.
if [[ "$(id -u)" -ne 0 ]]; then
    echo "Refreshing package information requires administrator privileges."
    echo "Run this script using: sudo bash ./update_alert.sh"
    exit 1
fi

mkdir -p "$(dirname "$LOG_FILE")" || exit 1

echo "======================================"
echo " Linux Software Update Alert System"
echo "======================================"
echo "Checking for package updates..."
echo "Time: $(date '+%Y-%m-%d %H:%M:%S')"

# Refresh package metadata. This does not install updates.
if ! apt-get update; then
    echo "Error: Could not refresh package information."
    echo "$(date '+%Y-%m-%d %H:%M:%S') | ERROR: apt-get update failed" >> "$LOG_FILE"
    exit 1
fi

# List available upgrades without installing them.
UPDATES="$(apt list --upgradable 2>/dev/null)"
if [[ $? -ne 0 ]]; then
    echo "Error: Could not retrieve the available updates."
    exit 1
fi

COUNT="$(printf '%s\n' "$UPDATES" | tail -n +2 | grep -c . || true)"

if [[ "$COUNT" -gt 0 ]]; then
    echo
    echo "ALERT: ${COUNT} package update(s) available."
    printf '%s\n' "$UPDATES" | tail -n +2
    STATUS="UPDATES AVAILABLE: ${COUNT}"
else
    echo
    echo "Your installed packages appear to be up to date."
    STATUS="NO UPDATES AVAILABLE"
fi

printf '%s | %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$STATUS" >> "$LOG_FILE"

echo
echo "Check completed. Log: $LOG_FILE"
