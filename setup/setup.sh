#!/bin/sh

set -e
set -u
set -o pipefail

if [ "${TRACE-0}" = "1" ]; then
    set -x
fi

if [ "${1-}" = "-h" ] || [ "${1-}" = "--help" ]; then
    echo 'Usage: ./setup.sh <config-file>

This script creates a portable Unix-based directory structure based on a configuration file.

Arguments:
  config-file   The configuration file containing basedir and subdirectories.

'
    exit
fi

if [ $# -eq 0 ]; then
    echo "Error: No configuration file provided."
    echo "Usage: ./setup.sh <config-file>"
    exit 1
fi

config_file="$1"

if [ ! -f "$config_file" ]; then
    echo "Error: Configuration file '$config_file' does not exist."
    exit 1
fi

# Load the configuration file
. "$config_file"

# Check if required variables are set
if [ -z "${basedir-}" ] || [ -z "${subdirectories-}" ]; then
    echo "Error: 'basedir' or 'subdirectories' not set in the configuration file."
    exit 1
fi

# Set the full path for the basedir in the home directory
basedir="$HOME/$basedir"

main() {
    # Function to create subdirectories
    create_subdirectories() {
        # Convert subdirectories string to an array and iterate over it
        echo "$subdirectories" | tr ',' '\n' | while read -r dir; do
            if [ ! -d "$basedir/$dir" ]; then
                mkdir -p "$basedir/$dir"
                echo "Created directory: $basedir/$dir"
            else
                echo "Directory already exists: $basedir/$dir"
            fi
        done
    }

    echo "Creating subdirectories in $basedir..."
    create_subdirectories
    echo "Subdirectory creation completed."
}

main "$@"

