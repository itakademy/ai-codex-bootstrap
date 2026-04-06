#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./lib/common.sh
source "${SCRIPT_DIR}/lib/common.sh"

ensure_git_repo

REMOTE_FLAG="${1:-}"

if [[ "$REMOTE_FLAG" == "--remote" ]]; then
  info "Updating submodules from remote tracking branches"
  git submodule update --init --recursive --remote
else
  info "Updating submodules to recorded commits"
  git submodule update --init --recursive
fi
