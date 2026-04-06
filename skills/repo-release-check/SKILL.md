---
name: repo-release-check
description: Use when the user asks whether the project is ready to release, ship, deploy, or hand off. This skill validates the repository using the local release workflow and highlights blockers before deployment.
---

# Repo Release Check

## When to use

- The user asks if the repo is ready to release or deploy.
- The user wants a pre-release or pre-deploy checklist.
- The user wants confidence that docs, tests, and env are aligned.

## Workflow

1. Read `docs/release.md` and `docs/testing.md`.
2. Run the minimum local checks when possible:
   ```bash
   make check
   make validate-env
   make lint-md
   make test
   ```
3. If a specific app exists, include the relevant targeted checks:
   - `make test-web`
   - `make test-api`
4. Compare the intended deployment target against the documented architecture and ADRs.
5. Report blockers first, then residual risks, then release readiness.

## Output shape

- Release blockers
- Warnings and residual risks
- What was actually verified
- Recommended next deployment step

## Required references

- `docs/release.md`
- `docs/testing.md`
- `docs/architecture.md`
- `README.md`
- `docs/adr/`
