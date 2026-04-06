#!/usr/bin/env python3
from __future__ import annotations

import argparse
import pathlib
import re
import sys


ROOT = pathlib.Path(__file__).resolve().parent.parent
ADR_DIR = ROOT / "docs" / "adr"
TEMPLATE_PATH = ADR_DIR / "ADR-TEMPLATE.md"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Create a new ADR-XXX.md file.")
    parser.add_argument("--title", required=True, help="ADR title")
    parser.add_argument("--id", help="Optional explicit numeric id, for example 3")
    parser.add_argument("--status", default="proposed", help="Initial ADR status")
    return parser.parse_args()


def next_adr_id() -> int:
    ids: list[int] = []
    for path in ADR_DIR.glob("ADR-*.md"):
        if path.name == "ADR-TEMPLATE.md":
            continue
        match = re.fullmatch(r"ADR-(\d{3})\.md", path.name)
        if match:
            ids.append(int(match.group(1)))
    return max(ids, default=0) + 1


def normalize_id(value: str | None) -> int:
    if value is None:
        return next_adr_id()
    return int(value)


def slugify(value: str) -> str:
    value = value.strip().lower()
    value = re.sub(r"[^a-z0-9]+", "-", value)
    value = re.sub(r"-+", "-", value).strip("-")
    return value or "decision"


def render_adr(adr_id: int, title: str, status: str) -> str:
    template = TEMPLATE_PATH.read_text(encoding="utf-8")
    adr_code = f"ADR-{adr_id:03d}"

    replacements = {
        "ADR-XXX": adr_code,
        "Title": title,
        "`proposed | accepted | deprecated | superseded`": f"`{status}`",
    }

    for old, new in replacements.items():
        template = template.replace(old, new)

    return template


def main() -> int:
    args = parse_args()
    adr_id = normalize_id(args.id)
    slug = slugify(args.title)
    target = ADR_DIR / f"ADR-{adr_id:03d}-{slug}.md"

    if target.exists():
        print(f"ADR already exists: {target}", file=sys.stderr)
        return 1

    content = render_adr(
        adr_id=adr_id,
        title=args.title.strip(),
        status=args.status.strip(),
    )
    target.write_text(content, encoding="utf-8")
    print(f"ADR created: {target}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
