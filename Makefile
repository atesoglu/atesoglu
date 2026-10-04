# Entry points for the whole atesoglu toolkit. Run `make` for the list.

.DEFAULT_GOAL := help

.PHONY: help
help: ## Show this help
	@grep -hE '^[a-zA-Z_-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-14s %s\n", $$1, $$2}'

# Go CLI tools
.PHONY: cli-install
cli-install: ## Build and install the Go tools into $$GOBIN
	$(MAKE) -C cli install

.PHONY: cli-build
cli-build: ## Build the Go tools into cli/bin
	$(MAKE) -C cli build

.PHONY: cli-test
cli-test: ## Run the Go tests
	$(MAKE) -C cli test

.PHONY: cli-lint
cli-lint: ## Run Go linters (fmt, vet)
	$(MAKE) -C cli fmt-check
	$(MAKE) -C cli vet

# Docker stack (database + observability)
.PHONY: up
up: ## Start the Docker stack and wait for health
	scripts/start.sh

.PHONY: down
down: ## Stop the stack and DELETE all volumes
	scripts/teardown.sh

.PHONY: status
status: ## Show container status
	scripts/status.sh

.PHONY: logs
logs: ## Follow container logs
	scripts/logs.sh

.PHONY: psql
psql: ## Open a psql shell on the Postgres container
	scripts/psql.sh

.PHONY: backup
backup: ## Dump the database into backups/
	scripts/backup.sh

.PHONY: restore
restore: ## Restore a database dump
	scripts/restore.sh

# Scripts
.PHONY: clean-dotnet
clean-dotnet: ## Delete bin/ and obj/ directories in .NET projects
	scripts/clean-dotnet.sh

.PHONY: rename-files
rename-files: ## Tidy filenames (strip prefixes, underscores to spaces)
	scripts/renamer.sh

# Linting
.PHONY: lint
lint: shell-lint compose-config cli-lint ## Run everything CI runs

.PHONY: shell-lint
shell-lint: ## Syntax-check and ShellCheck every script
	git ls-files '*.sh' | xargs -r -n1 bash -n
	git ls-files '*.sh' | xargs -r shellcheck -x

.PHONY: compose-config
compose-config: ## Validate the Compose files against .env-sample
	docker compose --env-file .env-sample \
		-f docker/compose.observability.yaml -f docker/compose.database.yaml \
		--project-directory . -p dev-resources config --quiet

# Clean
.PHONY: clean
clean: ## Remove build output
	$(MAKE) -C cli clean