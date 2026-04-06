# Specs

Ce dossier contient les specifications projet.

## Convention
- Format de nommage: `SPEC-XXX.md`
- Exemple: `SPEC-001.md`, `SPEC-002.md`
- Base de redaction: `SPEC-TEMPLATE.md`
- Generation: `make new-spec TITLE="Titre de la spec"`

## Regle de travail
- Une demande produit ou fonctionnelle importante doit idealement etre convertie en spec avant implementation.
- Une spec doit etre complete, testable, et exploitable sans interpretation floue.
- Si une demande utilisateur contient des zones d'ombre mineures, l'agent peut faire des hypotheses raisonnables et les noter.
- Si une zone d'ombre change le scope, le cout, la securite, ou l'architecture, l'agent doit demander confirmation avant finalisation.

## Contenu attendu
- Contexte
- Objectifs
- Scope
- Exigences fonctionnelles
- Exigences non fonctionnelles
- Architecture proposee
- Critères d'acceptation
- Plan d'implementation
- Risques, hypotheses, questions ouvertes
