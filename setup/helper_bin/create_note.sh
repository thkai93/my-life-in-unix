#!/bin/sh

# Script: create_note.sh
# Description: This script creates a note in the 'notes' directory with the format:
#              [label]-[summary]-currentdatetime.md. It uses the same format as the
#              brain_dump script for the content.
# Usage: Save this script in any directory, make it executable with 'chmod +x create_note.sh',
#        and run it with two arguments: label and summary.

# Ensure the correct number of arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <label> <summary>"
    exit 1
fi

LABEL="$1"
SUMMARY="$2"

# Find the base directory (parent of the bin directory)
BASEDIR="$(cd "$(dirname "$0")/.." && pwd)"

# Define the notes directory
NOTES_DIR="$BASEDIR/notes"

# Ensure the notes directory exists
mkdir -p "$NOTES_DIR"

# Get the current date and time
CURRENT_DATETIME=$(date +"%Y%m%d%H%M%S")
FILENAME="${LABEL}-${SUMMARY}-${CURRENT_DATETIME}.md"
FILEPATH="$NOTES_DIR/$FILENAME"

# Create a new file for the note
touch "$FILEPATH"
{
    echo "# ${LABEL} - ${SUMMARY}"
    echo "Date: $(date +"%Y-%m-%d %H:%M:%S")"
    echo ""
    echo "## Notes"
    echo ""
} > "$FILEPATH"

# Open the file in vi
vi "$FILEPATH"

