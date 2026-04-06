# Apps

Ce dossier contient les briques applicatives uniquement si elles sont utiles.

## Conventions
- `web-static/`: frontend statique optionnel, cree via `make bootstrap-static`
- `web/`: frontend `Next.js` optionnel, cree via `make bootstrap-next`
- `api/`: backend `Laravel` optionnel, cree via `make bootstrap-laravel`

## Regle
- `apps/` reste vide par defaut, hors ce fichier `README.md`
- chaque dossier produit peut etre bootstrappe localement ou monte comme submodule Git
- ne cree pas `web-static/`, `web/` ou `api/` tant qu'il n'y a pas un besoin reel
