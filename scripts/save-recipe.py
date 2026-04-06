#!/usr/bin/env python3
from __future__ import annotations

import argparse
import datetime as dt
import pathlib
import re
import sys


def slugify(value: str) -> str:
    value = value.strip().lower()
    value = re.sub(r"[^a-z0-9]+", "-", value)
    value = re.sub(r"-+", "-", value).strip("-")
    return value or "recipe"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Create a reusable recipe in recipes/."
    )
    parser.add_argument("--title", required=True, help="Recipe title")
    parser.add_argument("--summary", required=True, help="Why this recipe exists")
    parser.add_argument(
        "--command",
        action="append",
        default=[],
        help="Command to replay. Repeat the flag for multiple commands.",
    )
    parser.add_argument(
        "--validation",
        action="append",
        default=[],
        help="Validation step. Repeat the flag for multiple checks.",
    )
    parser.add_argument(
        "--slug",
        help="Optional explicit filename slug",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    slug = args.slug or slugify(args.title)
    path = pathlib.Path("recipes") / f"{slug}.md"

    if path.exists():
        print(f"Recipe already exists: {path}", file=sys.stderr)
        return 1

    commands = args.command or ["# add replay command here"]
    validations = args.validation or ["# add validation step here"]
    today = dt.date.today().isoformat()

    content = f"""# {args.title}

## Contexte
{args.summary}

## Date
{today}

## Commandes
```bash
{chr(10).join(commands)}
```

## Validation
{chr(10).join(f"- {item}" for item in validations)}
"""

    path.write_text(content, encoding="utf-8")
    print(f"Recipe created: {path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
