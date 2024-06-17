#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then 
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./move_documents.sh

This script moves PDF, Excel, and Word documents from the tmp directory to the docs directory.

'
    exit
fi

main() {
    # Define the base directory
    basedir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

    # Function to move documents from tmp to docs
    move_documents() {
        # Move PDF files
        for pdf_file in "$basedir/tmp"/*.pdf; do
            if [ -f "$pdf_file" ]; then
                mv "$pdf_file" "$basedir/docs/"
                echo "Moved PDF document: $(basename "$pdf_file")"
            fi
        done

        # Move Excel files
        for excel_file in "$basedir/tmp"/*.xlsx "$basedir/tmp"/*.xls; do
            if [ -f "$excel_file" ]; then
                mv "$excel_file" "$basedir/docs/"
                echo "Moved Excel document: $(basename "$excel_file")"
            fi
        done

        # Move Word files
        for word_file in "$basedir/tmp"/*.docx "$basedir/tmp"/*.doc; do
            if [ -f "$word_file" ]; then
                mv "$word_file" "$basedir/docs/"
                echo "Moved Word document: $(basename "$word_file")"
            fi
        done
    }

    echo "Moving documents from tmp to docs directory..."
    move_documents
    echo "Move completed."
}

main "$@"

