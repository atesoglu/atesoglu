#!/usr/bin/env bash
# Resolves a Compose v2 front-end into the COMPOSE array, and the shared file/project
# flags into COMPOSE_ARGS. Sourced by the scripts under scripts/.
#
# podman-compose is deliberately unsupported: it does not implement `up --wait` or
# healthcheck-gated `depends_on`, both of which this stack relies on.

# shellcheck disable=SC2034  # consumed by the scripts that source this file
# --project-directory pins Compose to the repo root, so it picks up .env there and
# resolves the relative paths inside docker/*.yaml from the root as well.
COMPOSE_ARGS=(
    -f docker/compose.observability.yaml
    -f docker/compose.database.yaml
    --project-directory .
    -p dev-resources
)

die() {
    printf '❌ %s\n' "$1" >&2
    exit 1
}

# Points DOCKER_HOST at the rootless Podman API socket, for front-ends that talk to it directly.
require_socket() {
    local sock="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/podman/podman.sock"
    [ -S "$sock" ] || die "Podman API socket not found at ${sock}.
   Start it with:    systemctl --user start podman.socket
   Persist it with:  systemctl --user enable podman.socket && loginctl enable-linger ${USER:-$(id -un)}"
    export DOCKER_HOST="unix://${sock}"
}

resolve_compose() {
    command -v podman >/dev/null 2>&1 || die "podman is not installed or not on PATH."

    export PODMAN_COMPOSE_WARNING_LOGS=false

    if command -v docker-compose >/dev/null 2>&1; then
        # Pinning the provider stops `podman compose` silently falling back to podman-compose.
        export PODMAN_COMPOSE_PROVIDER=docker-compose
        if podman compose version >/dev/null 2>&1; then
            COMPOSE=(podman compose)
            return
        fi
        require_socket
        COMPOSE=(docker-compose)
        return
    fi

    if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
        require_socket
        COMPOSE=(docker compose)
        return
    fi

    die "No Compose v2 front-end found.
   Install the standalone docker-compose binary -- a single static binary that needs
   neither a daemon nor the Docker CLI:  https://github.com/docker/compose/releases
   podman-compose is intentionally NOT supported: it lacks 'up --wait' and
   healthcheck-gated depends_on, which this stack relies on."
}
