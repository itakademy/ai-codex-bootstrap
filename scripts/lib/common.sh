#!/usr/bin/env bash

set -euo pipefail

info() {
  echo "$*"
}

warn() {
  echo "$*" >&2
}

fail() {
  echo "$*" >&2
  exit 1
}

has_command() {
  command -v "$1" >/dev/null 2>&1
}

ensure_git_repo() {
  require_command git

  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    fail "This command requires an initialized git repository."
  fi
}

require_command() {
  local tool="$1"

  if ! has_command "$tool"; then
    fail "$tool is required."
  fi
}

require_missing_path() {
  local path="$1"

  if [[ -e "$path" ]]; then
    fail "Target already exists: $path"
  fi
}

require_dir() {
  local path="$1"
  local message="${2:-Missing directory: $path}"

  if [[ ! -d "$path" ]]; then
    fail "$message"
  fi
}

require_file() {
  local path="$1"
  local message="${2:-Missing file: $path}"

  if [[ ! -f "$path" ]]; then
    fail "$message"
  fi
}

require_var() {
  local value="$1"
  local message="$2"

  if [[ -z "$value" ]]; then
    fail "$message"
  fi
}
