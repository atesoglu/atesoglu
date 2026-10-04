#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."
# shellcheck source=scripts/lib/compose.sh
source scripts/lib/compose.sh

resolve_compose
echo "🔧 Compose front-end: ${COMPOSE[*]}"

if [ ! -f .env ]; then
    echo "📋 .env not found. Creating it from .env-sample..."
    cp .env-sample .env
else
    echo "✅ Existing .env detected. Keeping current configuration."
fi

echo "🚀 Starting infrastructure containers..."
# --wait blocks until every healthcheck passes, so no sleep guessing is needed.
"${COMPOSE[@]}" "${COMPOSE_ARGS[@]}" up -d --wait

echo "⚙️  Configuring the Kibana data view..."
./docker/observability/kibana-setup.sh

echo "✅ All services are up."
