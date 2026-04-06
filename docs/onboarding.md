# Onboarding

## Objectif

Permettre a un nouveau developpeur de devenir operationnel vite, sans deviner la structure du repo ni ses conventions.

## Ce qu'il faut comprendre en premier

Ce repo est un template AI-first centre execution.

Les regles principales:

- ne pas ajouter de backend si ce n'est pas necessaire
- ne pas ajouter de frontend dynamique si ce n'est pas necessaire
- preferer des scripts deterministes et rejouables
- formaliser les demandes importantes en `SPEC`
- formaliser les decisions durables en `ADR`
- formaliser les solutions rejouables en `recipes`

## Les documents a lire en premier

1. `README.md`
2. `CONTRIBUTING.md`
3. `docs/architecture.md`
4. `docs/workflow.md`
5. `docs/specs.md`
6. `docs/adr/README.md`
7. `docs/testing.md`
8. `docs/release.md`
9. `docs/repository-topology.md`

## Vue rapide du repo

- `apps/`: applications concretes
- `infra/`: infrastructure SST
- `docs/`: documentation de travail
- `specs/`: specifications projet
- `recipes/`: solutions rejouables
- `scripts/`: scripts deterministes et generateurs

## Installation locale

### Prerequis recommandés

- `asdf`
- `direnv`
- `pre-commit`
- `node`
- `python3`
- `php`
- `composer`
- `docker`
- `aws`
- `gh`

### Setup minimum

```bash
cp .env.example .env
make check
npm install
```

### Setup recommande

```bash
asdf plugin add nodejs
asdf plugin add python
asdf plugin add php
asdf install

cp .env.example .env
make setup-env
direnv allow
make check
npm install
make setup-hooks
make install-skills
```

## Premier quart d'heure

1. Lire `README.md`
2. Lancer `make check`
3. Lancer `make validate-env`
4. Lancer `make lint-md`
5. Lire la decision d'architecture principale dans `docs/adr/ADR-001-laravel-api-deploy-target-defaults-to-lambda-bref.md`
6. Lire `docs/testing.md`
7. Ouvrir `specs/` et `recipes/` pour comprendre la logique du repo

## Commandes de base

```bash
make check
make validate-env
make lint
make test
make new-spec TITLE="Titre de la spec"
make new-adr TITLE="Decision d'architecture"
make new-recipe TITLE="Nom de la recipe"
make dev
make changelog
```

## Comment travailler dans ce repo

### Si la demande est une feature ou un besoin produit

- creer ou mettre a jour une spec
- commande utile: `make new-spec TITLE="..."`

### Si la demande implique une decision durable

- creer un ADR
- commande utile: `make new-adr TITLE="..."`

### Si une sequence fonctionne et peut resservir

- la capturer dans `recipes/`
- commande utile: `make new-recipe TITLE="..."`

### Si tu dois choisir la stack

- statique d'abord
- `Next.js` seulement si SSR ou logique front serveur necessaire
- `Laravel` seulement si une vraie API metier est necessaire
- `Lambda + Bref` par defaut pour deployer `Laravel`

## Workflow recommande

1. Comprendre la demande
2. Ecrire la spec si besoin
3. Ecrire l'ADR si la decision est durable
4. Implementer la plus petite tranche utile
5. Valider localement, y compris les tests pertinents
6. Mettre a jour docs, recipe, changelog si necessaire

## Variables d'environnement

- le schema est dans `.env.schema`
- la base est dans `.env.example`
- la validation se fait avec `make validate-env`

## Serveurs locaux

- `make dev`: choisit la meilleure cible locale disponible
- `make dev-static`: sert `apps/web-static`
- `make dev-web`: lance `Next.js`
- `make dev-api`: lance `Laravel Sail`

## Tests

- workflow detaille dans `docs/testing.md`
- `make test` est le point d'entree principal
- `make test-web` et `make test-api` sont utilises quand ces briques existent

## Changelog

- `CHANGELOG.md` peut etre reconstruit avec `make changelog`
- la commande devient utile une fois le repo initialise avec Git
- preferer des commits du style `feat:`, `fix:`, `docs:`, `refactor:`, `chore:`

## Pieges a eviter

- ajouter des couches techniques trop tot
- coder sans spec quand le besoin est encore flou
- prendre une decision d'architecture sans ADR si elle a un impact durable
- deployer une API always-on par defaut alors que le serverless suffit
- laisser une solution utile non documentee

## Definition de "done" dans ce repo

Une tache est proprement terminee si:

- le code fonctionne
- la validation locale a ete faite
- les specs/ADRs/docs ont ete mises a jour si necessaire
- la solution est rejouable

## Besoin d'orientation

Si tu ne sais pas par ou commencer:

1. lire `README.md`
2. lancer `make check`
3. lire `docs/architecture.md`
4. regarder les `SPEC` et `ADR` existants
5. lire `docs/testing.md`
