# Go CLI Tools

A multi-binary Go module: one module, one binary per directory under `cmd/`.

```text
tools/go/
├── go.mod      # module github.com/atesoglu/atesoglu/tools/go
├── Makefile    # build/install every binary under cmd/
├── cmd/        # one directory per binary
└── internal/   # shared code, importable only from within this module
```

## Adding a Tool

```bash
mkdir -p cmd/mytool
$EDITOR cmd/mytool/main.go   # package main
make list                    # confirms mytool is picked up
```

The [Makefile](Makefile) globs `cmd/*`, so a new directory is built, installed and cleaned with no edit to the build files. CI picks it up for free too.

## Make Targets

Run `make` (or `make help`) for the list.

| Target | Effect |
| --- | --- |
| `make build` | Build every binary into `bin/` (git-ignored) |
| `make install` | `go install ./cmd/...` into `$GOBIN` — puts the tools on `PATH` |
| `make list` | Print the binaries that will be built |
| `make test` / `make vet` | `go test ./...` / `go vet ./...` |
| `make fmt` / `make fmt-check` | Format in place / fail if not gofmt-clean |
| `make tidy` | `go mod tidy` |
| `make clean` | Remove `bin/` |
| `make all` | tidy, fmt-check, vet, test, build |

`make install` from the repo root does the same thing, via the root [Makefile](../../Makefile).

Every build stamps `main.version` from `git describe`, so each binary can report it:

```bash
make build && ./bin/mytool -version
```

Cross-compiling is a `go build` away:

```bash
GOOS=linux GOARCH=amd64 go build -o bin/mytool-linux-amd64 ./cmd/mytool
```

## Conventions

- Keep `main.go` thin: parse flags, then call into `internal/`.
- Return errors up to a `run()` function and let `main` do the single `os.Exit`.
- Exit non-zero on failure and write diagnostics to stderr, so the tools compose with the Bash scripts in [tools/scripts/](../scripts).
- `bin/` and `dist/` are git-ignored.

## Current Tools

| Tool | Description |
|------|-------------|
| `commits` | Backfills a Git repository with empty commits over a date range |
| `rename` | Bulk file renaming utility (placeholder) |