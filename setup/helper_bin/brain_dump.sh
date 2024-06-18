#!/bin/sh

# Script: brain_dump.sh
# Description: This script helps perform a daily brain dump by creating a timestamped
#              markdown file in the 'notes' directory and opening it in 'vi' for writing.
#              If a brain dump file already exists for the current day, it will notify
#              the user and open the existing file in 'vi'.
#              It also provides a function to view a specific brain dump note by date.
# Usage: Save this script in your bin directory (e.g., ~/omo/bin/brain_dump.sh),
#        make it executable with 'chmod +x ~/omo/bin/brain_dump.sh', and optionally
#        set up a cron job to run it automatically at the start of each day.
#
# Base directory
BASEDIR="$HOME/omo"
NOTES_DIR="$BASEDIR/notes"

# Ensure the notes directory exists
mkdir -p "$NOTES_DIR"

# Function to create or open a brain dump note for today
create_or_open_brain_dump() {
    # Get the current date
    CURRENT_DATE=$(date +"%Y%m%d")
    FILENAME="brain_dump_$CURRENT_DATE.md"
    FILEPATH="$NOTES_DIR/$FILENAME"

    # Check if the file already exists
    if [ -e "$FILEPATH" ]; then
        echo "Brain dump for today already exists: $FILEPATH"
    else
        # Create a new file for today's brain dump
        touch "$FILEPATH"
        {
            echo "# Brain dump for $CURRENT_DATE"
            echo "=================================="
            echo "Start time: $(date +"%H:%M:%S")"
            echo ""
            echo "## Notes"
            echo ""
        } > "$FILEPATH"
    fi

    # Open the file in vi
    vi "$FILEPATH"
}

# Function to view a brain dump note for a specific date
view_brain_dump() {
    if [ $# -eq 0 ]; then
        echo "Usage: view_brain_dump YYYYMMDD"
        return 1
    fi

    TARGET_DATE="$1"
    FILENAME="brain_dump_$TARGET_DATE.md"
    FILEPATH="$NOTES_DIR/$FILENAME"

    if [ -e "$FILEPATH" ]; then
        vi "$FILEPATH"
    else
        echo "No brain dump found for the date: $TARGET_DATE"
        return 1
    fi
}

# Main script logic
case "$1" in
    view)
        shift
        view_brain_dump "$@"
        ;;
    *)
        create_or_open_brain_dump
        ;;
esac

