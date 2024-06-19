#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./setup_dev_env.sh

This script sets up Homebrew, Python, Rust, Go, Angular, Java, Maven, Scala, VSCode, Docker, and Git.

'
    exit
fi

main() {
    # Define the base directories
    basedir=$(dirname "$0")
    lib_dir="$basedir/../lib"
    config_dir="$basedir/../config"

    # Create directories if they don't exist
    mkdir -p "$lib_dir"
    mkdir -p "$config_dir"

    # Check and install Homebrew
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Homebrew installed."
    else
        echo "Homebrew is already installed. Updating..."
        brew update
        brew upgrade
    fi

    # Install or update Python
    if ! command -v python3 &> /dev/null; then
        echo "Installing Python..."
        brew install python
        echo "Python installed."
    else
        echo "Python is already installed. Updating..."
        brew upgrade python
    fi

    # Install or update Rust
    if ! command -v rustc &> /dev/null; then
        echo "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        echo "Rust installed."
    else
        echo "Rust is already installed. Updating..."
        rustup update
    fi

    # Install or update Go
    if ! command -v go &> /dev/null; then
        echo "Installing Go..."
        brew install go
        echo "Go installed."
    else
        echo "Go is already installed. Updating..."
        brew upgrade go
    fi

    # Install or update Angular CLI
    if ! command -v ng &> /dev/null; then
        echo "Installing Angular CLI..."
        npm install -g @angular/cli
        echo "Angular CLI installed."
    else
        echo "Angular CLI is already installed. Updating..."
        npm update -g @angular/cli
    fi

    # Install or update Java
    if ! command -v java &> /dev/null; then
        echo "Installing Java..."
        brew install openjdk
        echo "Java installed."
    else
        echo "Java is already installed. Updating..."
        brew upgrade openjdk
    fi

    # Install or update Maven
    if ! command -v mvn &> /dev/null; then
        echo "Installing Maven..."
        brew install maven
        echo "Maven installed."
    else
        echo "Maven is already installed. Updating..."
        brew upgrade maven
    fi

    # Install or update Scala
    if ! command -v scala &> /dev/null; then
        echo "Installing Scala..."
        brew install scala
        echo "Scala installed."
    else
        echo "Scala is already installed. Updating..."
        brew upgrade scala
    fi

    # Install or update VSCode
    if ! command -v code &> /dev/null; then
        echo "Installing VSCode..."
        brew install --cask visual-studio-code
        echo "VSCode installed."
    else
        echo "VSCode is already installed. Updating..."
        brew upgrade --cask visual-studio-code
    fi

    # Install or update Docker
    if ! command -v docker &> /dev/null; then
        echo "Installing Docker..."
        brew install --cask docker
        echo "Docker installed."
    else
        echo "Docker is already installed. Updating..."
        brew upgrade --cask docker
    fi

    # Install or update Git
    if ! command -v git &> /dev/null; then
        echo "Installing Git..."
        brew install git
        echo "Git installed."
    else
        echo "Git is already installed. Updating..."
        brew upgrade git
    fi

    echo "Development environment setup completed."

    # Update relevant system files if permissions allow
    if [ -w /etc/environment ]; then
        echo "Updating /etc/environment..."
        {
            echo 'export PATH="/usr/local/opt/python/libexec/bin:$PATH"'
            echo 'export PATH="/usr/local/opt/openjdk/bin:$PATH"'
            echo 'export PATH="/usr/local/opt/scala/bin:$PATH"'
            echo 'export PATH="/usr/local/opt/go/libexec/bin:$PATH"'
            echo 'export PATH="/usr/local/opt/rust/libexec/bin:$PATH"'
            echo 'export PATH="/usr/local/opt/docker/libexec/bin:$PATH"'
        } >> /etc/environment
        echo "System environment variables updated."
    fi
}

main "$@"

