#!/usr/bin/env python3
from __future__ import annotations

import argparse
import datetime as dt
import pathlib
import re
import sys


ROOT = pathlib.Path(__file__).resolve().parent.parent
RECIPES_DIR = ROOT / "recipes"


def slugify(value: str) -> str:
    value = value.strip().lower()
    value = re.sub(r"[^a-z0-9]+", "-", value)
    value = re.sub(r"-+", "-", value).strip("-")
    return value or "recipe"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Create a new recipe markdown file.")
    parser.add_argument("--title", required=True, help="Recipe title")
    parser.add_argument("--slug", help="Optional explicit filename slug")
    parser.add_argument(
        "--context",
        default="Describe when this recipe should be used.",
        help="Short recipe context",
    )
    return parser.parse_args()


def render_recipe(title: str, context: str) -> str:
    today = dt.date.today().isoformat()
    return f"""# {title}

## Contexte
{context}

## Date
{today}

## Decision
Describe the chosen solution.

## Preconditions
- 

## Commandes
```bash
# add replay command here
```

## Validation
- 
"""


def main() -> int:
    args = parse_args()
    slug = args.slug or slugify(args.title)
    target = RECIPES_DIR / f"{slug}.md"

    if target.exists():
        print(f"Recipe already exists: {target}", file=sys.stderr)
        return 1

    target.write_text(
        render_recipe(args.title.strip(), args.context.strip()),
        encoding="utf-8",
    )
    print(f"Recipe created: {target}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
