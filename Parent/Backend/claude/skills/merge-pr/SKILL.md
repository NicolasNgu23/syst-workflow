---
name: merge-pr
description: Merge la PR de la branche courante, puis passe le ticket Notion de DOING à TO TEST. Fait ces deux choses, et rien d'autre. Utiliser quand l'utilisateur dit "merge la PR", "merge-pr", "merge cette PR", "on merge", après que la PR a été ouverte et relue.
---

## Entrée

- La **PR de la branche courante** (celle ouverte par `open-pr` vers `dev`), que l'utilisateur veut merger maintenant.
- Le **ticket Notion associé**, déduit du nom de branche (`KOM-\d+`), à passer en `TO TEST`.

## Sortie

- La **confirmation du merge**, sous forme de l'**URL de la PR** — qui mène vers l'écran de confirmation du merge.
- La **confirmation que le ticket est passé en `TO TEST`**.

---

## Base Notion (autonome — ne dépend d'aucun autre skill)

- **Base** : Board CCE / Kommit
- **Data Source** : `collection://d840210f-97f9-83d3-a952-0708cec7392c`
- **Propriété ID ticket** : `Ticket ID` (texte, ex. `KOM-06`)
- **Propriété statut** : `Agile Statut` → option cible `TO TEST`

## ⛔️ Garde-fou merge (NON négociable)

La rule `rules/git.md` interdit tout merge sans accord explicite **pour cette PR précise**.

- **L'invocation de ce skill PAR L'UTILISATEUR vaut accord ponctuel pour CE merge-là, et lui seul.**
- Ne jamais déclencher ce skill de toi-même, ni l'enchaîner sur plusieurs PR. Un seul `merge-pr` = une seule PR mergée.
- Au moindre doute sur le fait que l'utilisateur veut merger maintenant → demander avant, ne pas merger.

## Étapes

1. **Merger la PR courante.** `gh pr view --json number,url,state` pour la récupérer. Si aucune PR n'est ouverte pour la branche → stop, le dire. Sinon `gh pr merge --merge --delete-branch`. Si la PR n'est pas mergeable (conflits, checks rouges) → **stop**, expliquer pourquoi, ne pas forcer.
2. **Passer le ticket en `TO TEST`.**
   - Identifier le ticket depuis le nom de branche : extraire le token `KOM-\d+` (ex. `KOM-06-authentification-backend` → `KOM-06`), chercher dans le Board CCE / Kommit le ticket dont `Ticket ID` (texte) vaut ce token exact. Le zéro de tête fait partie de l'identifiant : `KOM-06`, pas `KOM-6`. Charger l'outil Notion via ToolSearch si besoin (`notion-update-page`).
   - Mettre à jour `Agile Statut` → option `TO TEST`.
   - Si le ticket est introuvable ou ambigu → le dire, **sans bloquer** (le merge a réussi) ; ne jamais deviner au hasard.

## Restitution

Une ligne, dans l'ordre des étapes réussies. Ex :
```
✅ PR #42 mergée (branche supprimée) → ticket KOM-06 en TO TEST
```
Si une étape est sautée (ticket introuvable…), le dire explicitement sur la même ligne.

## Anti-patterns

- ❌ Merger sans que l'utilisateur ait invoqué le skill pour CETTE PR.
- ❌ Enchaîner sur une 2e PR dans la foulée.
- ❌ Forcer un merge sur une PR avec conflits ou checks rouges.
- ❌ Passer le ticket en `DONE` : rien n'est validé, il va en `TO TEST`.
- ❌ Bloquer toute la commande si le ticket est introuvable — le merge prime, signaler et finir.
