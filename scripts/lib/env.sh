#!/usr/bin/env bash
# Loads .env into the environment. Sourced by the scripts under scripts/.

load_env() {
    [ -f .env ] || {
        printf '❌ %s\n' ".env not found. Run scripts/start.sh first." >&2
        exit 1
    }
    set -a
    # shellcheck disable=SC1091
    source .env
    set +a
}
