# Repository Topology

## Goal

Keep the template independent from product code while allowing a single working tree for development and deployment orchestration.

## Recommended model

Use:

- one GitHub repository for the template
- zero or more GitHub repositories for products
- Git submodules under `apps/` to mount product repositories into the template workspace

## Parent repository

The parent repository should own:

- `docs/`
- `specs/`
- `recipes/`
- `skills/`
- `scripts/`
- `infra/`
- shared rules, onboarding, release, testing, and automation

The parent repository should not own the business history of product code when independence is required.

## Product repositories

Supported product mount points:

- `apps/web-static`
- `apps/web`
- `apps/api`

Each of these paths may be:

- absent
- a local directory during early experimentation
- a Git submodule when product independence is required

## Example layout

```text
template-repo/
├── apps/
│   ├── web-static/   # optional Git submodule
│   ├── web/          # optional Git submodule
│   └── api/          # optional Git submodule
├── docs/
├── specs/
├── recipes/
├── skills/
├── scripts/
└── infra/
```

## Typical workflow

### Add a product repository as submodule

```bash
git submodule add git@github.com:your-org/product-web.git apps/web
git submodule add git@github.com:your-org/product-api.git apps/api
```

Repo helpers:

```bash
make add-submodule-web URL=git@github.com:your-org/product-web.git
make add-submodule-api URL=git@github.com:your-org/product-api.git
```

For the static site:

```bash
make add-submodule-static URL=git@github.com:your-org/product-web-static.git
```

### Clone later with submodules

```bash
git clone --recurse-submodules git@github.com:your-org/template.git
```

If already cloned:

```bash
git submodule update --init --recursive
```

Repo helper:

```bash
make submodules-sync
```

### Update the template

```bash
git pull
git submodule update --init --recursive
```

Template updates change the parent repository only, unless you intentionally move a submodule pointer.

### Update a product repository

```bash
cd apps/web
git checkout main
git pull
```

Then in the parent repository:

```bash
git status
```

If you want the parent repo to record the new product commit, commit the submodule pointer update there.

Repo helpers:

```bash
make submodules-sync
make submodules-update
```

## Why this works

- The template keeps its own Git history.
- Product repositories keep their own Git history.
- The parent repository only tracks submodule pointers, not product internals.
- Template evolution and product evolution remain separable.

## Known tradeoffs

- Submodules are more complex than a single repository.
- Developers must learn `git submodule` basics.
- CI later must fetch submodules explicitly.

## When not to use submodules

Do not use this model if:

- you want a single repository and single release cycle for everything
- the product is still exploratory and repository separation adds more friction than value
- the team is unwilling to manage standard submodule ergonomics

## Recommendation

For this template, Git submodules are a valid and recommended approach when product independence is a real requirement.
