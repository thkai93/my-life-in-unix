#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then 
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./create_markdown_notes.sh

This script creates markdown notes with the specified format in the notes directory and opens them in vi.

'
    exit
fi

main() {
    # Define the base directory
    basedir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

    # Function to create markdown notes
    create_markdown_notes() {
        label="$1"
        title="$2"
        datetime=$(date +"%Y-%m-%d-%H-%M-%S")
        note_file="$basedir/notes/${label}-${title}-${datetime}.md"

        echo "Creating markdown note: $note_file"
        touch "$note_file"
        echo "# $title" >> "$note_file"
        echo "Created markdown note: $note_file"
        
        # Open the note file in vi
        vi "$note_file"
    }

    # Example usage: create_markdown_notes "personal" "Meeting Notes"
    create_markdown_notes "$@"
}

main "$@"

