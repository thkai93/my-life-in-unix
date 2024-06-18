#!/bin/sh

# Script: copy_documents.sh
# Description: This script copies all PDF, Excel, and Word documents from the 'tmp' directory
#              to the 'docs' directory. It is intended to reside in the 'bin' directory.
# Usage: Save this script in the bin directory (e.g., $basedir/bin/copy_documents.sh),
#        make it executable with 'chmod +x $basedir/bin/copy_documents.sh', and run it.

# Find the base directory (parent of the bin directory)
BASEDIR="$(cd "$(dirname "$0")/.." && pwd)"

# Define source and destination directories
SRC_DIR="$BASEDIR/tmp"
DEST_DIR="$BASEDIR/docs"

# Ensure the source directory exists
if [ ! -d "$SRC_DIR" ]; then
    echo "Error: Source directory does not exist: $SRC_DIR."
    exit 1
fi

# Ensure the destination directory exists, create if not
mkdir -p "$DEST_DIR"

# Copy all PDF, Excel, and Word documents from the source to the destination directory
find "$SRC_DIR" -type f \( -name "*.pdf" -o -name "*.xls" -o -name "*.xlsx" -o -name "*.doc" -o -name "*.docx" \) -exec cp {} "$DEST_DIR" \;

# Check if there are still files left in the tmp directory
REMAINING_FILES=$(find "$SRC_DIR" -type f \( -name "*.pdf" -o -name "*.xls" -o -name "*.xlsx" -o -name "*.doc" -o -name "*.docx" \))

if [ -n "$REMAINING_FILES" ]; then
    echo "Error 999: The following files are still in the tmp directory:"
    echo "$REMAINING_FILES"
    exit 999
else
    echo "Copied all PDF, Excel, and Word documents from $SRC_DIR to $DEST_DIR."
fi

