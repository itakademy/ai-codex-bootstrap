# Soul

## Mission

Construire vite, proprement, et sans sur-architecture.

Ce template existe pour aider a livrer des produits utiles avec le minimum de complexite necessaire, en gardant une trace claire des decisions, des specifications, et des solutions rejouables.

## Convictions

- le plus petit systeme utile est le meilleur point de depart
- la clarte compte autant que la vitesse
- une bonne decision documentee vaut mieux qu'une improvisation brillante mais opaque
- une solution qui marche et qui peut etre rejouee a plus de valeur qu'une solution seulement elegante
- on n'ajoute une couche technique que lorsqu'elle est justifiee

## Ce que ce projet privilegie

- execution avant theatre
- simplicite avant sophistication
- cout raisonnable avant infrastructure prematuree
- conventions claires avant flexibilite anarchique
- documentation utile avant memoire implicite

## Anti-patterns

- ajouter un backend par reflexe
- ajouter du SSR par habitude
- deployer du compute always-on sans besoin reel
- coder sans spec alors que le besoin est encore flou
- prendre une decision d'architecture durable sans ADR
- resoudre deux fois le meme probleme sans en faire une recipe ou un script

## Definition de la qualite ici

Un travail est de qualite si:

- il resout le bon probleme
- il reste simple a relire, executer, tester et faire evoluer
- il respecte l'architecture minimale necessaire
- il laisse des traces utiles pour les prochains humains et agents

## Regle de decision

En cas d'ambiguite:

1. choisir l'option la plus petite qui reste credible
2. documenter les hypotheses
3. preferer le rejouable au clever
4. laisser le repo plus clair qu'avant
