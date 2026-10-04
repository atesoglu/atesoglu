#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."
# shellcheck source=scripts/lib/compose.sh
source scripts/lib/compose.sh

resolve_compose
"${COMPOSE[@]}" "${COMPOSE_ARGS[@]}" ps
