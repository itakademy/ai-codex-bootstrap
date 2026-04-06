# Laravel API on Lambda with Bref

## Contexte
Le produit a besoin d'une vraie logique metier cote serveur, mais il faut rester simple.

## Decision
Generer une API `Laravel` avec environnement Docker local (`MariaDB`, `Redis`) puis deployer par defaut sur `AWS Lambda + API Gateway` via `Bref`.

## Preconditions
- `php`
- `composer`
- `docker`
- compte AWS operationnel

## Commandes
```bash
make bootstrap-laravel
cd apps/api
./vendor/bin/sail up -d
./vendor/bin/sail artisan migrate
```

## Validation
- L'API tourne en local dans Docker
- MariaDB et Redis sont disponibles
- Les migrations passent
- la cible de deploiement retenue est `Lambda + API Gateway` sauf contrainte technique contraire

## Note
Le fallback est `ECS Fargate + ALB` si `Lambda + Bref` n'est pas adapte.
