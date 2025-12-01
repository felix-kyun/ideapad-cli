#!/usr/bin/env bash

set -eou pipefail

# check if running as root
uid=$(id -u)
if (( uid != 0 )); then
    echo "This script must be run as root."
    exec sudo "$0" "$@"
fi

CURRENT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# install binary
echo "Installing ideaconf binary..."
install -Dm 755 "$CURRENT_DIR/ideaconf" /usr/local/bin/ideaconf

# install completions
if command -v zsh >/dev/null 2>&1; then
    install -Dm644 "$CURRENT_DIR/completions/zsh" /usr/share/zsh/site-functions/_ideaconf
    echo "ok"
fi
if command -v bash >/dev/null 2>&1; then
    # ensure bash_completions is installed to support completion installation
    if [ ! -f /usr/share/bash-completion/bash_completion ]; then
        echo "bash-completion package is not installed. Please install it first."
        exit 1
    fi
    echo "Installing ideaconf completion for bash..."
    install -Dm644 "$CURRENT_DIR/completions/bash" /usr/share/bash-completion/completions/ideaconf
    echo "ok"
fi
