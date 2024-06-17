#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then 
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./locate_notes.sh pattern

This script searches for notes in the notes directory based on the given pattern and outputs them in the order of their creation.

'
    exit
fi

main() {
    # Define the base directory
    basedir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

    # Function to locate notes
    locate_notes() {
        pattern="$1"

        echo "Locating notes matching pattern: $pattern"

        # Search for notes with the given pattern in the notes directory
        find "$basedir/notes" -type f -name "*$pattern*.md" -printf "%T@ %p\n" | sort -nr | cut -d ' ' -f2-
    }

    # Example usage: locate_notes "Meeting"
    locate_notes "$@"
}

main "$@"

