# kommit-backend

API backend de Kommit : Node.js, Express 5, TypeScript 6, Prisma ORM sur PostgreSQL (Neon). Le frontend vit dans un repo séparé.

## Arborescence

```
kommit-backend/
├── .claude/
│   ├── CLAUDE.md            # ce fichier
│   ├── rules/               # conventions du repo (architecture, fichiers, imports, pnpm, tests)
│   └── skills/
├── prisma/
│   └── schema.prisma        # datasource + generator, sans modèle pour l'instant
├── prisma.config.ts         # config du CLI Prisma (chemin du schéma, DATABASE_URL)
├── src/
│   ├── index.ts             # démarrage du serveur
│   ├── app.ts               # assemblage de l'app Express
│   ├── config/              # variables d'environnement, CORS, nom et version du service
│   ├── middlewares/         # 404, erreurs
│   ├── routes/              # déclaration des routes
│   ├── controllers/         # handlers : requête → service → réponse
│   ├── services/            # logique métier, sans Express
│   └── repositories/        # accès aux données via Prisma (client généré dans generated/, non versionné)
├── .env.example
├── package.json
└── tsconfig.json
```

## Commandes

- `pnpm dev` : serveur en watch, lit `.env`
- `pnpm build` : génère le client Prisma, compile dans `dist/`
- `pnpm start` : lance `dist/`
- `pnpm typecheck`
