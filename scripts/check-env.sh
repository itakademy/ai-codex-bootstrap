#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./lib/common.sh
source "${SCRIPT_DIR}/lib/common.sh"

required_tools=(aws gh node npm npx python3)
optional_tools=(composer php docker direnv pre-commit shellcheck)
missing=0
version_mismatch=0

check_version() {
  local label="$1"
  local actual="$2"
  local expected="$3"

  if [[ -z "$expected" || -z "$actual" ]]; then
    return 0
  fi

  if [[ "$actual" == "$expected" ]]; then
    echo "  [ok] ${label} version ${actual}"
  else
    echo "  [warn] ${label} version ${actual} (expected ${expected} from .tool-versions)"
    version_mismatch=1
  fi
}

extract_tool_version() {
  local tool_name="$1"

  if [[ ! -f .tool-versions ]]; then
    return 0
  fi

  awk -v tool="$tool_name" '$1 == tool { print $2 }' .tool-versions
}

echo "Checking required tools"
for tool in "${required_tools[@]}"; do
  if command -v "$tool" >/dev/null 2>&1; then
    echo "  [ok] $tool"
  else
    echo "  [missing] $tool"
    missing=1
  fi
done

echo
echo "Checking optional tools"
for tool in "${optional_tools[@]}"; do
  if command -v "$tool" >/dev/null 2>&1; then
    echo "  [ok] $tool"
  else
    echo "  [warn] $tool"
  fi
done

echo
echo "Checking version manager"
if command -v asdf >/dev/null 2>&1; then
  echo "  [ok] asdf"
else
  echo "  [warn] asdf not installed (recommended for reproducible local runtimes)"
fi

if command -v direnv >/dev/null 2>&1; then
  echo "  [ok] direnv"
else
  echo "  [warn] direnv not installed (recommended for automatic project env loading)"
fi

if command -v pre-commit >/dev/null 2>&1; then
  echo "  [ok] pre-commit"
else
  echo "  [warn] pre-commit not installed (recommended for local quality gates)"
fi

echo
echo "Checking runtime versions"
check_version "node" "$(node -v 2>/dev/null | sed 's/^v//')" "$(extract_tool_version nodejs)"
check_version "python" "$(python3 --version 2>/dev/null | awk '{print $2}')" "$(extract_tool_version python)"

if command -v php >/dev/null 2>&1; then
  check_version "php" "$(php -r 'echo PHP_VERSION;' 2>/dev/null)" "$(extract_tool_version php)"
else
  echo "  [warn] php version not checked"
fi

if [[ -f .env.schema ]]; then
  echo
  echo "Checking env schema"
  python3 ./scripts/validate-env.py --allow-missing-env || exit 1
fi

echo
if [[ "$missing" -eq 1 ]]; then
  echo "Environment check failed."
  exit 1
fi

if [[ "$version_mismatch" -eq 1 ]]; then
  echo "Environment check passed with version warnings."
  exit 0
fi

echo "Environment check passed."
