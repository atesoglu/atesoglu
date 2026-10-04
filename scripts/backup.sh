#!/usr/bin/env bash
# Dumps the Postgres database into ./backups. Useful because teardown.sh destroys volumes.
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."
# shellcheck source=scripts/lib/env.sh
source scripts/lib/env.sh
load_env

mkdir -p backups
out="backups/${POSTGRES_DB:?}-$(date +%Y%m%d-%H%M%S).dump"
podman exec postgres-db pg_dump -U "${POSTGRES_USER:?}" -d "${POSTGRES_DB:?}" -Fc >"$out"

echo "✅ Wrote $out"
