# Credits

Ce fichier reference les technologies, frameworks, outils et services utilises par ce template ou prepares par defaut pour ses workflows.

## Coeur du template

- `Node.js`
  - runtime principal pour `SST` et les outils JavaScript/TypeScript
  - version locale recommandee: voir `.tool-versions`

- `TypeScript`
  - utilise pour la configuration infra `SST`
  - package: `typescript`

- `Python`
  - utilise pour les scripts deterministes du repo
  - generation de `SPEC`, `ADR`, `recipe`, validation `.env`, changelog, test statique

- `Shell`
  - utilise pour les scripts de bootstrap et d'automatisation locale
  - orchestration simple et rejouable

- `Make`
  - point d'entree unifie pour les commandes locales

## Frontend

- `HTML`
  - utilise dans `apps/web-static/` pour le socle statique du template

- `Next.js`
  - frontend optionnel genere a la demande
  - bootstrap via `scripts/bootstrap-next.sh`

- `Vitest`
  - base de tests preparee lors du bootstrap `Next.js`

- `Testing Library`
  - preparee avec le bootstrap `Next.js` pour les tests frontend

- `jsdom`
  - environnement de test frontend pour `Vitest`

## Backend

- `Laravel`
  - backend optionnel genere a la demande
  - framework API par defaut du template quand un backend est justifie

- `Laravel Sail`
  - environnement Docker local pour Laravel

- `PHP`
  - runtime du backend Laravel
  - version locale recommandee: voir `.tool-versions`

- `MariaDB`
  - base de donnees locale prevue par le bootstrap Laravel

- `Redis`
  - cache / queue store local prevu par le bootstrap Laravel

## Infra et deploiement

- `SST`
  - framework de deploiement et d'infrastructure sur AWS
  - package: `sst`

- `AWS`
  - plateforme de deploiement cible

- `AWS Lambda`
  - cible de deploiement par defaut pour l'API Laravel

- `API Gateway`
  - exposition HTTP associee au mode `Lambda + Bref`

- `Amazon CloudFront`
  - distribution du site statique

- `Amazon S3`
  - hebergement du site statique

- `ECS Fargate`
  - fallback pour l'API Laravel si le mode serverless n'est pas adapte

- `Application Load Balancer`
  - exposition HTTP prevue avec `ECS Fargate`

- `Cloudflare`
  - gestion DNS

- `Bref`
  - integration recommandee pour deployer Laravel sur `AWS Lambda`

## Outils de developpement

- `asdf`
  - gestion recommandee des runtimes locaux

- `direnv`
  - chargement automatique de l'environnement local

- `pre-commit`
  - hooks locaux de qualite

- `ShellCheck`
  - lint shell recommande

- `markdownlint-cli2`
  - lint Markdown du repo

- `yamllint`
  - lint YAML via la configuration `pre-commit`

- `EditorConfig`
  - standardisation du style de base entre editeurs

- `Git`
  - gestion de version locale

- `GitHub CLI`
  - interactions GitHub en local

- `AWS CLI`
  - interactions AWS en local

## Documentation et gouvernance

- `Markdown`
  - format de documentation principal du repo

- `SPEC`
  - format de specification projet du repo

- `ADR`
  - format de decision d'architecture du repo

- `Recipes`
  - format de capitalisation des solutions rejouables

## Fichiers de reference

- `README.md`
- `AGENTS.md`
- `CONTRIBUTING.md`
- `CHANGELOG.md`
- `docs/onboarding.md`
- `docs/architecture.md`
- `docs/testing.md`
- `docs/release.md`
- `docs/specs.md`
- `docs/adr/README.md`

## Notes

- Certaines technologies sont actives des le template initial.
- D'autres sont optionnelles et n'apparaissent qu'apres bootstrap d'une brique `Next.js` ou `Laravel`.
- Ce fichier documente a la fois les dependances presentes et les technologies officiellement supportees par ce template.
