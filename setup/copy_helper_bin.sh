#!/bin/sh

# Script: copy_scripts.sh
# Description: This script reads the config.properties file to get the list of scripts
#              to copy and their destination paths. It then copies the specified scripts
#              from the helper_bin directory (located in the same directory as this script)
#              to the specified destination paths.
# Usage: Save this script in any directory, make it executable with 'chmod +x copy_scripts.sh',
#        and run it.

# Find the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/config.properties"
HELPER_BIN_DIR="$SCRIPT_DIR/helper_bin"

# Ensure the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: config.properties file does not exist."
    exit 1
fi

# Ensure the helper_bin directory exists
if [ ! -d "$HELPER_BIN_DIR" ]; then
    echo "Error: helper_bin directory does not exist in $SCRIPT_DIR."
    exit 1
fi

# Read the config file and copy the scripts
while IFS='=' read -r key value; do
    case "$key" in
        script*)
            SCRIPT_NAME="$value"
            script_num=$(echo "$key" | grep -o '[0-9]*')
            ;;
        path"$script_num")
            DEST_PATH=$(eval echo "$value")  # Expand the tilde to home directory
            if [ -n "$SCRIPT_NAME" ] && [ -n "$DEST_PATH" ]; then
                # Ensure the destination directory exists
                mkdir -p "$DEST_PATH"
                # Copy the script
                if [ -f "$HELPER_BIN_DIR/$SCRIPT_NAME" ]; then
                    cp "$HELPER_BIN_DIR/$SCRIPT_NAME" "$DEST_PATH"
                    echo "Copied $SCRIPT_NAME to $DEST_PATH"
                else
                    echo "Error: $SCRIPT_NAME does not exist in $HELPER_BIN_DIR."
                fi
                SCRIPT_NAME=""
                DEST_PATH=""
            fi
            ;;
    esac
done < "$CONFIG_FILE"

