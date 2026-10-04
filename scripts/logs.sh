#!/usr/bin/env bash
# Usage: scripts/logs.sh [service ...]
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."
# shellcheck source=scripts/lib/compose.sh
source scripts/lib/compose.sh

resolve_compose
"${COMPOSE[@]}" "${COMPOSE_ARGS[@]}" logs --follow --tail 100 "$@"
