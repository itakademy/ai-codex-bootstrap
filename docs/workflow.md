# Workflow

## Boucle de travail
1. Qualifier le besoin.
2. Choisir la plus petite architecture viable.
3. Generer uniquement les briques utiles.
4. Implementer.
5. Verifier.
6. Enregistrer la solution si elle est rejouable.

## Commandes

### Verifier l'environnement
```bash
make check
```

### Ajouter un frontend Next.js
```bash
make bootstrap-next
```

### Ajouter un frontend statique
```bash
make bootstrap-static
```

### Ajouter une API Laravel
```bash
make bootstrap-laravel
```

### Lancer les serveurs locaux
```bash
make dev
make dev-static
make dev-web
make dev-api
```

### Strategie de deploiement API
```bash
# Par defaut
API_DEPLOY_TARGET=lambda-bref

# Fallback si serverless non adapte
API_DEPLOY_TARGET=ecs-fargate
```

### Demarrer SST
```bash
npm run sst:dev
```

### Deployer
```bash
npm run sst:deploy
```

### Sauvegarder une recette
```bash
python3 scripts/save-recipe.py \
  --title "Nom de la solution" \
  --summary "Pourquoi cette solution existe" \
  --command "make check" \
  --command "npm run sst:deploy"
```

## Quand creer une recipe
- Quand une solution a fonctionne en conditions reelles.
- Quand la sequence est utile pour plusieurs projets.
- Quand la meme suite de commandes risque d'etre rejouee.

## Quand creer un script
- Quand une recipe devient stable.
- Quand il faut reduire les erreurs manuelles.
- Quand on veut rendre le workflow plus deterministic.
