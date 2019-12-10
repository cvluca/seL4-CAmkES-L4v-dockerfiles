#!/bin/bash

set -exuo pipefail

# Source common functions
DIR="${BASH_SOURCE%/*}"
test -d "$DIR" || DIR=$PWD
# shellcheck source=utils/common.sh
. "$DIR/utils/common.sh"

# tmp space for building 
: "${TEMP_DIR:=/tmp}"

# Get rust nightly
wget -O - https://sh.rustup.rs > "$TEMP_DIR/rustup.sh"
sh "$TEMP_DIR/rustup.sh" -y --default-toolchain nightly
rm "$TEMP_DIR/rustup.sh"

# Install rumprun target
"$HOME/.cargo/bin/rustup" target add x86_64-rumprun-netbsd

# Add cargo and rust to PATH
echo "export PATH=\"\$PATH:\$HOME/.cargo/bin\"" >> "$HOME/.bashrc"
