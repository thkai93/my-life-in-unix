#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then 
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./create_directories.sh

This script creates a portable Unix-based directory structure.

'
    exit
fi

main() {
    # Define the base directory
    basedir="omo"

    # List of subdirectories
    subdirectories=("assets" "bin" "config" "docs" "logs" "tmp" "lib" "dist" "notes" "secrets")

    # Function to create subdirectories
    create_subdirectories() {
        for dir in "${subdirectories[@]}"; do
            if [ ! -d "$basedir/$dir" ]; then
                mkdir -p "$basedir/$dir"
                echo "Created directory: $basedir/$dir"
            else
                echo "Directory already exists: $basedir/$dir"
            fi
        done
    }

    echo "Creating subdirectories..."
    create_subdirectories
    echo "Subdirectory creation completed."
}

main "$@"

