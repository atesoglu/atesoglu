### Hey there 👋, I'm Kadir

*I'm crafting software and enjoying what I do.*

Want to have a word? Do not hesitate to contact me.

[![](https://img.shields.io/badge/-LinkedIn-blue?style=flat-square&link=https://www.linkedin.com/in/kadir-atesoglu)](https://www.linkedin.com/in/kadir-atesoglu)
[![](https://img.shields.io/badge/-Medium-black?style=flat-square&link=https://atesoglu.medium.com)](https://atesoglu.medium.com)
<img src="https://komarev.com/ghpvc/?username=atesoglu&style=flat-square&color=2E5BCE" />

---

### 📚 [Knowledge Base](knowledge-base/)

A published collection of my personal and professional notes on software engineering, architecture, career growth, team leadership, and workplace practices.

---

### 🛠️ [Developer Tools](cli/)

Small, self-contained Go CLI utilities for development and automation. Built as a multi-binary Go module.

| Utility | Description |
|---------|-------------|
| `commits` | Fills a date range with empty backdated commits |
| `rename` | Bulk file renaming (placeholder) |

```bash
go run ./cli/cmd/commits
go run ./cli/cmd/rename
# Or install all tools:
make -C cli install
```

---

### 📝 [Prompts](prompts/)

Reusable AI prompts for engineering review, writing, and repository analysis.

- [Repository Review](prompts/repository-review.md) — Principal-level .NET architecture & performance review
- [Technical Companion](prompts/technical-companion.md) — Co-architect for high-performance .NET systems
- [Repository Review (DDD)](prompts/repository-review-ddd.md) — DDD-focused architecture review
- [Repository Investigation](prompts/repository-investigation-prompt.md) — Deep-dive repo analysis
- [DevOps/Cloud Review](prompts/devops-cloud-repository-review.md) — Infrastructure & cloud review
- [Test Integrator](prompts/test-integrator.md) — Testing strategy design
- [Editorial Companion](prompts/editorial-companion.md) — Technical writing co-editor
- [Medium Intellectual](prompts/medium-intellectual-0.md) — Intellectual article style
- [Medium Reviewer](prompts/medium-reviewer-0.md) — Article review persona

---

### 📰 [Editorial](editorial/)

Drafts and notes for technical writing (Medium, blog posts, etc.).

---

### 🐳 [Developer Environment](docker/)

Containerised local development stack: PostgreSQL 18, Redis 8, Elasticsearch, Kibana.

```bash
make up        # Start stack, wait for health, configure Kibana
make status    # Show container status
make logs      # Follow logs
make psql      # Interactive psql
make down      # Stop and DELETE all volumes
```

---

### 📜 [Scripts](scripts/)

Bash utilities for the Docker stack and file operations.

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

All scripts run under `set -euo pipefail` and resolve the repo root themselves.

---

### 📋 Make Targets

```bash
make           # List all targets
make up        # Start Docker stack
make down      # Stop stack + delete volumes
make cli-install  # Install Go tools to $$GOBIN
make lint      # ShellCheck, Compose config, gofmt, go vet
make clean     # Remove build output
```
