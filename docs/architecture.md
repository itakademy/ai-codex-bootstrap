# Architecture

## Objectif
Fournir une base AI-first qui reste la moins chere possible tant que le produit n'exige pas plus.

## Strategie par defaut
1. Pas de backend.
2. Pas de frontend dynamique.
3. Un site statique deploye sur AWS via SST.
4. Un domaine gere sur Cloudflare.
5. Les briques lourdes ne sont activees qu'en cas de besoin prouve.

## Matrice de decision

### Cas 1: page, landing, dashboard sans SSR
- Choix: `apps/web-static/`
- Deploiement: `sst.aws.StaticSite`
- Cible AWS: `S3 + CloudFront`
- Cout: le plus bas du template

### Cas 2: besoin de SSR, server actions, middleware, auth front complexe
- Choix: `Next.js`
- Generation: `scripts/bootstrap-next.sh`
- Deploiement: `sst.aws.Nextjs`
- Cible AWS: runtime Next.js gere par SST

### Cas 3: besoin d'une vraie API metier
- Choix: `Laravel`
- Generation: `scripts/bootstrap-laravel.sh`
- Local: Docker Compose via Laravel Sail avec `MariaDB` et `Redis`
- Cible AWS par defaut: `AWS Lambda + API Gateway` via `Bref`
- Regle: ne pas deployer l'API tant que le backend n'apporte pas un vrai gain produit

## Strategie de deploiement Laravel

### Cible par defaut
- Compute: `AWS Lambda`
- Edge HTTP: `API Gateway HTTP API`
- Integration Laravel: `Bref`
- DNS: `Cloudflare`

### Pourquoi ce choix
- Le template optimise le cout a vide. `Lambda` facture a la requete et a la duree d'execution, sans service compute permanent.
- `Bref` est la voie la plus standard pour faire tourner `Laravel` sur `AWS Lambda`.
- Cette cible est adaptee aux APIs stateless, aux webhooks, aux cron jobs et aux workers event-driven.

### Quand garder ce mode
- API peu ou moyennement chargee
- Traffic variable ou imprevisible
- Equipe qui veut minimiser l'ops
- Priorite au cout minimal hors trafic

### Quand changer de cible
- Besoin d'un runtime conteneur toujours actif
- Besoin de binaires ou d'extensions PHP non adaptes a Lambda
- Besoin d'un comportement long-running ou tres stateful
- Profil de charge stable et soutenu qui rend le serverless moins interessant

### Fallback
- Compute: `ECS Fargate`
- Exposition: `Application Load Balancer`
- Usage: seulement si la cible `Lambda + Bref` bloque techniquement

### Pourquoi pas App Runner par defaut
- App Runner garde au minimum de la memoire provisionnee tant que le service tourne.
- Ce template cherche d'abord a eliminer le cout idle compute, donc `Lambda` reste le meilleur point de depart.

## DNS
- DNS primaire: `Cloudflare`
- Gestion dans SST: via `sst.cloudflare.dns()` si `CLOUDFLARE_ACCOUNT_ID` et `CLOUDFLARE_ZONE_ID` sont configures
- Prerequis SST: lancer `sst add cloudflare` une fois dans le repo

## Repo layout
- `apps/`: applications concretes
- `infra/`: ressources SST
- `scripts/`: commandes deterministes
- `recipes/`: solutions rejouables
- `docs/`: decisions et mode operatoire

## Regle de cout
- Le mode de base est `WEB_MODE=static`.
- `Next.js` est un opt-in.
- `Laravel` est un opt-in.
- On evite les services always-on tant que le produit peut fonctionner avec du statique ou du serverless.
- Pour `Laravel`, la premiere cible est `Lambda + Bref`, pas un conteneur permanent.
