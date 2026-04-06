# Specifications

## Objectif
Transformer une demande utilisateur en specification exploitable sans flou.

## Emplacement
- Dossier: `specs/`
- Format de nommage: `SPEC-XXX.md`
- Template source: `specs/SPEC-TEMPLATE.md`
- Generation rapide: `make new-spec TITLE="Titre de la spec"`

## Processus de generation d'une SPEC
1. Lire la demande utilisateur et en extraire:
   - le besoin reel
   - les utilisateurs concernes
   - les contraintes explicites
   - les contraintes implicites
   - les livrables attendus
2. Determiner si la demande merite une spec:
   - oui pour une feature, un workflow, une API, un systeme, un module, ou une evolution importante
   - non pour une micro-correction evidente ou une tache triviale
3. Choisir le prochain identifiant disponible `SPEC-XXX`.
4. Generer la base avec `make new-spec TITLE="Titre de la spec"` ou `python3 scripts/new-spec.py --title "..."`
5. Completer chaque section avec des informations concretes et testables.
6. Si des informations manquent:
   - faire des hypotheses raisonnables quand le risque est faible
   - noter ces hypotheses explicitement
   - poser une question seulement si l'impact sur le scope, le cout, la securite, ou l'architecture est significatif
7. Aligner la section architecture avec les standards du repo:
   - frontend statique d'abord
   - `Next.js` seulement si necessaire
   - `Laravel` seulement si necessaire
   - deploiement `SST` sur AWS
   - DNS `Cloudflare`
8. Ajouter des criteres d'acceptation qui permettent de verifier la livraison.
9. Ajouter un plan d'implementation en petites phases executables.

## Definition d'une SPEC complete
Une SPEC est complete si:
- le probleme est clair
- le scope est borne
- les exigences sont testables
- l'architecture cible est explicite
- les risques et hypotheses sont visibles
- l'equipe peut implementer sans re-decouvrir le besoin

## Style attendu
- Markdown simple
- Sections courtes mais concretes
- Pas de vague intentions non testables
- Pas de pseudo-code si une exigence claire suffit
- Pas de solution surdimensionnee

## Exemple de formulation
Au lieu de:
- "Le systeme doit etre rapide"

Preferer:
- "L'API doit repondre en moins de 500 ms p95 sur les endpoints CRUD hors traitements batch"

Au lieu de:
- "L'utilisateur peut gerer son compte"

Preferer:
- "L'utilisateur authentifie peut modifier son nom, son email, et son mot de passe depuis une page profil"
