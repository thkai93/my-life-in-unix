#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then 
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./open_documents.sh filename

This script opens PDF, Excel, or Word documents in the docs directory.

'
    exit
fi

main() {
    # Define the base directory
    basedir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

    # Function to open documents
    open_document() {
        filename="$1"

        echo "Opening document: $filename"

        # Get file extension
        extension="${filename##*.}"

        case "$extension" in
            pdf)
                # Open PDF using evince
                evince "$basedir/docs/$filename" &
                ;;
            xls|xlsx)
                # Open Excel using libreoffice
                libreoffice --calc "$basedir/docs/$filename" &
                ;;
            doc|docx)
                # Open Word using libreoffice
                libreoffice --writer "$basedir/docs/$filename" &
                ;;
            *)
                echo "Unsupported file type: $extension"
                ;;
        esac
    }

    # Example usage: open_document "example.pdf"
    open_document "$@"
}

main "$@"

