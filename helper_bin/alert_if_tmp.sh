#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then 
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./alert_outstanding_files.sh

This script checks for outstanding files in the tmp directory and alerts if any are found.

'
    exit
fi

main() {
    # Define the base directory
    basedir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

    # Function to check tmp directory
    check_tmp_directory() {
        outstanding_files=$(find "$basedir/tmp" -type f)

        if [ -n "$outstanding_files" ]; then
            echo "Outstanding files found in tmp directory:"
            echo "$outstanding_files"
            # Add your alert mechanism here, such as sending an email or displaying a notification
            # For example, send an email using mail command:
            # mail -s "Outstanding Files Alert" user@example.com <<< "Outstanding files found in tmp directory. Check attached list."
        else
            echo "No outstanding files found in tmp directory."
        fi
    }

    echo "Checking for outstanding files in tmp directory..."
    check_tmp_directory
    echo "Check completed."
}

main "$@"

