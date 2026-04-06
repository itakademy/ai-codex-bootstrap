![IT-Akademy Codex Bootstrap cover](assets/social/Gemini_Generated_Image_8nq5u08nq5u08nq5.jpg)

# IT-Akademy AI Delivery Template

Template IT-Akademy pour un workflow de developpement AI centre execution.

Ce repository sert de socle standard pour lancer, cadrer, documenter, tester et livrer des produits IA ou assistes par IA dans un cadre IT-Akademy.

## Positionnement
- Standard de travail IT-Akademy pour les projets AI-first
- Priorite a l'execution, a la clarte, et a la rejouabilite
- Documentation structuree par `SPEC`, `ADR` et `recipes`
- Separation nette entre template, produits, et decisions d'architecture

## Principes
- Standardiser un mode de delivery compatible IT-Akademy
- Backend seulement si necessaire: `Laravel`
- Frontend seulement si necessaire: `Next.js`
- Deploiement par defaut sur AWS via `SST`
- DNS gere par `Cloudflare`
- Scripts deterministes en `shell` ou `Python`
- Toute solution valide et rejouable est archivee dans `recipes/`

## Structure
```text
.
├── AGENTS.md
├── apps/
│   └── README.md
├── docs/
│   ├── adr/
│   ├── architecture.md
│   ├── onboarding.md
│   ├── release.md
│   ├── repository-topology.md
│   ├── specs.md
│   ├── testing.md
│   └── workflow.md
├── infra/
│   └── app.ts
├── recipes/
│   ├── README.md
│   ├── laravel-api-lambda-bref.md
│   └── next-static-s3-cloudfront.md
├── skills/
│   ├── repo-adr-writer/
│   ├── repo-recipe-capture/
│   ├── repo-release-check/
│   ├── repo-spec-writer/
│   └── repo-stack-decision/
├── scripts/
│   ├── bootstrap-static.sh
│   ├── bootstrap-laravel.sh
│   ├── bootstrap-next.sh
│   ├── check-env.sh
│   ├── init-repo.sh
│   ├── install-skills.sh
│   ├── lib/
│   ├── new-adr.py
│   ├── new-recipe.py
│   ├── new-spec.py
│   ├── save-recipe.py
│   ├── submodule-add.sh
│   ├── submodules-sync.sh
│   ├── submodules-update.sh
│   ├── test-static.py
│   └── update-changelog.py
├── specs/
│   ├── README.md
│   └── SPEC-TEMPLATE.md
├── .env.schema
├── .env.example
├── .envrc.example
├── .gitignore
├── .editorconfig
├── .markdownlint-cli2.jsonc
├── .pre-commit-config.yaml
├── .python-version
├── .tool-versions
├── CHANGELOG.md
├── CONTRIBUTING.md
├── CREDITS.md
├── RULES.md
├── SECURITY.md
├── SOUL.md
├── VERSION
├── Makefile
├── package.json
├── sst.config.ts
└── tsconfig.json
```

## Demarrage
```bash
asdf plugin add nodejs
asdf plugin add python
asdf plugin add php
asdf install
cp .env.example .env
make check
npm install
```

`asdf` est recommande pour figer les versions locales de `node`, `python` et `php`, mais reste optionnel.

## Onboarding

- Point d'entree pour les futurs developpeurs IT-Akademy
- Point d'entree principal: `docs/onboarding.md`
- A lire des l'arrivee sur le repo
- Couvre setup local, conventions, workflow, specs, ADRs et commandes de base
- Topologie de depots et submodules: `docs/repository-topology.md`

## Credits

- Technologies referencees dans `CREDITS.md`

## Security

- Security policy in `SECURITY.md`

## Soul

- Intention et principes du template dans `SOUL.md`

## Rules

- Regles normatives courtes dans `RULES.md`

## Skills

- Skills locaux versionnes dans `skills/`
- Inclus:
  - `repo-spec-writer`
  - `repo-adr-writer`
  - `repo-release-check`
  - `repo-recipe-capture`
  - `repo-stack-decision`
- Installation dans Codex:
  ```bash
  make install-skills
  ```
- Variante symlink pour dev local:
  ```bash
  ./scripts/install-skills.sh link
  ```

## Outils recommandes
```bash
# asdf
asdf plugin add nodejs
asdf plugin add python
asdf plugin add php
asdf install

# direnv
make setup-env
direnv allow

# pre-commit
make setup-hooks
```

- `asdf`: versions locales reproductibles
- `direnv`: chargement automatique de `.env`
- `pre-commit`: quality gates locaux avant commit
- `shellcheck`: verification des scripts shell
- `markdownlint-cli2`: verification des specs et de la documentation
- `.editorconfig`: style de base coherent entre editeurs

Si tu veux que `SST` gere aussi les enregistrements DNS via `Cloudflare`, ajoute une fois le provider:
```bash
sst add cloudflare
```

Les applications produit ne sont pas creees par defaut. `apps/` reste vide tant qu'aucun produit n'est bootstrappe ou monte en submodule.

Si tu as besoin d'un frontend statique, monte un submodule dans `apps/web-static/` ou cree l'app explicitement:
```bash
make bootstrap-static
```

Si tu as besoin d'un vrai front `Next.js`:
```bash
make bootstrap-next
```

Si tu as besoin d'une API `Laravel` dockerisee:
```bash
make bootstrap-laravel
```

