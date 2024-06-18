#!/bin/sh

# Script: find_note.sh
# Description: This script finds and lists files in the 'notes' directory that match a given pattern.
# Usage: Save this script in your bin directory (e.g., ~/bin/find_note.sh),
#        make it executable with 'chmod +x ~/bin/find_note.sh', and run it with a pattern argument.

# Find the base directory (parent of the bin directory)
BASEDIR="$(cd "$(dirname "$0")/.." && pwd)"
NOTES_DIR="$BASEDIR/notes"

# Ensure the notes directory exists
if [ ! -d "$NOTES_DIR" ]; then
    echo "Error: Notes directory does not exist: $NOTES_DIR."
    exit 1
fi

# Ensure a pattern is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <pattern>"
    exit 1
fi

PATTERN="$1"

# Find and list matching files
MATCHING_FILES=$(find "$NOTES_DIR" -type f -name "*$PATTERN*")

if [ -z "$MATCHING_FILES" ]; then
    echo "No files found matching pattern: $PATTERN"
else
    echo "Files matching pattern '$PATTERN':"
    echo "$MATCHING_FILES"
fi

