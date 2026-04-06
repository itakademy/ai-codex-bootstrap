#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./lib/common.sh
source "${SCRIPT_DIR}/lib/common.sh"

MODE="${1:-copy}"
REPO_SKILLS_DIR="${SCRIPT_DIR%/scripts}/skills"
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"
TARGET_DIR="${CODEX_HOME_DIR}/skills"

require_dir "$REPO_SKILLS_DIR" "Missing repo skills directory: $REPO_SKILLS_DIR"
require_command mkdir

if [[ "$MODE" != "copy" && "$MODE" != "link" ]]; then
  fail "Usage: ./scripts/install-skills.sh [copy|link]"
fi

mkdir -p "$TARGET_DIR"

for skill_dir in "$REPO_SKILLS_DIR"/*; do
  [[ -d "$skill_dir" ]] || continue
  skill_name="$(basename "$skill_dir")"
  target_path="${TARGET_DIR}/${skill_name}"

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    rm -rf "$target_path"
  fi

  if [[ "$MODE" == "link" ]]; then
    ln -s "$skill_dir" "$target_path"
    info "Linked skill: $skill_name -> $target_path"
  else
    cp -R "$skill_dir" "$target_path"
    info "Copied skill: $skill_name -> $target_path"
  fi
done

cat <<EOF

Skills installed to:
  $TARGET_DIR

Mode:
  $MODE

Restart or refresh Codex if your environment caches the skills list.
EOF
