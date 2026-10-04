# Entry points for the whole atesoglu toolkit. Run `make` for the list.

.DEFAULT_GOAL := help

.PHONY: help
help: ## Show this help
	@grep -hE '^[a-zA-Z_-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-14s %s\n", $$1, $$2}'

# Go CLI tools
.PHONY: tools-install
tools-install: ## Build and install the Go tools into $$GOBIN
	$(MAKE) -C tools/go install

.PHONY: tools-build
tools-build: ## Build the Go tools into tools/go/bin
	$(MAKE) -C tools/go build

.PHONY: tools-test
tools-test: ## Run the Go tests
	$(MAKE) -C tools/go test

.PHONY: tools-lint
tools-lint: ## Run Go linters (fmt, vet)
	$(MAKE) -C tools/go fmt-check
	$(MAKE) -C tools/go vet

# Docker stack (database + observability)
.PHONY: up
up: ## Start the Docker stack and wait for health
	tools/scripts/start.sh

.PHONY: down
down: ## Stop the stack and DELETE all volumes
	tools/scripts/teardown.sh

.PHONY: status
status: ## Show container status
	tools/scripts/status.sh

.PHONY: logs
logs: ## Follow container logs
	tools/scripts/logs.sh

.PHONY: psql
psql: ## Open a psql shell on the Postgres container
	tools/scripts/psql.sh

.PHONY: backup
backup: ## Dump the database into backups/
	tools/scripts/backup.sh

.PHONY: restore
restore: ## Restore a database dump
	tools/scripts/restore.sh

# Scripts
.PHONY: clean-dotnet
clean-dotnet: ## Delete bin/ and obj/ directories in .NET projects
	tools/scripts/clean-dotnet.sh

.PHONY: rename-files
rename-files: ## Tidy filenames (strip prefixes, underscores to spaces)
	tools/scripts/renamer.sh

# Linting
.PHONY: lint
lint: shell-lint compose-config tools-lint ## Run everything CI runs

.PHONY: shell-lint
shell-lint: ## Syntax-check and ShellCheck every script
	git ls-files '*.sh' | xargs -r -n1 bash -n
	git ls-files '*.sh' | xargs -r shellcheck -x

.PHONY: compose-config
compose-config: ## Validate the Compose files against .env-sample
	docker compose --env-file .env-sample \
		-f tools/docker/compose.observability.yaml -f tools/docker/compose.database.yaml \
		--project-directory . -p dev-resources config --quiet

# Clean
.PHONY: clean
clean: ## Remove build output
	$(MAKE) -C tools/go clean