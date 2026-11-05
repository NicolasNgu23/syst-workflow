#!/usr/bin/env bash

# Sur un 2e Stop déclenché par ce hook, on laisse finir : sinon une erreur de lint non corrigeable bouclerait sans fin.
if [ "$(jq -r '.stop_hook_active')" = "true" ]; then
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR" || exit 0

if ! output=$(pnpm lint 2>&1); then
  echo "pnpm lint échoue, corrige les erreurs avant de finir :" >&2
  echo "$output" >&2
  # Exit 2 : Claude reçoit stderr et reprend la main au lieu de s'arrêter.
  exit 2
fi
