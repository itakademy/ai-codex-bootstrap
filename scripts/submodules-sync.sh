#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./lib/common.sh
source "${SCRIPT_DIR}/lib/common.sh"

ensure_git_repo

info "Syncing submodule configuration"
git submodule sync --recursive

info "Initializing and updating submodules"
git submodule update --init --recursive
