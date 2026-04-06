#!/usr/bin/env python3
from __future__ import annotations

import argparse
import pathlib
import subprocess
import sys


ROOT = pathlib.Path(__file__).resolve().parent.parent
CHANGELOG_PATH = ROOT / "CHANGELOG.md"

SECTIONS = {
    "feat": "Added",
    "fix": "Fixed",
    "docs": "Changed",
    "refactor": "Changed",
    "perf": "Changed",
    "build": "Changed",
    "chore": "Changed",
    "test": "Changed",
    "ci": "Changed",
}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Rebuild the Unreleased section of CHANGELOG.md from git commits."
    )
    parser.add_argument(
        "--limit",
        type=int,
        default=50,
        help="Maximum number of commits to inspect",
    )
    return parser.parse_args()


def run_git(args: list[str]) -> str:
    result = subprocess.run(
        ["git", *args],
        cwd=ROOT,
        text=True,
        capture_output=True,
    )
    if result.returncode != 0:
        raise RuntimeError(result.stderr.strip() or "git command failed")
    return result.stdout


def ensure_git_repo() -> None:
    try:
        run_git(["rev-parse", "--is-inside-work-tree"])
    except RuntimeError as exc:
        raise RuntimeError("This command requires an initialized git repository.") from exc


def collect_commits(limit: int) -> dict[str, list[str]]:
    raw = run_git(["log", f"-n{limit}", "--pretty=format:%s"])
    grouped = {"Added": [], "Changed": [], "Fixed": []}

    for line in raw.splitlines():
        message = line.strip()
        if not message:
            continue

        entry = None
        if ":" in message:
            prefix, rest = message.split(":", 1)
            prefix = prefix.strip().lower()
            rest = rest.strip()
            commit_type = prefix.split("(", 1)[0]
            section = SECTIONS.get(commit_type)
            if section and rest:
                entry = (section, rest)

        if entry is None:
            entry = ("Changed", message)

        section, text = entry
        bullet = f"- {text[0].upper()}{text[1:]}" if text else "- Update"
        if bullet not in grouped[section]:
            grouped[section].append(bullet)

    return grouped


def render_changelog(grouped: dict[str, list[str]]) -> str:
    lines = [
        "# Changelog",
        "",
        "All notable changes to this template will be documented in this file.",
        "",
        "## Unreleased",
        "",
    ]

    has_entries = False
    for section in ("Added", "Changed", "Fixed"):
        entries = grouped.get(section, [])
        if not entries:
            continue
        has_entries = True
        lines.append(f"### {section}")
        lines.append("")
        lines.extend(entries)
        lines.append("")

    if not has_entries:
        lines.append("- No unreleased entries yet.")
        lines.append("")

    return "\n".join(lines).rstrip() + "\n"


def main() -> int:
    args = parse_args()

    try:
        ensure_git_repo()
        grouped = collect_commits(args.limit)
    except RuntimeError as exc:
        print(str(exc), file=sys.stderr)
        return 1

    CHANGELOG_PATH.write_text(render_changelog(grouped), encoding="utf-8")
    print(f"Changelog updated: {CHANGELOG_PATH}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
