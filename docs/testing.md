# Testing

## Objectif

Definir un workflow de test simple, pragmatique et evolutif pour ce repo.

## Principes

- tester la plus petite chose utile
- garder les commandes deterministes
- ne pas inventer de couche de test inutile
- brancher les tests au plus pres des briques presentes dans le repo

## Targets disponibles

```bash
make test
make test-static
make test-web
make test-api
```

## Strategie

### Site statique

- commande: `make test-static`
- usage: valider une application statique montee dans `apps/web-static`
- ce test verifie:
  - presence de `apps/web-static/index.html`
  - presence de `apps/web-static/404.html`
  - presence d'une structure HTML minimale
- le bootstrap statique du repo peut creer cette base via `make bootstrap-static`

### Frontend Next.js

- commande: `make test-web`
- usage: quand `apps/web` existe
- comportement:
  - cherche un script `test` dans `apps/web/package.json`
  - l'execute si present
  - echoue explicitement si l'application existe mais n'expose pas encore de commande de test
- le bootstrap `Next.js` du repo prepare une base `Vitest`

### API Laravel

- commande: `make test-api`
- usage: quand `apps/api` existe
- comportement:
  - execute `php artisan test`
  - suppose qu'une application Laravel a deja ete bootstrappee
- le bootstrap `Laravel` du repo ajoute un test de sante applicative

### Test global

- commande: `make test`
- comportement:
  - lance `make test-static` si `apps/web-static` existe
  - lance `make test-web` si `apps/web` existe
  - lance `make test-api` si `apps/api` existe
  - affiche un message explicite si aucune app n'est encore presente

## Workflow recommande

### Avant implementation

- verifier si une spec precise deja les criteres d'acceptation
- sinon, definir ce qui doit etre prouve par les tests

### Pendant implementation

- ajouter ou mettre a jour les tests de la brique concernee
- garder les commandes executables localement

### Avant de terminer

```bash
make check
make validate-env
make lint-md
make test
```

## Regles

- une feature significative doit avoir au moins un mode de validation explicite
- si aucun test automatise n'est possible, la verification manuelle doit etre documentee dans la spec
- les requirements de test doivent rester alignes avec les specs et les criteres d'acceptation
