#!/usr/bin/env bash
# Usage: scripts/psql.sh [psql args ...]
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."
# shellcheck source=scripts/lib/env.sh
source scripts/lib/env.sh
load_env

exec podman exec -it postgres-db \
    psql -U "${POSTGRES_USER:?}" -d "${POSTGRES_DB:?}" "$@"
