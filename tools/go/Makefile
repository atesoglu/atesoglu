# Builds every binary under cmd/. Adding a tool means adding cmd/<name>/main.go — nothing here
# needs to change.

GO      ?= go
BIN     ?= bin
CMDS    := $(notdir $(wildcard cmd/*))
VERSION ?= $(shell git describe --tags --always --dirty 2>/dev/null || echo dev)
LDFLAGS := -s -w -X main.version=$(VERSION)
GOFLAGS ?=

.DEFAULT_GOAL := help

.PHONY: help
help: ## Show this help
	@grep -hE '^[a-zA-Z_-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-12s %s\n", $$1, $$2}'

.PHONY: all
all: tidy fmt-check vet test build ## Tidy, check formatting, vet, test and build

.PHONY: list
list: ## List the binaries that will be built
	@printf '%s\n' $(CMDS)

.PHONY: build
build: $(addprefix $(BIN)/,$(CMDS)) ## Build every binary into bin/

# FORCE hands the staleness decision to the Go build cache, which is better at it than make.
$(BIN)/%: FORCE
	@mkdir -p $(BIN)
	$(GO) build $(GOFLAGS) -ldflags '$(LDFLAGS)' -o $@ ./cmd/$*

.PHONY: FORCE
FORCE:

.PHONY: install
install: ## Install every binary into $$GOBIN (or $$GOPATH/bin)
	$(GO) install $(GOFLAGS) -ldflags '$(LDFLAGS)' ./cmd/...

.PHONY: test
test: ## Run the tests
	$(GO) test ./...

.PHONY: vet
vet: ## Run go vet
	$(GO) vet ./...

.PHONY: fmt
fmt: ## Format the sources in place
	gofmt -w .

.PHONY: fmt-check
fmt-check: ## Fail if any source is not gofmt-clean
	@unformatted=$$(gofmt -l .); \
	if [ -n "$$unformatted" ]; then \
		echo "not gofmt-clean:"; \
		echo "$$unformatted"; \
		exit 1; \
	fi

.PHONY: tidy
tidy: ## Sync go.mod and go.sum
	$(GO) mod tidy

.PHONY: clean
clean: ## Remove build output
	rm -rf $(BIN)
