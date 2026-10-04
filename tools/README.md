# Tools

Developer tooling: Go CLI utilities, Docker stacks, and Bash scripts.

## Structure

```
tools/
├── go/        # Go multi-binary CLI module
├── docker/    # Docker Compose stacks (Postgres, Redis, ES, Kibana)
└── scripts/   # Bash utilities for stack ops and file tasks
```

## Quick Start

```bash
# Install Go tools to $GOBIN
make -C tools/go install

# Start Docker stack
make up

# Show available Make targets
make
```

## Go CLI (`tools/go/`)

| Utility | Description |
|---------|-------------|
| `commits` | Fills a date range with empty backdated commits |
| `rename` | Bulk file renaming (placeholder) |

```bash
go run ./tools/go/cmd/commits
go run ./tools/go/cmd/rename
```

See [tools/go/README.md](go/README.md) for details.

## Docker (`tools/docker/`)

Containerised local development stack:

- PostgreSQL 18 — `127.0.0.1:5432`
- Redis 8 — `127.0.0.1:6379`
- Elasticsearch — `127.0.0.1:9200`
- Kibana — `127.0.0.1:5601`

```bash
make up        # Start stack, wait for health, configure Kibana
make status    # Show container status
make logs      # Follow logs
make psql      # Interactive psql
make down      # Stop and DELETE all volumes
```

See [tools/docker/](docker/) for Compose files.

## Scripts (`tools/scripts/`)

Bash utilities for the Docker stack and file operations. All scripts run under `set -euo pipefail` and resolve the repo root themselves.

| Script | Purpose |
|--------|---------|
| `start.sh` | Seed .env, start stack, wait for health, configure Kibana |
| `teardown.sh` | Stop stack — **deletes all volumes** |
| `status.sh` | `compose ps` for the project |
| `logs.sh` | Follow logs (optionally filter by service) |
| `psql.sh` | Interactive `psql` in Postgres container |
| `backup.sh` | `pg_dump -Fc` into git-ignored `backups/` |
| `restore.sh` | Restore a dump; drops existing objects |
| `clean-dotnet.sh` | Delete `bin/` and `obj/` beside `*.*proj` files |
| `renamer.sh` | Tidy filenames: strip prefixes, underscores to spaces |

See [tools/scripts/](scripts/) for the scripts.