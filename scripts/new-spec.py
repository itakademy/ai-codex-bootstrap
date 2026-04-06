#!/usr/bin/env python3
from __future__ import annotations

import argparse
import datetime as dt
import getpass
import pathlib
import re
import sys


ROOT = pathlib.Path(__file__).resolve().parent.parent
SPECS_DIR = ROOT / "specs"
TEMPLATE_PATH = SPECS_DIR / "SPEC-TEMPLATE.md"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Create a new SPEC-XXX.md file.")
    parser.add_argument("--title", required=True, help="Specification title")
    parser.add_argument("--id", help="Optional explicit numeric id, for example 12")
    parser.add_argument("--status", default="draft", help="Initial status")
    parser.add_argument("--author", default=getpass.getuser(), help="Spec author")
    parser.add_argument(
        "--request-source",
        default="user request",
        help="Short description of the request source",
    )
    return parser.parse_args()


def next_spec_id() -> int:
    ids: list[int] = []
    for path in SPECS_DIR.glob("SPEC-*.md"):
        if path.name == "SPEC-TEMPLATE.md":
            continue
        match = re.fullmatch(r"SPEC-(\d{3})\.md", path.name)
        if match:
            ids.append(int(match.group(1)))
    return max(ids, default=0) + 1


def normalize_id(value: str | None) -> int:
    if value is None:
        return next_spec_id()
    return int(value)


def render_spec(spec_id: int, title: str, status: str, author: str, request_source: str) -> str:
    today = dt.date.today().isoformat()
    template = TEMPLATE_PATH.read_text(encoding="utf-8")
    spec_code = f"SPEC-{spec_id:03d}"

    replacements = {
        "SPEC-XXX": spec_code,
        "Titre de la specification": title,
        "- Status: `draft | validated | in-progress | done`": f"- Status: `{status}`",
        "- Author:": f"- Author: {author}",
        "- Request source:": f"- Request source: {request_source}",
        "- Created at: `YYYY-MM-DD`": f"- Created at: `{today}`",
        "- Updated at: `YYYY-MM-DD`": f"- Updated at: `{today}`",
    }

    for old, new in replacements.items():
        template = template.replace(old, new)

    return template


def main() -> int:
    args = parse_args()
    spec_id = normalize_id(args.id)
    target = SPECS_DIR / f"SPEC-{spec_id:03d}.md"

    if target.exists():
        print(f"Spec already exists: {target}", file=sys.stderr)
        return 1

    content = render_spec(
        spec_id=spec_id,
        title=args.title.strip(),
        status=args.status.strip(),
        author=args.author.strip(),
        request_source=args.request_source.strip(),
    )
    target.write_text(content, encoding="utf-8")
    print(f"Spec created: {target}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
