# ADRs

Architecture Decision Records preserve the important technical decisions made in this repository.

## Convention

- Naming format: `ADR-XXX.md`
- Example: `ADR-001-cache-strategy.md`, `ADR-002-api-deploy-target.md`
- Start from `ADR-TEMPLATE.md`
- Generate a new ADR with `make new-adr TITLE="Decision d'architecture"`

## When to create an ADR

- Choosing between `Lambda + Bref` and `ECS Fargate`
- Deciding whether a feature needs `Laravel`
- Deciding whether a frontend stays static or moves to `Next.js`
- Any decision that changes cost, operations, security, or architecture in a lasting way

## Rule

- One ADR per decision
- Keep the context, decision, alternatives, and consequences explicit
- Do not use ADRs for trivial implementation details
