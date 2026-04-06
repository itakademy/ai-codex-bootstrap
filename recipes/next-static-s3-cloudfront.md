# Next Static on S3 + CloudFront

## Contexte
Un frontend existe mais n'a pas besoin de SSR, de server actions, ni d'API cote serveur.

## Decision
Ne pas deployer `Next.js` runtime. Preferer un frontend statique sur `S3 + CloudFront`.

## Preconditions
- `WEB_MODE=static`
- `APP_DOMAIN` optionnel
- Variables Cloudflare renseignees si le domaine doit etre cree automatiquement

## Commandes
```bash
cp .env.example .env
make check
npm install
npm run sst:deploy
```

## Validation
- Le site statique est servi par CloudFront
- Le domaine custom est configure si Cloudflare est active
- Aucun backend n'est deployee