## Commandes utiles
```bash
make check
make validate-env
make changelog
make lint
make lint-md
make lint-shell
make test
make test-static
make test-web
make test-api
make setup-env
make setup-hooks
make bootstrap-static
make new-spec TITLE="Titre de la spec"
make new-adr TITLE="Decision d'architecture"
make new-recipe TITLE="Nom de la recipe"
make init-repo
make add-submodule-web URL=git@github.com:org/product-web.git
make add-submodule-api URL=git@github.com:org/product-api.git
make submodules-sync
make submodules-update
make dev
make dev-static
make dev-web
make dev-api
make bootstrap-next
make bootstrap-laravel
npm run sst:dev
npm run sst:deploy
python3 scripts/save-recipe.py --title "Nom de la solution" --summary "Contexte et decision" --command "make check"
```

## Serveurs de developpement locaux
- `make dev`: choisit automatiquement `apps/web`, puis `apps/web-static`, puis `apps/api`
- `make dev`: echoue explicitement si aucune app n'est presente dans `apps/`
- `make dev-static`: sert `apps/web-static` sur `http://127.0.0.1:3000` si une app statique existe
- `make dev-web`: lance le serveur `Next.js` depuis `apps/web`
- `make dev-api`: lance `Laravel Sail` depuis `apps/api`

## Tests
- Workflow detaille: `docs/testing.md`
- `make test`: lance les tests des apps presentes, sinon sort proprement avec un message explicite
- `make test-static`: valide `apps/web-static` si une app statique existe
- `make test-web`: lance les tests du frontend `Next.js` si present
- `make test-api`: lance les tests Laravel si presents
- `bootstrap-static` cree un frontend statique minimal dans `apps/web-static`
- `bootstrap-next` prepare une base `Vitest`
- `bootstrap-laravel` ajoute un test de sante applicative

## Specifications projet
- Les specs vivent dans `specs/`
- Convention de nommage: `SPEC-XXX.md`
- Point de depart: `specs/SPEC-TEMPLATE.md`
- Methode de generation: `docs/specs.md`
- Generation rapide: `make new-spec TITLE="Titre de la spec"`

## ADRs
- Les ADRs vivent dans `docs/adr/`
- Convention de nommage: `ADR-XXX.md`
- Point de depart: `docs/adr/ADR-TEMPLATE.md`
- Generation rapide: `make new-adr TITLE="Decision d'architecture"`

## Recipes
- Les recipes vivent dans `recipes/`
- Generation rapide: `make new-recipe TITLE="Nom de la recipe"`
- Finalisation guidee: `python3 scripts/save-recipe.py ...`

## Variables d'environnement
- Le schema vit dans `.env.schema`
- Validation: `make validate-env`

## Changelog
- Mise a jour locale: `make changelog`
- Source: historique Git local
- Convention recommandee: commits de type `feat:`, `fix:`, `docs:`, `refactor:`, `chore:`

## Git local
- Initialisation assistee: `make init-repo`
- Installe aussi `pre-commit` si disponible
- Gestion des submodules produit:
  - `make add-submodule-web URL=...`
  - `make add-submodule-api URL=...`
  - `make add-submodule-static URL=...`
  - `make submodules-sync`
  - `make submodules-update`

## Release / livraison
- Guide detaille: `docs/release.md`
- Le flux vise une livraison reproductible et maintenable dans un contexte IT-Akademy

## Regles d'architecture
- Pas de backend par defaut.
- Pas de frontend dynamique par defaut.
- Le mode le moins cher reste le site statique `S3 + CloudFront`.
- `Next.js` n'est active que si SSR ou logique serveur est necessaire.
- `Laravel` est cree a la demande et tourne en local via Docker Compose avec MariaDB et Redis.
- Si `Laravel` doit etre deployee, la cible AWS par defaut est `AWS Lambda + API Gateway` via `Bref`.
- `ECS Fargate` ne devient la cible qu'en fallback si le mode serverless n'est pas adapte.
- Les DNS Cloudflare sont geres par l'adapter SST quand les variables Cloudflare sont renseignees.
- Pour le DNS Cloudflare gere par SST, il faut ajouter le provider une fois avec `sst add cloudflare`.

## References officielles
- SST Config: [sst.dev/docs/reference/config](https://sst.dev/docs/reference/config/)
- SST StaticSite: [sst.dev/docs/component/aws/static-site](https://sst.dev/docs/component/aws/static-site/)
- SST Nextjs: [sst.dev/docs/component/aws/nextjs](https://sst.dev/docs/component/aws/nextjs/)
- SST Cloudflare DNS: [sst.dev/docs/component/cloudflare/dns](https://sst.dev/docs/component/cloudflare/dns/)
- AWS Lambda Pricing: [aws.amazon.com/lambda/pricing](https://aws.amazon.com/lambda/pricing/)
- AWS App Runner Pricing: [aws.amazon.com/apprunner/pricing](https://aws.amazon.com/apprunner/pricing/)
- AWS Fargate Pricing: [aws.amazon.com/fargate/pricing](https://aws.amazon.com/fargate/pricing/)
- Bref: [bref.sh](https://bref.sh/)

## Convention
- Ce template formalise le mode de travail recommande pour les projets IT-Akademy bases sur ce socle.
- Si une solution fonctionne, on la formalise dans `recipes/`.
- Si une recette devient recurrente, on en fait un script ou un target `Makefile`.
- Les decisions d'architecture durables vont dans `docs/adr/`.
