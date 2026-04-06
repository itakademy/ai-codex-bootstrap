# SPEC-001 - Template and product repository separation

## 1. Metadata
- ID: `SPEC-001`
- Title: Template and product repository separation
- Status: `validated`
- Author: codex
- Request source: user request
- Created at: `2026-04-06`
- Updated at: `2026-04-06`

## 2. Contexte
The repository is evolving from a simple template into a reusable operating model. The user wants to keep the template versioned independently on GitHub while keeping generated products independent as well, so template updates remain possible even after product code exists.

The products considered are:

- static frontend
- dynamic frontend
- API

The repository already has strong template-level assets:

- docs
- specs
- ADRs
- recipes
- scripts
- release and testing workflow

The missing piece is a repository topology that preserves independence between template code and product code.

## 3. Objectif
Allow the template repository and each generated product repository to evolve independently while still working together in a single local workspace.

## 4. Scope

### In scope
- define a Git/GitHub repository strategy for the template and product code
- define where static frontend, dynamic frontend, and API repositories should live
- define update workflow for the template
- define update workflow for product repositories
- define local workspace conventions
- define onboarding implications

### Out of scope
- implementing GitHub Actions
- provisioning remotes automatically
- writing product-specific business code
- replacing Git submodules with another VCS model in this spec

## 5. Acteurs et usages

### Acteurs
- Utilisateur final: consumes the deployed product
- Developpeur template: evolves the reusable template
- Developpeur produit: evolves one or more product repositories
- Systeme externe: GitHub

### Parcours principaux
1. A team updates the template repository without modifying product repositories.
2. A team updates a product repository without changing template internals.
3. A team consumes a newer template version while keeping product code intact.

## 6. Exigences fonctionnelles
- `FR-001`: The template repository must remain a standalone GitHub repository.
- `FR-002`: Each product repository must remain independently versioned on GitHub.
- `FR-003`: The local workspace must allow the template repository to reference product repositories without absorbing their Git history.
- `FR-004`: Template updates must not overwrite product code by default.
- `FR-005`: Product updates must not require copying code back into the template repository.
- `FR-006`: The repository structure must support zero, one, or several product repositories at once.
- `FR-007`: The workflow must support `apps/web-static`, `apps/web`, and `apps/api` as independent sub-repositories.

## 7. Exigences non fonctionnelles

### Performance
- Repository operations must remain simple enough for day-to-day developer use.

### Securite
- Secrets must not be stored in `.gitmodules` or committed bootstrap scripts.
- Access to private product repositories must rely on GitHub credentials outside the repo.

### Observabilite
- The repository topology must be understandable through docs and onboarding.

### Cout
- The Git topology must not force additional paid infrastructure.

### Deploiement
- Deployment commands must continue to work against product paths mounted in `apps/`.

## 8. Donnees et integrations

### Donnees
- Entites:
  - template repository
  - static web repository
  - dynamic web repository
  - API repository
- Validation:
  - submodule paths must resolve under `apps/`
- Retention:
  - each repository keeps its own Git history

### Integrations
- Service: GitHub
- Sens du flux: template repository references product repositories
- Format: Git submodules

## 9. Architecture proposee

### Choix
- Frontend: static or `Next.js` repository mounted as Git submodule under `apps/`
- Backend: `Laravel` repository mounted as Git submodule under `apps/api`
- Infra: template repository remains the parent workspace and orchestration layer
- DNS: unchanged, `Cloudflare`

### Justification
- Git submodules preserve independent history and repository ownership.
- The parent template repository can evolve docs, scripts, testing, release workflow, and infra without swallowing product code.
- Product repositories stay independent and can have their own lifecycle, issues, releases, and permissions.
- This model matches the user's requirement better than copying generated code directly into the template repository.

## 10. UX / API / contrats

### UI
- Pages ou composants:
  - not applicable
- Etats:
  - submodule present
  - submodule absent
  - submodule pinned to a specific commit
- Cas d'erreur:
  - missing submodule initialization
  - detached submodule state not understood by the developer

### API
- Endpoint:
  - not applicable
- Methode:
  - not applicable
- Auth:
  - GitHub authentication for submodule fetches
- Input:
  - submodule URL and path
- Output:
  - checked-out repository in `apps/`
- Errors:
  - missing access rights
  - submodule not initialized
  - branch/commit mismatch

## 11. Critères d'acceptation
- `AC-001`: The template repository can exist on GitHub without product code committed directly inside it.
- `AC-002`: A product repository can be mounted under `apps/` as a Git submodule.
- `AC-003`: Updating the template repository does not overwrite product repository history.
- `AC-004`: Updating a product repository only changes the submodule pointer in the template repository when desired.
- `AC-005`: The workflow is documented well enough for onboarding and release usage.

## 12. Plan d'implementation
1. Phase 1: Document the repository topology and choose Git submodules as the supported mechanism.
2. Phase 2: Add ADR and operational docs for onboarding and release.
3. Phase 3: Optionally add helper scripts for adding or syncing product submodules.

## 13. Validation
- Tests unitaires:
  - not applicable
- Tests integration:
  - validate the documented Git workflow on a real repository later
- Tests end-to-end:
  - initialize parent repo, add product submodule, update template separately
- Verification manuelle:
  - docs review and future dry-run with real Git remotes

## 14. Hypotheses
- Product repositories are hosted on GitHub.
- Teams accept standard Git submodule ergonomics.
- The parent repository remains the orchestration layer, not the owner of product code.

## 15. Risques
- Submodules are more complex than a single repository workflow.
- Developer onboarding is harder if submodule commands are not documented well.
- CI and cloning workflows need recursive submodule support later.

## 16. Questions ouvertes
- Should helper scripts be added to automate `git submodule add`, `update`, and `sync`?
- Should the template support private product repositories by default in docs?
