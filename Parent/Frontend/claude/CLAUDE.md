# kommit-frontend

Frontend de Kommit : une app React (TypeScript, Vite, Tailwind, shadcn/ui avec Base UI) qui consomme l'API de `kommit-backend`.

## Arborescence

```
kommit-frontend/
├── .claude/
│   ├── CLAUDE.md          # ce fichier
│   ├── rules/             # les conventions du repo
│   └── skills/            # les skills du repo
├── public/                # fichiers servis tels quels (favicon)
├── src/
│   ├── main.tsx           # point d'entrée : monte l'app dans le DOM
│   ├── App.tsx            # providers et écran
│   ├── components/
│   │   ├── ui/            # composants génériques (shadcn)
│   │   └── pages/         # un dossier par écran
│   ├── lib/
│   │   ├── api/           # le seul endroit qui parle au backend
│   │   ├── queryClient.ts # client TanStack Query
│   │   └── utils.ts       # cn(), emplacement imposé par shadcn
│   ├── data/              # textes statiques des écrans
│   ├── types/             # contrat d'API partagé avec le backend
│   └── index.css          # Tailwind + thème shadcn
├── .env.example           # VITE_API_URL, l'URL du backend
├── components.json        # config shadcn
├── index.html
├── package.json
├── tsconfig*.json
└── vite.config.ts
```
