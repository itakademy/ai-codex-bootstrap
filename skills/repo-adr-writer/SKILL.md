---
name: repo-adr-writer
description: Use when the user asks to create, update, or clarify an architecture decision record in this repository, especially for durable decisions affecting stack choice, deployment, cost, security, testing, or operations.
---

# Repo ADR Writer

## When to use

- A technical decision should be preserved for later.
- The user asks to compare or choose between lasting architecture options.
- A change affects deployment target, framework choice, cost model, security posture, or operations.

## Workflow

1. Read `docs/adr/README.md` and `docs/adr/ADR-TEMPLATE.md`.
2. If a new ADR is needed, prefer:
   ```bash
   make new-adr TITLE="Decision d'architecture"
   ```
3. Write the ADR around:
   - context
   - decision
   - alternatives considered
   - consequences
4. Link related specs, recipes, and implementation paths when possible.
5. If the decision is already encoded in the repo, make the ADR match the actual current state.

## Quality bar

- The decision is explicit.
- Alternatives are concrete.
- Consequences are honest, including tradeoffs.
- The ADR can help a future developer understand why the choice was made.

## Required references

- `docs/adr/README.md`
- `docs/adr/ADR-TEMPLATE.md`
- `docs/architecture.md`
- `README.md`
- `SOUL.md`
