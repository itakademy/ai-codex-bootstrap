#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./lib/common.sh
source "${SCRIPT_DIR}/lib/common.sh"

URL="${1:-}"
TARGET_PATH="${2:-}"
BRANCH="${3:-}"

ensure_git_repo
require_var "$URL" "Usage: ./scripts/submodule-add.sh <url> <path> [branch]"
require_var "$TARGET_PATH" "Usage: ./scripts/submodule-add.sh <url> <path> [branch]"

if [[ -e "$TARGET_PATH" ]]; then
  fail "Target path already exists: $TARGET_PATH. Remove or move it before adding the submodule."
fi

info "Adding submodule $URL at $TARGET_PATH"

if [[ -n "$BRANCH" ]]; then
  git submodule add -b "$BRANCH" "$URL" "$TARGET_PATH"
else
  git submodule add "$URL" "$TARGET_PATH"
fi

git submodule absorbgitdirs "$TARGET_PATH"

cat <<EOF

Submodule added:
  URL: $URL
  Path: $TARGET_PATH

Next steps:
  1. git status
  2. commit the new .gitmodules entry and submodule pointer
EOF
