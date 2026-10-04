#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."
# shellcheck source=scripts/lib/compose.sh
source scripts/lib/compose.sh

resolve_compose

echo "🧹 Stopping containers and DELETING all volumes (Postgres, Redis, Elasticsearch)..."
"${COMPOSE[@]}" "${COMPOSE_ARGS[@]}" down -v --remove-orphans

echo "✅ Teardown complete. All persisted data has been destroyed."
