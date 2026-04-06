#!/usr/bin/env python3
from __future__ import annotations

import pathlib
import sys


ROOT = pathlib.Path(__file__).resolve().parent.parent
STATIC_DIR = ROOT / "apps" / "web-static"


def ensure_file(path: pathlib.Path) -> str | None:
    if not path.exists():
        return f"Missing file: {path.relative_to(ROOT)}"
    if not path.is_file():
        return f"Expected file but found something else: {path.relative_to(ROOT)}"
    return None


def ensure_contains(path: pathlib.Path, expected: str) -> str | None:
    content = path.read_text(encoding="utf-8")
    if expected not in content:
        return f"Missing expected content in {path.relative_to(ROOT)}: {expected}"
    return None


def main() -> int:
    errors: list[str] = []
    if not STATIC_DIR.exists():
        print(
            "[error] Missing apps/web-static. Add a static app or mount a submodule first.",
            file=sys.stderr,
        )
        return 1

    index_path = STATIC_DIR / "index.html"
    not_found_path = STATIC_DIR / "404.html"

    for path in (index_path, not_found_path):
        error = ensure_file(path)
        if error:
            errors.append(error)

    if not errors:
        for path in (index_path, not_found_path):
            for expected in ("<!doctype html>", "<html", "</html>"):
                error = ensure_contains(path, expected)
                if error:
                    errors.append(error)

    if errors:
        for error in errors:
            print(f"[error] {error}", file=sys.stderr)
        return 1

    print("Static site test passed")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
