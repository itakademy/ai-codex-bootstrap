---
name: repo-stack-decision
description: Use when the user asks which stack, architecture, or deployment strategy to choose in this repository. Applies to choosing between static web, Next.js, Laravel, Lambda + Bref, and ECS Fargate.
---

# Repo Stack Decision

## When to use

- The user asks what to build with.
- The user asks whether a backend is needed.
- The user asks whether to use static web, `Next.js`, or `Laravel`.
- The user asks which AWS target should be used.

## Workflow

1. Read:
   - `SOUL.md`
   - `docs/architecture.md`
   - `README.md`
   - `docs/adr/ADR-001-laravel-api-deploy-target-defaults-to-lambda-bref.md`
2. Decide from the smallest credible option:
   - static site first
   - `Next.js` only if SSR or server-side frontend logic is needed
   - `Laravel` only if a real backend boundary is justified
3. For Laravel deployment:
   - default to `Lambda + Bref`
   - choose `ECS Fargate` only when the serverless path is not a good fit
4. State assumptions and tradeoffs clearly.
5. If the decision is durable, recommend or create an ADR.
6. If the decision shapes implementation scope, recommend or create a SPEC.

## Output shape

- Recommended stack
- Why it is the smallest credible option
- Tradeoffs
- Next implementation step
- Whether a SPEC or ADR should be created or updated

## Required references

- `SOUL.md`
- `docs/architecture.md`
- `README.md`
- `docs/adr/ADR-001-laravel-api-deploy-target-defaults-to-lambda-bref.md`
