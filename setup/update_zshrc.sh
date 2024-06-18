#!/bin/sh

set -e
set -u
set -o pipefail

# Define the location of the .zshrc file and the common-exports file
zshrc_file="$HOME/.zshrc"
common_exports_file="$HOME/common-exports"

# Get the current script location
script_dir="$(cd "$(dirname "$0")" && pwd)"

# Ensure common-exports exists and append if necessary
if [ ! -f "$common_exports_file" ]; then
    echo "common-exports file does not exist in the home directory. Copying from script location."
    cp "$script_dir/common-exports" "$common_exports_file"
else
    echo "common-exports file exists in the home directory. Appending to it."
    cat "$script_dir/common-exports" >> "$common_exports_file"
fi

# Check if .zshrc file exists
if [ ! -f "$zshrc_file" ]; then
    echo "Error: .zshrc file does not exist."
    exit 1
fi

# Check if .zshrc file is writable by the current user
if [ ! -w "$zshrc_file" ]; then
    echo "Error: .zshrc file is not writable by the current user."
    exit 1
fi

# Add sourcing of common-exports to .zshrc if it's not already present
if ! grep -q "source $common_exports_file" "$zshrc_file"; then
    echo "Adding source line to .zshrc"
    echo "\n# Source custom aliases and functions\nif [ -r \"$common_exports_file\" ]; then\n    . \"$common_exports_file\"\nfi\n" >> "$zshrc_file"
    echo "Successfully added source line to .zshrc"
else
    echo "Source line already present in .zshrc"
fi

# Reload .zshrc
echo "Reloading .zshrc"
# Use 'exec zsh' to reload .zshrc in a new Zsh session
exec zsh
echo "Successfully reloaded .zshrc"

