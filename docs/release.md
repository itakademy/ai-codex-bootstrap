# Release

## Objectif

Definir une procedure simple et fiable pour passer d'un travail local a une livraison propre.

## Principes

- valider avant de deployer
- ne pas deployer une brique qui n'est pas justifiee
- garder la release lisible et rejouable
- documenter les decisions qui ont un impact durable

## Checklist locale

```bash
make check
make validate-env
make lint-md
make test
```

## Checklist de documentation

- la spec est a jour si la demande etait produit ou fonctionnelle
- un ADR existe si une decision durable a ete prise
- une recipe existe si une sequence de travail doit etre rejouee
- le changelog peut etre reconstruit avec `make changelog` si le repo Git est initialise

## Cas 1: release du site statique

Conditions:

- `WEB_MODE=static`
- `apps/web-static` est la cible active

Commande:

```bash
npm run sst:deploy
```

Verification:

- le deploy SST se termine sans erreur
- l'URL CloudFront ou le domaine custom repond

## Cas 2: release du frontend Next.js

Conditions:

- `WEB_MODE=nextjs`
- `apps/web` existe

Commandes:

```bash
make test-web
npm run sst:deploy
```

Verification:

- les tests frontend passent
- le site est joignable apres deploy

## Cas 3: release de l'API Laravel

Conditions:

- `ENABLE_API=true`
- `apps/api` existe
- la strategie de deploy a ete validee par spec ou ADR si necessaire

Commandes minimales:

```bash
make test-api
make validate-env
```

Rappel d'architecture:

- cible par defaut: `Lambda + Bref`
- fallback: `ECS Fargate + ALB`

Verification:

- les tests Laravel passent
- la configuration d'environnement est valide
- la cible choisie est coherente avec l'ADR et la spec

## Git et release

Le workflow de release devient plus propre une fois Git initialise:

```bash
make init-repo
make changelog
```

Commits recommandes:

- `feat:`
- `fix:`
- `docs:`
- `refactor:`
- `chore:`

If product repositories are mounted as Git submodules, make sure the intended submodule pointer updates are visible in `git status` before finalizing the release.

## Definition d'une release propre

Une release est propre si:

- les validations locales sont passees
- les variables d'environnement sont correctes
- la documentation est a jour
- la cible de deploy est coherente avec l'architecture du repo
- la livraison peut etre rejouee
