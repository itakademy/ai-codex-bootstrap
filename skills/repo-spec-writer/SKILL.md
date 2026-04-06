---
name: repo-spec-writer
description: Use when the user asks to create, update, refine, or complete a project specification in this repository. Applies to feature specs, module specs, API specs, workflow specs, and any request that should become a `SPEC-XXX.md`.
---

# Repo Spec Writer

## When to use

- The user describes a feature, workflow, module, API, or product need.
- A request should be formalized before implementation.
- An existing spec in `specs/` needs to be updated or completed.

## Workflow

1. Read `docs/specs.md`, `specs/README.md`, and `specs/SPEC-TEMPLATE.md`.
2. If a new spec is needed, prefer:
   ```bash
   make new-spec TITLE="Titre de la spec"
   ```
3. Fill the spec so it is implementation-ready, not aspirational.
4. Make assumptions only when risk is low, and record them explicitly.
5. Keep architecture aligned with this repo:
   - static first
   - `Next.js` only if needed
   - `Laravel` only if needed
   - `SST` on AWS
   - `Cloudflare` for DNS
6. Ensure the spec includes testable requirements and acceptance criteria.

## Quality bar

- Scope is explicit.
- Requirements are testable.
- Risks and assumptions are visible.
- The implementation can start without rediscovering the problem.

## Required references

- `docs/specs.md`
- `specs/README.md`
- `specs/SPEC-TEMPLATE.md`
- `docs/architecture.md`
- `SOUL.md`
