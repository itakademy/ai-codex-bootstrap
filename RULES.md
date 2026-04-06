# Rules

## Architecture

- Do not add a backend unless it is justified.
- Do not add dynamic frontend logic unless static delivery is insufficient.
- Prefer the smallest credible architecture.
- For Laravel deployment, default to `Lambda + Bref` unless a documented constraint justifies another target.
- Follow established repository patterns before inventing new ones.
- Do not duplicate existing functionality without a clear reason.

## Documentation

- Create or update a `SPEC` for significant product or feature work.
- Create or update an `ADR` for durable technical decisions.
- Capture reusable working procedures in `recipes/`.
- Keep onboarding and workflow documentation up to date when the repo changes.
- Use repository skills first when they match the task.

## Validation

- Run the relevant local checks before closing meaningful work.
- Prefer `make check`, `make validate-env`, `make lint-md`, and `make test`.
- Do not submit meaningful changes without relevant validation.
- If automated testing is not possible, document manual validation explicitly.
- Keep test coverage aligned with behavior changes on critical paths.

## Security

- Never commit secrets.
- Treat deployment defaults and environment handling as security-relevant.
- Document durable security-impacting choices.
- Do not bypass security checks or validation hooks without a documented reason.

## Delivery

- Keep changes focused and replayable.
- Do not leave the repository less clear than before.
- A task is not done if code changed but the required docs, specs, ADRs, or validation were skipped.
- Keep contributions reviewable and well-described.
- Prefer conventional commits such as `feat:`, `fix:`, `docs:`, `refactor:`, or `chore:`.
