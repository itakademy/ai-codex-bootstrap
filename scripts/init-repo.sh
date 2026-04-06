#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./lib/common.sh
source "${SCRIPT_DIR}/lib/common.sh"

require_command git

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  fail "Git repository already initialized."
fi

info "Initializing git repository"
git init
git branch -M main

if has_command pre-commit && [[ -f .pre-commit-config.yaml ]]; then
  info "Installing pre-commit hooks"
  pre-commit install || warn "pre-commit install failed"
fi

cat <<EOF

Git repository initialized.
Next steps:
  1. Review: git status
  2. Optionally stage: git add .
  3. Optionally commit: git commit -m "chore: initial repository setup"
  4. Update changelog later with: make changelog
EOF
