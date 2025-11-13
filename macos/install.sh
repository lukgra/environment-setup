#!/usr/bin/env bash

set -e

WHITE='\033[0;37m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NONE='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() {
    echo -e "${WHITE}[INFO]${NONE} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NONE} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NONE} $1"
}

install_packages() {
    log "Installing shared packages"

    if [ ! -f "$SCRIPT_DIR/packages.txt" ]; then
        log_warn "No shared packages.txt found, skipping..."
        exit 1
    fi

    while IFS= read -r package; do
        if [ -n "$package" ]; then
            log "Installing $package..."
            brew install "$package"
        fi
    done < <(grep -v '^#' "$SCRIPT_DIR/packages.txt" | grep -v '^$')

}

set_background() {
    log "Setting background image..."
    osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$SCRIPT_DIR/backgrounds/$1\""
}

main() {
    log "Starting dev environment setup..."

    if [[ "$OSTYPE" != "darwin"* ]]; then
        log_error "Can only run install on macOS"
        exit 1
    fi

    install_packages
    set_background "2-akane.jpg"

    log "Setup complete!"
}

main "$@"
