#!/usr/bin/env bash
# Usage: scripts/restore.sh <dump-file>
set -euo pipefail

[ $# -eq 1 ] || {
    echo "usage: scripts/restore.sh <dump-file>" >&2
    exit 1
}

# Resolved before the cd below, so a path relative to the caller's cwd still works.
src="$(readlink -f "$1")"
[ -f "$src" ] || {
    echo "❌ No such file: $1" >&2
    exit 1
}

cd "$(dirname "$(readlink -f "$0")")/.."
# shellcheck source=scripts/lib/env.sh
source scripts/lib/env.sh
load_env

echo "⚠️  Restoring into '${POSTGRES_DB:?}'. Existing objects will be dropped."
podman exec -i postgres-db \
    pg_restore -U "${POSTGRES_USER:?}" -d "${POSTGRES_DB:?}" --clean --if-exists <"$src"

echo "✅ Restored from $1"
