#!/bin/bash

# Script: backup_config.sh
# Description: This script backs up the ~/.zshrc and ~/common-exports files into the ~/config/ directory.
# Usage: Save this script in the bin directory (e.g., /bin/backup_config.sh),
#        make it executable with 'chmod +x /bin/backup_config.sh', and run it.

# Find the base directory (parent of the bin directory)
BASEDIR="$(cd "$(dirname "$0")/.." && pwd)"

# Define source files and destination directory
SRC_ZSHRC="$HOME/.zshrc"
SRC_COMMON_EXPORTS="$HOME/common-exports"
DEST_DIR="$BASEDIR/config"

# Ensure the source files exist
if [ ! -f "$SRC_ZSHRC" ]; then
    echo "Error: Source file does not exist: $SRC_ZSHRC."
    exit 1
fi

if [ ! -f "$SRC_COMMON_EXPORTS" ]; then
    echo "Error: Source file does not exist: $SRC_COMMON_EXPORTS."
    exit 1
fi

# Backup .zshrc file
cp "$SRC_ZSHRC" "$DEST_DIR"

# Backup common-exports file
cp "$SRC_COMMON_EXPORTS" "$DEST_DIR"

echo "Backup completed: ~/.zshrc and ~/common-exports files backed up to $DEST_DIR."

