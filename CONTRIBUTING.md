# Contributing

## Goal

Move fast without losing clarity.

## First read

Start with `docs/onboarding.md` if you are new to the repository.

## Default flow

1. Read the current repo shape and constraints.
2. If the request is product or feature oriented, create or update a spec first.
3. If the change introduces a durable architecture decision, record an ADR.
4. Implement the smallest useful slice.
5. Validate locally.
6. Update docs, recipes, or changelog when the change is reusable or important.

## Local commands

```bash
make check
make validate-env
make changelog
make lint
make test
make dev
```

## Specifications

- Specs live in `specs/`.
- Naming convention: `SPEC-XXX.md`.
- Generate a new spec with:

```bash
make new-spec TITLE="Titre de la spec"
```

## ADRs

- ADRs live in `docs/adr/`.
- Naming convention: `ADR-XXX.md`.
- Use an ADR when a technical or architectural decision should be preserved for later.

## Skills

- Repository-specific Codex skills live in `skills/`.
- Install them locally into Codex with:

```bash
make install-skills
```

## Recipes

- Recipes live in `recipes/`.
- Start a new recipe with:

```bash
make new-recipe TITLE="Nom de la recipe"
```

## Environment

- Runtime versions are tracked in `.tool-versions`.
- Environment variables are documented in `.env.schema`.
- Validate `.env` with:

```bash
make validate-env
```

## Testing

- Testing workflow is documented in `docs/testing.md`.
- Before closing substantial work, run:

```bash
make test
```

## Release

- Release workflow is documented in `docs/release.md`.

## Quality bar

- Keep diffs focused.
- Prefer deterministic scripts and replayable steps.
- Keep requirements and assumptions explicit.
- Avoid adding infrastructure or services before they are justified.

## Commit style

Prefer conventional commit prefixes when possible:

- `feat:`
- `fix:`
- `docs:`
- `refactor:`
- `chore:`

This keeps `make changelog` useful and readable.
