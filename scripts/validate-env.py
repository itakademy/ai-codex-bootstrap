#!/usr/bin/env python3
from __future__ import annotations

import argparse
import pathlib
import sys


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Validate .env against .env.schema.")
    parser.add_argument("--env-file", default=".env", help="Path to the env file")
    parser.add_argument("--schema-file", default=".env.schema", help="Path to the schema file")
    parser.add_argument(
        "--allow-missing-env",
        action="store_true",
        help="Return success when the env file does not exist",
    )
    return parser.parse_args()


def parse_schema(path: pathlib.Path) -> dict[str, dict[str, object]]:
    schema: dict[str, dict[str, object]] = {}

    for raw_line in path.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line or line.startswith("#"):
            continue

        parts = [part.strip() for part in raw_line.split("|")]
        if len(parts) < 3:
            raise ValueError(f"Invalid schema line: {raw_line}")

        key, requirement, description = parts[:3]
        allowed_values = []
        if len(parts) > 3 and parts[3].strip():
            allowed_values = [item.strip() for item in parts[3].split(",") if item.strip()]

        schema[key] = {
            "required": requirement == "required",
            "description": description,
            "allowed_values": allowed_values,
        }

    return schema


def strip_quotes(value: str) -> str:
    if len(value) >= 2 and value[0] == value[-1] and value[0] in {"'", '"'}:
        return value[1:-1]
    return value


def parse_env(path: pathlib.Path) -> dict[str, str]:
    values: dict[str, str] = {}

    for raw_line in path.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line or line.startswith("#"):
            continue
        if line.startswith("export "):
            line = line[7:].strip()
        if "=" not in line:
            continue
        key, value = line.split("=", 1)
        values[key.strip()] = strip_quotes(value.strip())

    return values


def main() -> int:
    args = parse_args()
    env_path = pathlib.Path(args.env_file)
    schema_path = pathlib.Path(args.schema_file)

    if not schema_path.exists():
        print(f"Missing schema file: {schema_path}", file=sys.stderr)
        return 1

    if not env_path.exists():
        message = f"Missing env file: {env_path}"
        if args.allow_missing_env:
            print(f"[warn] {message}")
            return 0
        print(message, file=sys.stderr)
        return 1

    schema = parse_schema(schema_path)
    env_values = parse_env(env_path)

    errors: list[str] = []
    warnings: list[str] = []

    for key, meta in schema.items():
        value = env_values.get(key, "")
        if meta["required"] and value == "":
            errors.append(f"Missing required variable: {key}")
            continue

        allowed_values = meta["allowed_values"]
        if value and allowed_values and value not in allowed_values:
            errors.append(
                f"Invalid value for {key}: {value}. Allowed: {', '.join(allowed_values)}"
            )

    for key in sorted(env_values):
        if key not in schema:
            warnings.append(f"Unknown variable in env file: {key}")

    for warning in warnings:
        print(f"[warn] {warning}")

    if errors:
        for error in errors:
            print(f"[error] {error}", file=sys.stderr)
        return 1

    print(f"Environment file {env_path} matches schema {schema_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
