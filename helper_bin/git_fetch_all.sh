#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then 
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./fetch_git_repos.sh

This script fetches changes for all Git repositories in the git directory.

'
    exit
fi

main() {
    # Define the base directory
    basedir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

    # Function to fetch all Git repositories in git directory
    fetch_git_repos() {
        for repo in "$basedir/git"/*; do
            if [ -d "$repo" ]; then
                echo "Fetching changes for Git repository: $(basename "$repo")"
                git -C "$repo" fetch --all
                echo "Fetched changes for Git repository: $(basename "$repo")"
            fi
        done
    }

    echo "Fetching changes for all Git repositories..."
    fetch_git_repos
    echo "Fetch completed."
}

main "$@"


