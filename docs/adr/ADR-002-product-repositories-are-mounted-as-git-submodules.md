# ADR-002 - Product repositories are mounted as Git submodules

## Status

`accepted`

## Context

This template repository is intended to remain reusable over time. Product code should be allowed to evolve independently from the template so that:

- the template can continue to improve
- product repositories can have their own lifecycle
- template updates do not overwrite product code
- product repositories keep their own history, permissions, and release cadence

The products considered in this repository layout are:

- `apps/web-static`
- `apps/web`
- `apps/api`

The main options considered were:

- commit product code directly inside the template repository
- use Git submodules
- use Git subtree

## Decision

The template repository remains the parent orchestration repository, and product repositories are mounted under `apps/` as Git submodules when repository independence is required.

The supported target layout is:

- `apps/web-static` -> optional submodule
- `apps/web` -> optional submodule
- `apps/api` -> optional submodule

The parent repository keeps:

- docs
- specs
- ADRs
- recipes
- scripts
- shared workflow conventions
- infra orchestration

## Alternatives considered

- Commit product code directly into the template repository
  - Simpler Git UX
  - Does not preserve independent product repository history
  - Makes template updates and product ownership harder to separate

- Git subtree
  - Better UX than submodules in some teams
  - Less explicit separation between template and product ownership
  - Harder to keep the "independent repository mounted into workspace" mental model

- Git submodules
  - Clear repository boundaries
  - Independent history and permissions
  - Best fit for the user's requirement
  - More operational friction for developers unfamiliar with submodules

## Consequences

### Positive

- Template and product repositories stay independent.
- Product code is not overwritten by template evolution.
- Each product repository can have its own maintainers, release cycle, and access model.
- The parent repository remains focused on orchestration, documentation, and reusable workflow assets.

### Negative

- Git submodules add developer friction.
- Cloning and CI later require recursive submodule handling.
- Developers must understand submodule update, status, and detached HEAD behavior.

## Notes

- Related specs: `specs/SPEC-001-template-and-product-repository-separation.md`
- Related recipes: future Git workflow recipes
- Related implementation: `docs/release.md`, `docs/onboarding.md`, `docs/architecture.md`
