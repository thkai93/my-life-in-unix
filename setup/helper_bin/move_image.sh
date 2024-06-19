#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./move_images.sh

This script moves all image files from /tmp/ to /assets/.

'
    exit
fi

main() {
    # Define the source and destination directories
    src_dir="/tmp"
    dest_dir="/assets"

    # Create the destination directory if it doesn't exist
    if [ ! -d "$dest_dir" ]; then
        mkdir -p "$dest_dir"
        echo "Created directory: $dest_dir"
    fi

    # Move image files to the destination directory
    find "$src_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" \) -exec mv {} "$dest_dir" \;
    
    echo "Image files moved from $src_dir to $dest_dir."
}

main "$@"

