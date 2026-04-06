---
name: repo-recipe-capture
description: Use when the user wants to document a working solution, a repeatable procedure, or a reusable troubleshooting flow in this repository. Applies to creating or updating recipe files under `recipes/`.
---

# Repo Recipe Capture

## When to use

- A working solution should be preserved.
- A troubleshooting or setup sequence is likely to be repeated.
- The user asks to document a process that should become a recipe.

## Workflow

1. Read `recipes/README.md`.
2. If a new recipe is needed, prefer:
   ```bash
   make new-recipe TITLE="Nom de la recipe"
   ```
3. For more complete capture, use:
   ```bash
   python3 scripts/save-recipe.py --title "..." --summary "..." --command "..."
   ```
4. Ensure the recipe captures:
   - context
   - decision
   - preconditions
   - replay commands
   - validation
5. Prefer commands that are deterministic and local to the repo when possible.

## Quality bar

- The recipe is worth replaying.
- The command sequence is concrete.
- Validation is explicit.
- The file can help another human or agent repeat the solution reliably.

## Required references

- `recipes/README.md`
- `README.md`
- `SOUL.md`
